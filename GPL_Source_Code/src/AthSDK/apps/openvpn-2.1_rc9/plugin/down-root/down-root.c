/*
 *  OpenVPN -- An application to securely tunnel IP networks
 *             over a single TCP/UDP port, with support for SSL/TLS-based
 *             session authentication and key exchange,
 *             packet encryption, packet authentication, and
 *             packet compression.
 *
 *  Copyright (C) 2002-2008 Telethra, Inc. <sales@openvpn.net>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2
 *  as published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program (see the file COPYING included with this
 *  distribution); if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * OpenVPN plugin module to do privileged down-script execution.
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <signal.h>
#include <syslog.h>

#include "openvpn-plugin.h"

#define DEBUG(verb) ((verb) >= 7)

/* Command codes for foreground -> background communication */
#define COMMAND_RUN_SCRIPT 0
#define COMMAND_EXIT       1

/* Response codes for background -> foreground communication */
#define RESPONSE_INIT_SUCCEEDED   10
#define RESPONSE_INIT_FAILED      11
#define RESPONSE_SCRIPT_SUCCEEDED 12
#define RESPONSE_SCRIPT_FAILED    13

/* Background process function */
static void down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb);

/*
 * Plugin state, used by foreground
 */
struct down_root_context
{
  /* Foreground's socket to background process */
  int foreground_fd;

  /* Process ID of background process */
  pid_t background_pid;

  /* Verbosity level of OpenVPN */
  int verb;

  /* down command */
  char *command;
};

/*
 * Given an environmental variable name, search
 * the envp array for its value, returning it
 * if found or NULL otherwise.
 */
static const char *
get_env (const char *name, const char *envp[])
{
  if (envp)
    {
      int i;
      const int namelen = strlen (name);
      for (i = 0; envp[i]; ++i)
	{
	  if (!strncmp (envp[i], name, namelen))
	    {
	      const char *cp = envp[i] + namelen;
	      if (*cp == '=')
		return cp + 1;
	    }
	}
    }
  return NULL;
}

/*
 * Return the length of a string array
 */
static int
string_array_len (const char *array[])
{
  int i = 0;
  if (array)
    {
      while (array[i])
	++i;
    }
  return i;
}

/*
 * Socket read/write functions.
 */

static int
recv_control (int fd)
{
  unsigned char c;
  const ssize_t size = read (fd, &c, sizeof (c));
  if (size == sizeof (c))
    return c;
  else
    return -1;
}

static int
send_control (int fd, int code)
{
  unsigned char c = (unsigned char) code;
  const ssize_t size = write (fd, &c, sizeof (c));
  if (size == sizeof (c))
    return (int) size;
  else
    return -1;
}

/*
 * Daemonize if "daemon" env var is true.
 * Preserve stderr across daemonization if
 * "daemon_log_redirect" env var is true.
 */
static void
daemonize (const char *envp[])
{
  const char *daemon_string = get_env ("daemon", envp);
  if (daemon_string && daemon_string[0] == '1')
    {
      const char *log_redirect = get_env ("daemon_log_redirect", envp);
      int fd = -1;
      if (log_redirect && log_redirect[0] == '1')
	fd = dup (2);
      if (daemon (0, 0) < 0)
	{
	  fprintf (stderr, "DOWN-ROOT: daemonization failed\n");
	}
      else if (fd >= 3)
	{
	  dup2 (fd, 2);
	  close (fd);
	}
    }
}

/*
 * Close most of parent's fds.
 * Keep stdin/stdout/stderr, plus one
 * other fd which is presumed to be
 * our pipe back to parent.
 * Admittedly, a bit of a kludge,
 * but posix doesn't give us a kind
 * of FD_CLOEXEC which will stop
 * fds from crossing a fork().
 */
static void
close_fds_except (int keep)
{
  int i;
  closelog ();
  for (i = 3; i <= 100; ++i)
    {
      if (i != keep)
	close (i);
    }
}

