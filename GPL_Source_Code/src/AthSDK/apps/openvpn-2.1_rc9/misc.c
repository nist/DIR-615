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

#include "syshead.h"

#include "buffer.h"
#include "misc.h"
#include "tun.h"
#include "error.h"
#include "thread.h"
#include "otime.h"
#include "plugin.h"
#include "options.h"
#include "manage.h"
#include "crypto.h"
#include "route.h"
#include "win32.h"

#include "memdbg.h"

#ifdef CONFIG_FEATURE_IPROUTE
const char *iproute_path = IPROUTE_PATH; /* GLOBAL */
#endif

/* contains an SSEC_x value defined in misc.h */
int script_security = SSEC_BUILT_IN; /* GLOBAL */

/* Redefine the top level directory of the filesystem
   to restrict access to files for security */
void
do_chroot (const char *path)
{
  if (path)
    {
#ifdef HAVE_CHROOT
      const char *top = "/";
      if (chroot (path))
	msg (M_ERR, "chroot to '%s' failed", path);
      if (openvpn_chdir (top))
	msg (M_ERR, "cd to '%s' failed", top);
      msg (M_INFO, "chroot to '%s' and cd to '%s' succeeded", path, top);
#else
      msg (M_FATAL, "Sorry but I can't chroot to '%s' because this operating system doesn't appear to support the chroot() system call", path);
#endif
    }
}

/* Get/Set UID of process */

bool
get_user (const char *username, struct user_state *state)
{
  bool ret = false;
  CLEAR (*state);
  if (username)
    {
#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
      state->pw = getpwnam (username);
      if (!state->pw)
	msg (M_ERR, "failed to find UID for user %s", username);
      state->username = username;
      ret = true;
#else
      msg (M_FATAL, "Sorry but I can't setuid to '%s' because this operating system doesn't appear to support the getpwname() or setuid() system calls", username);
#endif
    }
  return ret;
}

void
set_user (const struct user_state *state)
{
#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
  if (state->username && state->pw)
    {
      if (setuid (state->pw->pw_uid))
	msg (M_ERR, "setuid('%s') failed", state->username);
      msg (M_INFO, "UID set to %s", state->username);
    }
#endif
}

/* Get/Set GID of process */

bool
get_group (const char *groupname, struct group_state *state)
{
  bool ret = false;
  CLEAR (*state);
  if (groupname)
    {
#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
      state->gr = getgrnam (groupname);
      if (!state->gr)
	msg (M_ERR, "failed to find GID for group %s", groupname);
      state->groupname = groupname;
      ret = true;
#else
      msg (M_FATAL, "Sorry but I can't setgid to '%s' because this operating system doesn't appear to support the getgrnam() or setgid() system calls", groupname);
#endif
    }
  return ret;
}

void
set_group (const struct group_state *state)
{
#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
  if (state->groupname && state->gr)
    {
      if (setgid (state->gr->gr_gid))
	msg (M_ERR, "setgid('%s') failed", state->groupname);
      msg (M_INFO, "GID set to %s", state->groupname);
#ifdef HAVE_SETGROUPS
      {
        gid_t gr_list[1];
	gr_list[0] = state->gr->gr_gid;
	if (setgroups (1, gr_list))
	  msg (M_ERR, "setgroups('%s') failed", state->groupname);
      }
#endif
    }
#endif
}

/* Change process priority */
void
set_nice (int niceval)
{
  if (niceval)
    {
#ifdef HAVE_NICE
      errno = 0;
      nice (niceval);
      if (errno != 0)
	msg (M_WARN | M_ERRNO, "WARNING: nice %d failed", niceval);
      else
	msg (M_INFO, "nice %d succeeded", niceval);
#else
      msg (M_WARN, "WARNING: nice %d failed (function not implemented)", niceval);
#endif
    }
}

/*
 * Pass tunnel endpoint and MTU parms to a user-supplied script.
 * Used to execute the up/down script/plugins.
 */
void
run_up_down (const char *command,
	     const struct plugin_list *plugins,
	     int plugin_type,
	     const char *arg,
	     int tun_mtu,
	     int link_mtu,
	     const char *ifconfig_local,
	     const char* ifconfig_remote,
	     const char *context,
	     const char *signal_text,
	     const char *script_type,
	     struct env_set *es)
{
  struct gc_arena gc = gc_new ();

  if (signal_text)
    setenv_str (es, "signal", signal_text);
  setenv_str (es, "script_context", context);
  setenv_int (es, "tun_mtu", tun_mtu);
  setenv_int (es, "link_mtu", link_mtu);
  setenv_str (es, "dev", arg);

  if (!ifconfig_local)
    ifconfig_local = "";
  if (!ifconfig_remote)
    ifconfig_remote = "";
  if (!context)
    context = "";

