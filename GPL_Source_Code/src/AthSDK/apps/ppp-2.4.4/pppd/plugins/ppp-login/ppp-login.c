/***********************************************************************
*
* radius.c
*
* RADIUS plugin for pppd.  Performs PAP, CHAP, MS-CHAP, MS-CHAPv2
* authentication using RADIUS.
*
* Copyright (C) 2002 Roaring Penguin Software Inc.
*
* Based on a patch for ipppd, which is:
*    Copyright (C) 1996, Matjaz Godec <gody@elgo.si>
*    Copyright (C) 1996, Lars Fenneberg <in5y050@public.uni-hamburg.de>
*    Copyright (C) 1997, Miguel A.L. Paraz <map@iphil.net>
*
* Uses radiusclient library, which is:
*    Copyright (C) 1995,1996,1997,1998 Lars Fenneberg <lf@elemental.net>
*    Copyright (C) 2002 Roaring Penguin Software Inc.
*
* MPPE support is by Ralf Hofmann, <ralf.hofmann@elvido.net>, with
* modification from Frank Cusack, <frank@google.com>.
*
* This plugin may be distributed according to the terms of the GNU
* General Public License, version 2 or (at your option) any later version.
*
***********************************************************************/
static char const RCSID[] =
"$Id: ppp-login.c,v 1.3 2008/12/30 14:35:26 fred Exp $";

#include "pppd.h"
#include "chap_ms.h"
#include "chap-new.h"
#include <syslog.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <sys/wait.h>

#define BUF_LEN 1024

#define MD5_HASH_SIZE	16

char pppd_version[] = "2.4.4";

static int call_cmd(const char *cmd)
{
	int status, pret, ret = -1;
	pid_t pid;

	pid = fork();

	if (pid == -1)
		goto out;

	if (pid == 0) {
		execv(cmd, (char *[]){cmd, NULL});
		exit(-1);
	}

	if ((pret = waitpid(pid, &status, 0)) == -1)    /* NO PID RETURN */
		goto out;
	else if (pret == 0)                             /* NO CHILD RETURN */
		goto out;
	else if (WIFEXITED(status))                     /* EXIT NORMALLY */
		ret =  WEXITSTATUS(status);
out:
	return ret;
}

static int ppplogin_pap_auth(char *user,
			   char *passwd,
			   char **msgp,
			   struct wordlist **paddrs,
			   struct wordlist **popts)
{
	char *proto = strcmp(ipparam, "xl2tpd")?"PPTP":"L2TP";

	syslog(LOG_INFO, "ppp-login plugin, user: %s, passwd: %s",
			 user, passwd);

	setenv("USERNAME", user, 1);
	setenv("PASSWORD", passwd, 1);
	setenv("PROTO", proto, 1);

	return (call_cmd("/etc/sysconfig/ppp_login") == 0)?1:0;
}

static int
ppplogin_chap_verify(char *user, char *ourname, int id,
		   struct chap_digest_type *digest,
		   unsigned char *challenge, unsigned char *response,
		   char *message, int message_space)
{
	return 0;
}

static int ppplogin_allowed_address(u_int32_t addr)
{
	return 1;
}

/**********************************************************************
* %FUNCTION: plugin_init
* %ARGUMENTS:
*  None
* %RETURNS:
*  Nothing
* %DESCRIPTION:
*  Initializes RADIUS plugin.
***********************************************************************/
void plugin_init(void)
{
	pap_auth_hook = ppplogin_pap_auth;
	allowed_address_hook = ppplogin_allowed_address;

	chap_verify_hook = ppplogin_chap_verify;

	info("PPP-Login plugin initialized.");
}