/*
 * Usually we ignore signals, because our parent will
 * deal with them.
 */
static void
set_signals (void)
{
  signal (SIGTERM, SIG_DFL);

  signal (SIGINT, SIG_IGN);
  signal (SIGHUP, SIG_IGN);
  signal (SIGUSR1, SIG_IGN);
  signal (SIGUSR2, SIG_IGN);
  signal (SIGPIPE, SIG_IGN);
}

/*
 * convert system() return into a success/failure value
 */
int
system_ok (int stat)
{
#ifdef WIN32
  return stat == 0;
#else
  return stat != -1 && WIFEXITED (stat) && WEXITSTATUS (stat) == 0;
#endif
}

static char *
build_command_line (const char *argv[])
{
  int size = 0;
  int n = 0;
  int i;
  char *string;

  /* precompute size */
  if (argv)
    {
      for (i = 0; argv[i]; ++i)
	{
	  size += (strlen (argv[i]) + 1); /* string length plus trailing space */
	  ++n;
	}
    }
  ++size;                                 /* for null terminator */

  /* allocate memory */
  string = (char *) malloc (size);
  if (!string)
    {
      fprintf (stderr, "DOWN-ROOT: out of memory\n");
      exit (1);
    }
  string[0] = '\0';

  /* build string */
  for (i = 0; i < n; ++i)
    {
      strcat (string, argv[i]);
      if (i + 1 < n)
	strcat (string, " ");
    }
  return string;
}

static void
free_context (struct down_root_context *context)
{
  if (context)
    {
      if (context->command)
	free (context->command);
      free (context);
    }
}

OPENVPN_EXPORT openvpn_plugin_handle_t
openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
{
  struct down_root_context *context;

  /*
   * Allocate our context
   */
  context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
  context->foreground_fd = -1;

  /*
   * Intercept the --up and --down callbacks
   */
  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) | OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN);

  /*
   * Make sure we have two string arguments: the first is the .so name,
   * the second is the script command.
   */
  if (string_array_len (argv) < 2)
    {
      fprintf (stderr, "DOWN-ROOT: need down script command\n");
      goto error;
    }

  /*
   * Save our argument in context
   */
  context->command = build_command_line (&argv[1]);

  /*
   * Get verbosity level from environment
   */
  {
    const char *verb_string = get_env ("verb", envp);
    if (verb_string)
      context->verb = atoi (verb_string);
  }

  return (openvpn_plugin_handle_t) context;

 error:
  free_context (context);
  return NULL;
}

OPENVPN_EXPORT int
openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
{
  struct down_root_context *context = (struct down_root_context *) handle;

  if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /* fork off a process to hold onto root */
    {
      pid_t pid;
      int fd[2];

      /*
       * Make a socket for foreground and background processes
       * to communicate.
       */
      if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
	{
	  fprintf (stderr, "DOWN-ROOT: socketpair call failed\n");
	  return OPENVPN_PLUGIN_FUNC_ERROR;
	}

      /*
       * Fork off the privileged process.  It will remain privileged
       * even after the foreground process drops its privileges.
       */
      pid = fork ();

      if (pid)
	{
	  int status;

	  /*
	   * Foreground Process
	   */

	  context->background_pid = pid;

	  /* close our copy of child's socket */
	  close (fd[1]);

	  /* don't let future subprocesses inherit child socket */
	  if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
	    fprintf (stderr, "DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed\n");

	  /* wait for background child process to initialize */
	  status = recv_control (fd[0]);
	  if (status == RESPONSE_INIT_SUCCEEDED)
	    {
	      context->foreground_fd = fd[0];
	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
	    }
	}
      else
	{
	  /*
	   * Background Process
	   */

	  /* close all parent fds except our socket back to parent */
	  close_fds_except (fd[1]);

	  /* Ignore most signals (the parent will receive them) */
	  set_signals ();

	  /* Daemonize if --daemon option is set. */
	  daemonize (envp);

	  /* execute the event loop */
	  down_root_server (fd[1], context->command, argv, envp, context->verb);

	  close (fd[1]);
	  exit (0);
	  return 0; /* NOTREACHED */
	}
    }
  else if (type == OPENVPN_PLUGIN_DOWN && context->foreground_fd >= 0)
    {
      if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
	{
	  fprintf (stderr, "DOWN-ROOT: Error sending script execution signal to background process\n");
	}
      else
	{
	  const int status = recv_control (context->foreground_fd);
	  if (status == RESPONSE_SCRIPT_SUCCEEDED)
	    return OPENVPN_PLUGIN_FUNC_SUCCESS;
	  if (status == -1)
	    fprintf (stderr, "DOWN-ROOT: Error receiving script execution confirmation from background process\n");
	}
    }
  return OPENVPN_PLUGIN_FUNC_ERROR;
}