  if (plugin_defined (plugins, plugin_type))
    {
      struct argv argv = argv_new ();
      ASSERT (arg);
      argv_printf (&argv,
		   "%s %d %d %s %s %s",
		   arg,
		   tun_mtu, link_mtu,
		   ifconfig_local, ifconfig_remote,
		   context);

      if (plugin_call (plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
	msg (M_FATAL, "ERROR: up/down plugin call failed");

      argv_reset (&argv);
    }

  if (command)
    {
      struct argv argv = argv_new ();
      ASSERT (arg);
      setenv_str (es, "script_type", script_type);
      argv_printf (&argv,
		  "%s %s %d %d %s %s %s",
		  command,
		  arg,
		  tun_mtu, link_mtu,
		  ifconfig_local, ifconfig_remote,
		  context);
      argv_msg (M_INFO, &argv);
      openvpn_execve_check (&argv, es, S_SCRIPT|S_FATAL, "script failed");
      argv_reset (&argv);
    }

  gc_free (&gc);
}

/* Get the file we will later write our process ID to */
void
get_pid_file (const char* filename, struct pid_state *state)
{
  CLEAR (*state);
  if (filename)
    {
      state->fp = fopen (filename, "w");
      if (!state->fp)
	msg (M_ERR, "Open error on pid file %s", filename);
      state->filename = filename;
    }
}

/* Write our PID to a file */
void
write_pid (const struct pid_state *state)
{
  if (state->filename && state->fp)
    {
      unsigned int pid = openvpn_getpid (); 
      fprintf(state->fp, "%u\n", pid);
      if (fclose (state->fp))
	msg (M_ERR, "Close error on pid file %s", state->filename);
    }
}

/* Get current PID */
unsigned int
openvpn_getpid ()
{
#ifdef WIN32
  return (unsigned int) GetCurrentProcessId ();
#else
#ifdef HAVE_GETPID
  return (unsigned int) getpid ();
#else
  return 0;
#endif
#endif
}

/* Disable paging */
void
do_mlockall(bool print_msg)
{
#ifdef HAVE_MLOCKALL
  if (mlockall (MCL_CURRENT | MCL_FUTURE))
    msg (M_WARN | M_ERRNO, "WARNING: mlockall call failed");
  else if (print_msg)
    msg (M_INFO, "mlockall call succeeded");
#else
  msg (M_WARN, "WARNING: mlockall call failed (function not implemented)");
#endif
}

#ifndef HAVE_DAEMON

int
daemon(int nochdir, int noclose)
{
#if defined(HAVE_FORK) && defined(HAVE_SETSID)
  switch (fork())
    {
    case -1:
      return (-1);
    case 0:
      break;
    default:
      openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
    }

  if (setsid() == -1)
    return (-1);

  if (!nochdir)
    openvpn_chdir ("/");

  if (!noclose)
    set_std_files_to_null (false);
#else
  msg (M_FATAL, "Sorry but I can't become a daemon because this operating system doesn't appear to support either the daemon() or fork() system calls");
#endif
  return (0);
}

#endif

/*
 * Set standard file descriptors to /dev/null
 */
void
set_std_files_to_null (bool stdin_only)
{
#if defined(HAVE_DUP) && defined(HAVE_DUP2)
  int fd;
  if ((fd = open ("/dev/null", O_RDWR, 0)) != -1)
    {
      dup2 (fd, 0);
      if (!stdin_only)
	{
	  dup2 (fd, 1);
	  dup2 (fd, 2);
	}
      if (fd > 2)
	close (fd);
    }
#endif
}

/*
 * Wrapper for chdir library function
 */
int
openvpn_chdir (const char* dir)
{
#ifdef HAVE_CHDIR
  return chdir (dir);
#else
  return -1;
#endif
}

/*
 *  dup inetd/xinetd socket descriptor and save
 */

int inetd_socket_descriptor = SOCKET_UNDEFINED; /* GLOBAL */

void
save_inetd_socket_descriptor (void)
{
  inetd_socket_descriptor = INETD_SOCKET_DESCRIPTOR;
#if defined(HAVE_DUP) && defined(HAVE_DUP2)
  /* use handle passed by inetd/xinetd */
  if ((inetd_socket_descriptor = dup (INETD_SOCKET_DESCRIPTOR)) < 0)
    msg (M_ERR, "INETD_SOCKET_DESCRIPTOR dup(%d) failed", INETD_SOCKET_DESCRIPTOR);
  set_std_files_to_null (true);
#endif
}

/*
 * Warn if a given file is group/others accessible.
 */
void
warn_if_group_others_accessible (const char* filename)
{
#ifndef WIN32
#ifdef HAVE_STAT
#if ENABLE_INLINE_FILES
  if (strcmp (filename, INLINE_FILE_TAG))
#endif
    {
      struct stat st;
      if (stat (filename, &st))
	{
	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", filename);
	}
      else
	{
	  if (st.st_mode & (S_IRWXG|S_IRWXO))
	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", filename);
	}
    }
#endif
#endif
}

/*
 * convert system() return into a success/failure value
 */
bool
system_ok (int stat)
{
#ifdef WIN32
  return stat == 0;
#else
  return stat != -1 && WIFEXITED (stat) && WEXITSTATUS (stat) == 0;
#endif
}

/*
 * did system() call execute the given command?
 */
bool
system_executed (int stat)
{
#ifdef WIN32
  return stat != -1;
#else
  return stat != -1 && WEXITSTATUS (stat) != 127;
#endif
}

/*
 * Print an error message based on the status code returned by system().
 */
const char *
system_error_message (int stat, struct gc_arena *gc)
{
  struct buffer out = alloc_buf_gc (256, gc);
#ifdef WIN32
  if (stat == -1)
    buf_printf (&out, "external program did not execute -- ");
  buf_printf (&out, "returned error code %d", stat);
#else
  if (stat == -1)
    buf_printf (&out, "external program fork failed");
  else if (!WIFEXITED (stat))
    buf_printf (&out, "external program did not exit normally");
  else
    {
      const int cmd_ret = WEXITSTATUS (stat);
      if (!cmd_ret)
	buf_printf (&out, "external program exited normally");
      else if (cmd_ret == 127)
	buf_printf (&out, "could not execute external program");
      else
	buf_printf (&out, "external program exited with error status: %d", cmd_ret);
    }
#endif
  return (const char *)out.data;
}

/*
 * Wrapper around openvpn_execve
 */
bool
openvpn_execve_check (const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message)
{
  struct gc_arena gc = gc_new ();
  const int stat = openvpn_execve (a, es, flags);
  int ret = false;

  if (system_ok (stat))
    ret = true;
  else
    {
      if (error_message)
	msg (((flags & S_FATAL) ? M_FATAL : M_WARN), "%s: %s",
	     error_message,
	     system_error_message (stat, &gc));
    }
  gc_free (&gc);
  return ret;
}

bool
openvpn_execve_allowed (const unsigned int flags)
{
  if (flags & S_SCRIPT)
    return script_security >= SSEC_SCRIPTS;
  else
    return script_security >= SSEC_BUILT_IN;
}

#ifndef WIN32
/*
 * Run execve() inside a fork().  Designed to replicate the semantics of system() but
 * in a safer way that doesn't require the invocation of a shell or the risks
 * assocated with formatting and parsing a command line.
 */
int
openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned int flags)
{
  struct gc_arena gc = gc_new ();
  int ret = -1;

  if (a && a->argv[0])
    {
#if defined(ENABLE_EXECVE)
      if (openvpn_execve_allowed (flags))
	{
	  const char *cmd = a->argv[0];
	  char *const *argv = a->argv;
	  char *const *envp = (char *const *)make_env_array (es, true, &gc);
	  pid_t pid;

	  pid = fork ();
	  if (pid == (pid_t)0) /* child side */
	    {
	      execve (cmd, argv, envp);
	      exit (127);
	    }
	  else if (pid < (pid_t)0) /* fork failed */
	    ;
	  else /* parent side */
	    {
	      if (waitpid (pid, &ret, 0) != pid)
		ret = -1;
	    }
	}
      else
	{
	  msg (M_WARN, "openvpn_execve: external program may not be called due to setting of --script-security level");
	}
#else
      msg (M_WARN, "openvpn_execve: execve function not available");
#endif
    }
  else
    {
      msg (M_WARN, "openvpn_execve: called with empty argv");
    }

  gc_free (&gc);
  return ret;
}
#endif

/*
 * Initialize random number seed.  random() is only used
 * when "weak" random numbers are acceptable.
 * OpenSSL routines are always used when cryptographically
 * strong random numbers are required.
 */

void
init_random_seed(void)
{
#ifdef HAVE_GETTIMEOFDAY
  struct timeval tv;

  if (!gettimeofday (&tv, NULL))
    {
      const unsigned int seed = (unsigned int) tv.tv_sec ^ tv.tv_usec;
      srandom (seed);
    }
#else /* HAVE_GETTIMEOFDAY */
  const time_t current = time (NULL);
  srandom ((unsigned int)current);
#endif /* HAVE_GETTIMEOFDAY */
}

/* thread-safe strerror */

const char *
strerror_ts (int errnum, struct gc_arena *gc)
{
#ifdef HAVE_STRERROR
  struct buffer out = alloc_buf_gc (256, gc);

  mutex_lock_static (L_STRERR);
  buf_printf (&out, "%s", openvpn_strerror (errnum, gc));
  mutex_unlock_static (L_STRERR);
  return BSTR (&out);
#else
  return "[error string unavailable]";
#endif
}

/*
 * Set environmental variable (int or string).
 *
 * On Posix, we use putenv for portability,
 * and put up with its painful semantics
 * that require all the support code below.
 */

/* General-purpose environmental variable set functions */

static char *
construct_name_value (const char *name, const char *value, struct gc_arena *gc)
{
  struct buffer out;

  ASSERT (name);
  if (!value)
    value = "";
  out = alloc_buf_gc (strlen (name) + strlen (value) + 2, gc);
  buf_printf (&out, "%s=%s", name, value);
  return BSTR (&out);
}

bool
deconstruct_name_value (const char *str, const char **name, const char **value, struct gc_arena *gc)
{
  char *cp;

  ASSERT (str);
  ASSERT (name && value);

  *name = cp = string_alloc (str, gc);
  *value = NULL;

  while ((*cp))
    {
      if (*cp == '=' && !*value)
	{
	  *cp = 0;
	  *value = cp + 1;
	}
      ++cp;
    }
  return *name && *value;
}

static bool
env_string_equal (const char *s1, const char *s2)
{
  int c1, c2;
  ASSERT (s1);
  ASSERT (s2);

  while (true)
    {
      c1 = *s1++;
      c2 = *s2++;
      if (c1 == '=')
	c1 = 0;
      if (c2 == '=')
	c2 = 0;
      if (!c1 && !c2)
	return true;
      if (c1 != c2)
	break;
    }
  return false;
}

static bool
remove_env_item (const char *str, const bool do_free, struct env_item **list)
{
  struct env_item *current, *prev;

  ASSERT (str);
  ASSERT (list);

  for (current = *list, prev = NULL; current != NULL; current = current->next)
    {
      if (env_string_equal (current->string, str))
	{
	  if (prev)
	    prev->next = current->next;
	  else
	    *list = current->next;
	  if (do_free)
	    {
	      memset (current->string, 0, strlen (current->string));
	      free (current->string);
	      free (current);
	    }
	  return true;
	}
      prev = current;
    }
  return false;
}

static void
add_env_item (char *str, const bool do_alloc, struct env_item **list, struct gc_arena *gc)
{
  struct env_item *item;

  ASSERT (str);
  ASSERT (list);

  ALLOC_OBJ_GC (item, struct env_item, gc);
  item->string = do_alloc ? string_alloc (str, gc): str;
  item->next = *list;
  *list = item;
}

/* struct env_set functions */

static bool
env_set_del_nolock (struct env_set *es, const char *str)
{
  return remove_env_item (str, es->gc == NULL, &es->list);
}

static void
env_set_add_nolock (struct env_set *es, const char *str)
{
  remove_env_item (str, es->gc == NULL, &es->list);  
  add_env_item ((char *)str, true, &es->list, es->gc);
}

struct env_set *
env_set_create (struct gc_arena *gc)
{
  struct env_set *es;
  mutex_lock_static (L_ENV_SET);
  ALLOC_OBJ_CLEAR_GC (es, struct env_set, gc);
  es->list = NULL;
  es->gc = gc;
  mutex_unlock_static (L_ENV_SET);
  return es;
}

void
env_set_destroy (struct env_set *es)
{
  mutex_lock_static (L_ENV_SET);
  if (es && es->gc == NULL)
    {
      struct env_item *e = es->list;
      while (e)
	{
	  struct env_item *next = e->next;
	  free (e->string);
	  free (e);
	  e = next;
	}
      free (es);
    }
  mutex_unlock_static (L_ENV_SET);
}

bool
env_set_del (struct env_set *es, const char *str)
{
  bool ret;
  ASSERT (es);
  ASSERT (str);
  mutex_lock_static (L_ENV_SET);
  ret = env_set_del_nolock (es, str);
  mutex_unlock_static (L_ENV_SET);
  return ret;
}

void
env_set_add (struct env_set *es, const char *str)
{
  ASSERT (es);
  ASSERT (str);
  mutex_lock_static (L_ENV_SET);
  env_set_add_nolock (es, str);
  mutex_unlock_static (L_ENV_SET);
}

void
env_set_print (int msglevel, const struct env_set *es)
{
  if (check_debug_level (msglevel))
    {
      const struct env_item *e;
      int i;

      if (es)
	{
	  mutex_lock_static (L_ENV_SET);
	  e = es->list;
	  i = 0;

	  while (e)
	    {
	      if (env_safe_to_print (e->string))
		msg (msglevel, "ENV [%d] '%s'", i, e->string);
	      ++i;
	      e = e->next;
	    }
	  mutex_unlock_static (L_ENV_SET);
	}
    }
}

void
env_set_inherit (struct env_set *es, const struct env_set *src)
{
  const struct env_item *e;

  ASSERT (es);

  if (src)
    {
      mutex_lock_static (L_ENV_SET);
      e = src->list;
      while (e)
	{
	  env_set_add_nolock (es, e->string);
	  e = e->next;
	}
      mutex_unlock_static (L_ENV_SET);
    }
}

void
env_set_add_to_environment (const struct env_set *es)
{
  if (es)
    {
      struct gc_arena gc = gc_new ();
      const struct env_item *e;

      mutex_lock_static (L_ENV_SET);
      e = es->list;

      while (e)
	{
	  const char *name;
	  const char *value;

	  if (deconstruct_name_value (e->string, &name, &value, &gc))
	    setenv_str (NULL, name, value);

	  e = e->next;
	}
      mutex_unlock_static (L_ENV_SET);
      gc_free (&gc);
    }
}

void
env_set_remove_from_environment (const struct env_set *es)
{
  if (es)
    {
      struct gc_arena gc = gc_new ();
      const struct env_item *e;

      mutex_lock_static (L_ENV_SET);
      e = es->list;

      while (e)
	{
	  const char *name;
	  const char *value;

	  if (deconstruct_name_value (e->string, &name, &value, &gc))
	    setenv_del (NULL, name);

	  e = e->next;
	}
      mutex_unlock_static (L_ENV_SET);
      gc_free (&gc);
    }
}

#ifdef HAVE_PUTENV

/* companion functions to putenv */

static struct env_item *global_env = NULL; /* GLOBAL */

static void
manage_env (char *str)
{
  remove_env_item (str, true, &global_env);
  add_env_item (str, false, &global_env, NULL);
}

#endif

/* add/modify/delete environmental strings */

void
setenv_counter (struct env_set *es, const char *name, counter_type value)
{
  char buf[64];
  openvpn_snprintf (buf, sizeof(buf), counter_format, value);
  setenv_str (es, name, buf);
}

void
setenv_int (struct env_set *es, const char *name, int value)
{
  char buf[64];
  openvpn_snprintf (buf, sizeof(buf), "%d", value);
  setenv_str (es, name, buf);
}

void
setenv_unsigned (struct env_set *es, const char *name, unsigned int value)
{
  char buf[64];
  openvpn_snprintf (buf, sizeof(buf), "%u", value);
  setenv_str (es, name, buf);
}

void
setenv_str (struct env_set *es, const char *name, const char *value)
{
  setenv_str_ex (es, name, value, CC_NAME, 0, 0, CC_PRINT, 0, 0);
}

void
setenv_str_safe (struct env_set *es, const char *name, const char *value)
{
  uint8_t b[64];
  struct buffer buf;
  buf_set_write (&buf, b, sizeof (b));
  if (buf_printf (&buf, "OPENVPN_%s", name))
    setenv_str (es, BSTR(&buf), value);
  else
    msg (M_WARN, "setenv_str_safe: name overflow");
}

void
setenv_del (struct env_set *es, const char *name)
{
  ASSERT (name);
  setenv_str (es, name, NULL);
}

void
setenv_str_ex (struct env_set *es,
	       const char *name,
	       const char *value,
	       const unsigned int name_include,
	       const unsigned int name_exclude,
	       const char name_replace,
	       const unsigned int value_include,
	       const unsigned int value_exclude,
	       const char value_replace)
{
  struct gc_arena gc = gc_new ();
  const char *name_tmp;
  const char *val_tmp = NULL;

  ASSERT (name && strlen (name) > 1);

  name_tmp = string_mod_const (name, name_include, name_exclude, name_replace, &gc);

  if (value)
    val_tmp = string_mod_const (value, value_include, value_exclude, value_replace, &gc);

  if (es)
    {
      if (val_tmp)
	{
	  const char *str = construct_name_value (name_tmp, val_tmp, &gc);
	  env_set_add (es, str);
	  /*msg (M_INFO, "SETENV_ES '%s'", str);*/
	}
      else
	env_set_del (es, name_tmp);
    }
  else
    {
#if defined(WIN32)
      {
	/*msg (M_INFO, "SetEnvironmentVariable '%s' '%s'", name_tmp, val_tmp ? val_tmp : "NULL");*/
	if (!SetEnvironmentVariable (name_tmp, val_tmp))
	  msg (M_WARN | M_ERRNO, "SetEnvironmentVariable failed, name='%s', value='%s'",
	       name_tmp,
	       val_tmp ? val_tmp : "NULL");
      }
#elif defined(HAVE_PUTENV)
      {
	char *str = construct_name_value (name_tmp, val_tmp, NULL);
	int status;

	mutex_lock_static (L_PUTENV);
	status = putenv (str);
	/*msg (M_INFO, "PUTENV '%s'", str);*/
	if (!status)
	  manage_env (str);
	mutex_unlock_static (L_PUTENV);
	if (status)
	  msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
      }
#endif
    }

  gc_free (&gc);
}

/*
 * Setenv functions that append an integer index to the name
 */
static const char *
setenv_format_indexed_name (const char *name, const int i, struct gc_arena *gc)
{
  struct buffer out = alloc_buf_gc (strlen (name) + 16, gc);
  if (i >= 0)
    buf_printf (&out, "%s_%d", name, i);
  else
    buf_printf (&out, "%s", name);
  return BSTR (&out);
}

void
setenv_int_i (struct env_set *es, const char *name, const int value, const int i)
{
  struct gc_arena gc = gc_new ();
  const char *name_str = setenv_format_indexed_name (name, i, &gc);
  setenv_int (es, name_str, value);
  gc_free (&gc);
}

void
setenv_str_i (struct env_set *es, const char *name, const char *value, const int i)
{
  struct gc_arena gc = gc_new ();
  const char *name_str = setenv_format_indexed_name (name, i, &gc);
  setenv_str (es, name_str, value);
  gc_free (&gc);
}

/*
 * taken from busybox networking/ifupdown.c
 */
unsigned int
count_bits(unsigned int a)
{
  unsigned int result;
  result = (a & 0x55) + ((a >> 1) & 0x55);
  result = (result & 0x33) + ((result >> 2) & 0x33);
  return((result & 0x0F) + ((result >> 4) & 0x0F));
}

int
count_netmask_bits(const char *dotted_quad)
{
  unsigned int result, a, b, c, d;
  /* Found a netmask...  Check if it is dotted quad */
  if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) != 4)
    return -1;
  result = count_bits(a);
  result += count_bits(b);
  result += count_bits(c);
  result += count_bits(d);
  return ((int)result);
}

/*
 * Go to sleep for n milliseconds.
 */
void
sleep_milliseconds (unsigned int n)
{
#ifdef WIN32
  Sleep (n);
#else
  struct timeval tv;
  tv.tv_sec = n / 1000;
  tv.tv_usec = (n % 1000) * 1000;
  select (0, NULL, NULL, NULL, &tv);
#endif
}

/*
 * Go to sleep indefinitely.
 */
void
sleep_until_signal (void)
{
#ifdef WIN32
  ASSERT (0);
#else
  select (0, NULL, NULL, NULL, NULL);
#endif
}

/* return true if filename can be opened for read */
bool
test_file (const char *filename)
{
  bool ret = false;
  if (filename)
    {
      FILE *fp = fopen (filename, "r");
      if (fp)
	{
	  fclose (fp);
	  ret = true;
	}
    }

  dmsg (D_TEST_FILE, "TEST FILE '%s' [%d]",
       filename ? filename : "UNDEF",
       ret);

  return ret;
}

#ifdef USE_CRYPTO

/* create a temporary filename in directory */
const char *
create_temp_filename (const char *directory, const char *prefix, struct gc_arena *gc)
{
  static unsigned int counter;
  struct buffer fname = alloc_buf_gc (256, gc);

  mutex_lock_static (L_CREATE_TEMP);
  ++counter;
  mutex_unlock_static (L_CREATE_TEMP);

  {
    uint8_t rndbytes[16];
    const char *rndstr;

    prng_bytes (rndbytes, sizeof (rndbytes));
    rndstr = format_hex_ex (rndbytes, sizeof (rndbytes), 40, 0, NULL, gc);
    buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
  }

  return gen_path (directory, BSTR (&fname), gc);
}