OPENVPN_EXPORT void
openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
{
  struct down_root_context *context = (struct down_root_context *) handle;

  if (DEBUG (context->verb))
    fprintf (stderr, "DOWN-ROOT: close\n");

  if (context->foreground_fd >= 0)
    {
      /* tell background process to exit */
      if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
	fprintf (stderr, "DOWN-ROOT: Error signaling background process to exit\n");

      /* wait for background process to exit */
      if (context->background_pid > 0)
	waitpid (context->background_pid, NULL, 0);

      close (context->foreground_fd);
      context->foreground_fd = -1;
    }

  free_context (context);
}

OPENVPN_EXPORT void
openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
{
  struct down_root_context *context = (struct down_root_context *) handle;

  if (context->foreground_fd >= 0)
    {
      /* tell background process to exit */
      send_control (context->foreground_fd, COMMAND_EXIT);
      close (context->foreground_fd);
      context->foreground_fd = -1;
    }
}

/*
 * Background process -- runs with privilege.
 */
static void
down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb)
{
  const char *p[3];
  char *command_line = NULL;
  char *argv_cat = NULL;
  int i;

  /*
   * Do initialization
   */
  if (DEBUG (verb))
    fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", command);

  /*
   * Tell foreground that we initialized successfully
   */
  if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
    {
      fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [1]\n");
      goto done;
    }

  /*
   * Build command line
   */
  if (string_array_len (argv) >= 2)
    argv_cat = build_command_line (&argv[1]);
  else
    argv_cat = build_command_line (NULL);
  p[0] = command;
  p[1] = argv_cat;
  p[2] = NULL;
  command_line = build_command_line (p);

  /*
   * Save envp in environment
   */
  for (i = 0; envp[i]; ++i)
    {
      putenv ((char *)envp[i]);
    }

  /*
   * Event loop
   */
  while (1)
    {
      int command_code;
      int status;

      /* get a command from foreground process */
      command_code = recv_control (fd);

      if (DEBUG (verb))
	fprintf (stderr, "DOWN-ROOT: BACKGROUND: received command code: %d\n", command_code);

      switch (command_code)
	{
	case COMMAND_RUN_SCRIPT:
	  status = system (command_line);
	  if (system_ok (status)) /* Succeeded */
	    {
	      if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
		{
		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [2]\n");
		  goto done;
		}
	    }
	  else /* Failed */
	    {
	      if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
		{
		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [3]\n");
		  goto done;
		}
	    }
	  break;

	case COMMAND_EXIT:
	  goto done;

	case -1:
	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: read error on command channel\n");
	  goto done;

	default:
	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: unknown command code: code=%d, exiting\n",
		   command_code);
	  goto done;
	}
    }

 done:
  if (argv_cat)
    free (argv_cat);
  if (command_line)
    free (command_line);
  if (DEBUG (verb))
    fprintf (stderr, "DOWN-ROOT: BACKGROUND: EXIT\n");

  return;
}