#endif

/*
 * Put a directory and filename together.
 */
const char *
gen_path (const char *directory, const char *filename, struct gc_arena *gc)
{
  const char *safe_filename = string_mod_const (filename, CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT, 0, '_', gc);

  if (safe_filename
      && strcmp (safe_filename, ".")
      && strcmp (safe_filename, "..")
#ifdef WIN32
      && win_safe_filename (safe_filename)
#endif
      )
    {
      const size_t outsize = strlen(safe_filename) + (directory ? strlen (directory) : 0) + 16;
      struct buffer out = alloc_buf_gc (outsize, gc);
      char dirsep[2];

      dirsep[0] = OS_SPECIFIC_DIRSEP;
      dirsep[1] = '\0';

      if (directory)
	buf_printf (&out, "%s%s", directory, dirsep);
      buf_printf (&out, "%s", safe_filename);

      return BSTR (&out);
    }
  else
    return NULL;
}

/* delete a file, return true if succeeded */
bool
delete_file (const char *filename)
{
#if defined(WIN32)
  return (DeleteFile (filename) != 0);
#elif defined(HAVE_UNLINK)
  return (unlink (filename) == 0);
#else
  return false;
#endif
}

bool
absolute_pathname (const char *pathname)
{
  if (pathname)
    {
      const int c = pathname[0];
#ifdef WIN32
      return c == '\\' || (isalpha(c) && pathname[1] == ':' && pathname[2] == '\\');
#else
      return c == '/';
#endif
    }
  else
    return false;
}

/*
 * Return the next largest power of 2
 * or u if u is a power of 2.
 */
unsigned int
adjust_power_of_2 (unsigned int u)
{
  unsigned int ret = 1;

  while (ret < u)
    {
      ret <<= 1;
      ASSERT (ret > 0);
    }

  return ret;
}

#ifdef HAVE_GETPASS

static FILE *
open_tty (const bool write)
{
  FILE *ret;
  ret = fopen ("/dev/tty", write ? "w" : "r");
  if (!ret)
    ret = write ? stderr : stdin;
  return ret;
}

static void
close_tty (FILE *fp)
{
  if (fp != stderr && fp != stdin)
    fclose (fp);
}

#endif

/*
 * Get input from console
 */
bool
get_console_input (const char *prompt, const bool echo, char *input, const int capacity)
{
  bool ret = false;
  ASSERT (prompt);
  ASSERT (input);
  ASSERT (capacity > 0);
  input[0] = '\0';

#if defined(WIN32)
  return get_console_input_win32 (prompt, echo, input, capacity);
#elif defined(HAVE_GETPASS)
  if (echo)
    {
      FILE *fp;

      fp = open_tty (true);
      fprintf (fp, "%s", prompt);
      fflush (fp);
      close_tty (fp);

      fp = open_tty (false);
      if (fgets (input, capacity, fp) != NULL)
	{
	  chomp (input);
	  ret = true;
	}
      close_tty (fp);
    }
  else
    {
      char *gp = getpass (prompt);
      if (gp)
	{
	  strncpynt (input, gp, capacity);
	  memset (gp, 0, strlen (gp));
	  ret = true;
	}
    }
#else
  msg (M_FATAL, "Sorry, but I can't get console input on this OS");
#endif
  return ret;
}

/*
 * Get and store a username/password
 */

bool
get_user_pass (struct user_pass *up,
	       const char *auth_file,
	       const char *prefix,
	       const unsigned int flags)
{
  struct gc_arena gc = gc_new ();

  if (!up->defined)
    {
      const bool from_stdin = (!auth_file || !strcmp (auth_file, "stdin"));

#ifdef ENABLE_MANAGEMENT
      /*
       * Get username/password from standard input?
       */
      if (management
	  && ((auth_file && streq (auth_file, "management")) || (from_stdin && (flags & GET_USER_PASS_MANAGEMENT)))
	  && management_query_user_pass_enabled (management))
	{
	  if (!management_query_user_pass (management, up, prefix, flags))
	    {
	      if ((flags & GET_USER_PASS_NOFATAL) != 0)
		return false;
	      else
		msg (M_FATAL, "ERROR: could not read %s username/password/ok/string from management interface", prefix);
	    }
	}
      else
#endif
      /*
       * Get NEED_OK confirmation from the console
       */
      if (flags & GET_USER_PASS_NEED_OK)
	{
	  struct buffer user_prompt = alloc_buf_gc (128, &gc);

	  buf_printf (&user_prompt, "NEED-OK|%s|%s:", prefix, up->username);
	  
	  if (!get_console_input (BSTR (&user_prompt), true, up->password, USER_PASS_LEN))
	    msg (M_FATAL, "ERROR: could not read %s ok-confirmation from stdin", prefix);
	  
	  if (!strlen (up->password))
	    strcpy (up->password, "ok");
	}
	  
      /*
       * Get username/password from standard input?
       */
      else if (from_stdin)
	{
	  struct buffer user_prompt = alloc_buf_gc (128, &gc);
	  struct buffer pass_prompt = alloc_buf_gc (128, &gc);

	  buf_printf (&user_prompt, "Enter %s Username:", prefix);
	  buf_printf (&pass_prompt, "Enter %s Password:", prefix);

	  if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
	    {
	      if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
		msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
	      if (strlen (up->username) == 0)
		msg (M_FATAL, "ERROR: %s username is empty", prefix);
	    }

	  if (!get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
	    msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
	}
      else
	{
	  /*
	   * Get username/password from a file.
	   */
	  FILE *fp;
      
#ifndef ENABLE_PASSWORD_SAVE
	  /*
	   * Unless ENABLE_PASSWORD_SAVE is defined, don't allow sensitive passwords
	   * to be read from a file.
	   */
	  if (flags & GET_USER_PASS_SENSITIVE)
	    msg (M_FATAL, "Sorry, '%s' password cannot be read from a file", prefix);
#endif

	  warn_if_group_others_accessible (auth_file);

	  fp = fopen (auth_file, "r");
	  if (!fp)
	    msg (M_ERR, "Error opening '%s' auth file: %s", prefix, auth_file);

	  if (flags & GET_USER_PASS_PASSWORD_ONLY)
	    {
	      if (fgets (up->password, USER_PASS_LEN, fp) == NULL)
		msg (M_FATAL, "Error reading password from %s authfile: %s",
		     prefix,
		     auth_file);
	    }
	  else
	    {
	      if (fgets (up->username, USER_PASS_LEN, fp) == NULL
		  || fgets (up->password, USER_PASS_LEN, fp) == NULL)
		msg (M_FATAL, "Error reading username and password (must be on two consecutive lines) from %s authfile: %s",
		     prefix,
		     auth_file);
	    }
      
	  fclose (fp);
      
	  chomp (up->username);
	  chomp (up->password);
      
	  if (!(flags & GET_USER_PASS_PASSWORD_ONLY) && strlen (up->username) == 0)
	    msg (M_FATAL, "ERROR: username from %s authfile '%s' is empty", prefix, auth_file);
	}

      string_mod (up->username, CC_PRINT, CC_CRLF, 0);
      string_mod (up->password, CC_PRINT, CC_CRLF, 0);

      up->defined = true;
    }

#if 0
  msg (M_INFO, "GET_USER_PASS %s u='%s' p='%s'", prefix, up->username, up->password);
#endif

  gc_free (&gc);

  return true;
}

#if AUTO_USERID

static const char *
get_platform_prefix (void)
{
#if defined(TARGET_LINUX)
  return "L";
#elif defined(TARGET_SOLARIS)
  return "S";
#elif defined(TARGET_OPENBSD)
  return "O";
#elif defined(TARGET_DARWIN)
  return "M";
#elif defined(TARGET_NETBSD)
  return "N";
#elif defined(TARGET_FREEBSD)
  return "F";
#elif defined(WIN32)
  return "W";
#else
  return "X";
#endif
}

void
get_user_pass_auto_userid (struct user_pass *up, const char *tag)
{
  struct gc_arena gc = gc_new ();
  MD5_CTX ctx;
  struct buffer buf;
  uint8_t macaddr[6];
  static uint8_t digest [MD5_DIGEST_LENGTH];
  static const uint8_t hashprefix[] = "AUTO_USERID_DIGEST";

  CLEAR (*up);
  buf_set_write (&buf, (uint8_t*)up->username, USER_PASS_LEN);
  buf_printf (&buf, "%s", get_platform_prefix ());
  if (get_default_gateway_mac_addr (macaddr))
    {
      dmsg (D_AUTO_USERID, "GUPAU: macaddr=%s", format_hex_ex (macaddr, sizeof (macaddr), 0, 1, ":", &gc));
      MD5_Init (&ctx);
      MD5_Update (&ctx, hashprefix, sizeof (hashprefix) - 1);
      MD5_Update (&ctx, macaddr, sizeof (macaddr));
      MD5_Final (digest, &ctx);
      buf_printf (&buf, "%s", format_hex_ex (digest, sizeof (digest), 0, 256, " ", &gc));
    }
  else
    {
      buf_printf (&buf, "UNKNOWN");
    }
  if (tag && strcmp (tag, "stdin"))
    buf_printf (&buf, "-%s", tag);
  up->defined = true;
  gc_free (&gc);

  dmsg (D_AUTO_USERID, "GUPAU: AUTO_USERID: '%s'", up->username);
}

#endif

void
purge_user_pass (struct user_pass *up, const bool force)
{
  const bool nocache = up->nocache;
  if (nocache || force)
    {
      CLEAR (*up);
      up->nocache = nocache;
    }
  else
    {
      msg (M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
    }
}

/*
 * Process string received by untrusted peer before
 * printing to console or log file.
 *
 * Assumes that string has been null terminated.
 */
const char *
safe_print (const char *str, struct gc_arena *gc)
{
  return string_mod_const (str, CC_PRINT, CC_CRLF, '.', gc);
}

static bool
is_password_env_var (const char *str)
{
  return (strncmp (str, "password", 8) == 0);
}

bool
env_allowed (const char *str)
{
  return (script_security >= SSEC_PW_ENV || !is_password_env_var (str));
}

bool
env_safe_to_print (const char *str)
{
#ifndef UNSAFE_DEBUG
  if (is_password_env_var (str))
    return false;
#endif
  return true;
}

/* Make arrays of strings */

const char **
make_env_array (const struct env_set *es,
		const bool check_allowed,
		struct gc_arena *gc)
{
  char **ret = NULL;
  struct env_item *e = NULL;
  int i = 0, n = 0;

  /* figure length of es */
  if (es)
    {
      for (e = es->list; e != NULL; e = e->next)
	++n;
    }

  /* alloc return array */
  ALLOC_ARRAY_CLEAR_GC (ret, char *, n+1, gc);

  /* fill return array */
  if (es)
    {
      i = 0;
      for (e = es->list; e != NULL; e = e->next)
	{
	  if (!check_allowed || env_allowed (e->string))
	    {
	      ASSERT (i < n);
	      ret[i++] = e->string;
	    }
	}
    }

  ret[i] = NULL;
  return (const char **)ret;
}

const char **
make_arg_array (const char *first, const char *parms, struct gc_arena *gc)
{
  char **ret = NULL;
  int base = 0;
  const int max_parms = MAX_PARMS + 2;
  int n = 0;

  /* alloc return array */
  ALLOC_ARRAY_CLEAR_GC (ret, char *, max_parms, gc);

  /* process first parameter, if provided */
  if (first)
    {
      ret[base++] = string_alloc (first, gc);
    }

  if (parms)
    {
      n = parse_line (parms, &ret[base], max_parms - base - 1, "make_arg_array", 0, M_WARN, gc);
      ASSERT (n >= 0 && n + base + 1 <= max_parms);
    }
  ret[base + n] = NULL;

  return (const char **)ret;
}

#if ENABLE_INLINE_FILES
static const char **
make_inline_array (const char *str, struct gc_arena *gc)
{
  char line[OPTION_LINE_SIZE];
  struct buffer buf;
  int len = 0;
  char **ret = NULL;
  int i = 0;

  buf_set_read (&buf, (const uint8_t *) str, strlen (str));
  while (buf_parse (&buf, '\n', line, sizeof (line)))
    ++len;

  /* alloc return array */
  ALLOC_ARRAY_CLEAR_GC (ret, char *, len + 1, gc);

  buf_set_read (&buf, (const uint8_t *) str, strlen(str));
  while (buf_parse (&buf, '\n', line, sizeof (line)))
    {
      chomp (line);
      ASSERT (i < len);
      ret[i] = string_alloc (skip_leading_whitespace (line), gc);
      ++i;
    }  
  ASSERT (i <= len);
  ret[i] = NULL;
  return (const char **)ret;
}
#endif

static const char **
make_arg_copy (char **p, struct gc_arena *gc)
{
  char **ret = NULL;
  const int len = string_array_len ((const char **)p);
  const int max_parms = len + 1;
  int i;

  /* alloc return array */
  ALLOC_ARRAY_CLEAR_GC (ret, char *, max_parms, gc);

  for (i = 0; i < len; ++i)
    ret[i] = p[i];

  return (const char **)ret;
}

const char **
make_extended_arg_array (char **p, struct gc_arena *gc)
{
  const int argc = string_array_len ((const char **)p);
#if ENABLE_INLINE_FILES
  if (!strcmp (p[0], INLINE_FILE_TAG) && argc == 2)
    return make_inline_array (p[1], gc);
  else
#endif
  if (argc == 0)
    return make_arg_array (NULL, NULL, gc);
  else if (argc == 1)
    return make_arg_array (p[0], NULL, gc);
  else if (argc == 2)
    return make_arg_array (p[0], p[1], gc);
  else
    return make_arg_copy (p, gc);
}

void
openvpn_sleep (const int n)
{
#ifdef ENABLE_MANAGEMENT
  if (management)
    {
      management_event_loop_n_seconds (management, n);
      return;
    }
#endif
  sleep (n);
}

#if 0
/*
 * Configure PATH.  On Windows, sometimes PATH is not set correctly
 * by default.
 */
void
configure_path (void)
{
#ifdef WIN32
  FILE *fp;
  fp = fopen ("c:\\windows\\system32\\route.exe", "rb");
  if (fp)
    {
      const int bufsiz = 4096;
      struct gc_arena gc = gc_new ();
      struct buffer oldpath = alloc_buf_gc (bufsiz, &gc);
      struct buffer newpath = alloc_buf_gc (bufsiz, &gc);
      const char* delim = ";";
      DWORD status;
      fclose (fp);
      status = GetEnvironmentVariable ("PATH", BPTR(&oldpath), (DWORD)BCAP(&oldpath));
#if 0
      status = 0;
#endif
      if (!status)
	{
	  *BPTR(&oldpath) = '\0';
	  delim = "";
	}
      buf_printf (&newpath, "C:\\WINDOWS\\System32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem%s%s",
		  delim,
		  BSTR(&oldpath));
      SetEnvironmentVariable ("PATH", BSTR(&newpath));
#if 0
      status = GetEnvironmentVariable ("PATH", BPTR(&oldpath), (DWORD)BCAP(&oldpath));
      if (status > 0)
	printf ("PATH: %s\n", BSTR(&oldpath));
#endif
      gc_free (&gc);
    }
#endif
}
#endif

#ifdef ARGV_TEST
void
argv_test (void)
{
  struct gc_arena gc = gc_new ();
  char line[512];
  const char *s;

  struct argv a;
  argv_init (&a);

#ifdef WIN32
  argv_printf (&a, "%s foo bar %s", "c:\\src\\test\\jyargs.exe", "foo bar");
  //argv_printf (&a, "%s %s %s", "c:\\src\\test files\\batargs.bat", "foo", "bar");  
#else
  argv_printf (&a, "./myechox foo bar");
#endif

  argv_msg_prefix (M_INFO, &a, "ARGV");
  openvpn_execve_check (&a, NULL, 0, "command failed");

  argv_printf (&a, "this is a %s test of int %d unsigned %u", "FOO", -69, 42);
  s = argv_str (&a, &gc, PA_BRACKET);
  printf ("%s\n", s);

  {
    struct argv b = argv_insert_head (&a, "MARK");
    s = argv_str (&b, &gc, PA_BRACKET);
    argv_reset (&b);
    printf ("%s\n", s);
  }

  argv_printf (&a, "foo bar %d", 99);
  s = argv_str (&a, &gc, PA_BRACKET);
  argv_reset (&a);
  printf ("%s\n", s);

  s = argv_str (&a, &gc, PA_BRACKET);
  argv_reset (&a);
  printf ("%s\n", s);

  argv_printf (&a, "foo bar %d", 99);
  argv_printf_cat (&a, "bar %d foo", 42);
  argv_printf_cat (&a, "cool %s %d u %s/%d end", "frood", 4, "hello", 7);
  s = argv_str (&a, &gc, PA_BRACKET);
  printf ("%s\n", s);

#if 0
  while (fgets (line, sizeof(line), stdin) != NULL)
    {
      char *term;
      const char *f = line;
      int i = 0;

      while ((term = argv_term (&f)) != NULL) 
	{
	  printf ("[%d] '%s'\n", i, term);
	  ++i;
	  free (term);
	}
    }
#endif

  argv_reset (&a);
  gc_free (&gc);
}
#endif
