/* config.h.  Generated by configure.  */
/* config.h.in.  Generated from configure.in by autoheader.  */

#ifndef _SUDO_CONFIG_H
#define _SUDO_CONFIG_H

/* Define to 1 if the `syslog' function returns a non-zero int to denote
   failure. */
/* #undef BROKEN_SYSLOG */

/* Define to 1 if you want the insults from the "classic" version sudo. */
/* #undef CLASSIC_INSULTS */

/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
   systems. This function is required for `alloca.c' support on those systems.
   */
/* #undef CRAY_STACKSEG_END */

/* Define to 1 if you want insults culled from the twisted minds of CSOps. */
/* #undef CSOPS_INSULTS */

/* Define to 1 if using `alloca.c'. */
/* #undef C_ALLOCA */

/* Define to 1 if you want sudo to display "command not allowed" instead of
   "command not found" when a command cannot be found. */
/* #undef DONT_LEAK_PATH_INFO */

/* A colon-separated list of pathnames to be used as the editor for visudo. */
#define EDITOR _PATH_VI

/* Define to 1 if you want visudo to honor the EDITOR and VISUAL env
   variables. */
/* #undef ENV_EDITOR */

/* If defined, users in this group need not enter a passwd (ie "sudo"). */
/* #undef EXEMPTGROUP */

/* Define to 1 if you want to require fully qualified hosts in sudoers. */
/* #undef FQDN */

/* Define to 1 if you want insults from the "Goon Show". */
/* #undef GOONS_INSULTS */

/* Define to 1 if you want 2001-like insults. */
/* #undef HAL_INSULTS */

/* Define to 1 if you use AFS. */
/* #undef HAVE_AFS */

/* Define to 1 if you have `alloca', as a function or macro. */
#define HAVE_ALLOCA 1

/* Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
   */
#define HAVE_ALLOCA_H 1

/* Define to 1 if you have the `asprintf' function. */
#define HAVE_ASPRINTF 1

/* Define to 1 if you use AIX general authentication. */
/* #undef HAVE_AUTHENTICATE */

/* Define to 1 if you have the `bigcrypt' function. */
/* #undef HAVE_BIGCRYPT */

/* Define to 1 if you use BSD authentication. */
/* #undef HAVE_BSD_AUTH_H */

/* Define to 1 if you have the `closefrom' function. */
/* #undef HAVE_CLOSEFROM */

/* Define to 1 if you use OSF DCE. */
/* #undef HAVE_DCE */

/* Define to 1 if your `DIR' contains dd_fd. */
/* #undef HAVE_DD_FD */

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the `dirfd' function or macro. */
/* #undef HAVE_DIRFD */

/* Define to 1 if you have the `dispcrypt' function. */
/* #undef HAVE_DISPCRYPT */

/* Define to 1 if you have the <err.h> header file. */
#define HAVE_ERR_H 1

/* Define to 1 if you have the `flock' function. */
/* #undef HAVE_FLOCK */

/* Define to 1 if you have the `fnmatch' function. */
/* #undef HAVE_FNMATCH */

/* Define to 1 if you have the `freeifaddrs' function. */
/* #undef HAVE_FREEIFADDRS */

/* Define to 1 if you have the `fstat' function. */
#define HAVE_FSTAT 1

/* Define to 1 if you have the `futime' function. */
/* #undef HAVE_FUTIME */

/* Define to 1 if you have the `futimes' function. */
/* #undef HAVE_FUTIMES */

/* Define to 1 if you have the `futimesat' function. */
/* #undef HAVE_FUTIMESAT */

/* Define to 1 if you use the FWTK authsrv daemon. */
/* #undef HAVE_FWTK */

/* Define to 1 if you have the `getauthuid' function. (ULTRIX 4.x shadow
   passwords) */
/* #undef HAVE_GETAUTHUID */

/* Define to 1 if you have the `getcwd' function. */
#define HAVE_GETCWD 1

/* Define to 1 if you have the `getdomainname' function. */
/* #undef HAVE_GETDOMAINNAME */

/* Define to 1 if you have the `getifaddrs' function. */
/* #undef HAVE_GETIFADDRS */

/* Define to 1 if you have the `getprogname' function. */
/* #undef HAVE_GETPROGNAME */

/* Define to 1 if you have the `getprpwnam' function. (SecureWare-style shadow
   passwords) */
/* #undef HAVE_GETPRPWNAM */

/* Define to 1 if you have the `getpwanam' function. (SunOS 4.x shadow
   passwords) */
/* #undef HAVE_GETPWANAM */

/* Define to 1 if you have the `getspnam' function (SVR4-style shadow
   passwords) */
#define HAVE_GETSPNAM 1

/* Define to 1 if you have the `getspwuid' function. (HP-UX <= 9.X shadow
   passwords) */
/* #undef HAVE_GETSPWUID */

/* Define to 1 if you have the `gettimeofday' function. */
#define HAVE_GETTIMEOFDAY 1

/* Define to 1 if your Kerberos is Heimdal. */
/* #undef HAVE_HEIMDAL */

/* Define to 1 if you have the `initgroups' function. */
#define HAVE_INITGROUPS 1

/* Define to 1 if you have the `initprivs' function. */
/* #undef HAVE_INITPRIVS */

/* Define to 1 if you have the `innetgr' function. */
/* #undef HAVE_INNETGR */

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define if you have isblank(3). */
#define HAVE_ISBLANK 1

/* Define to 1 if you have the `iscomsec' function. (HP-UX >= 10.x check for
   shadow enabled) */
/* #undef HAVE_ISCOMSEC */

/* Define to 1 if you have the `issecure' function. (SunOS 4.x check for
   shadow enabled) */
/* #undef HAVE_ISSECURE */

/* Define to 1 if you use Kerberos IV. */
/* #undef HAVE_KERB4 */

/* Define to 1 if you use Kerberos V. */
/* #undef HAVE_KERB5 */

/* Define to 1 if your LDAP needs <lber.h>. (OpenLDAP does not) */
/* #undef HAVE_LBER_H */

/* Define to 1 if you use LDAP for sudoers. */
/* #undef HAVE_LDAP */

/* Define to 1 if you have the `ldap_initialize' function. */
/* #undef HAVE_LDAP_INITIALIZE */

/* Define to 1 if you have the `ldap_start_tls_s' function. */
/* #undef HAVE_LDAP_START_TLS_S */

/* Define to 1 if you have the `lockf' function. */
#define HAVE_LOCKF 1

/* Define to 1 if you have the <login_cap.h> header file. */
/* #undef HAVE_LOGIN_CAP_H */

/* Define if your compiler supports the "long long" type. */
#define HAVE_LONG_LONG 1

/* Define to 1 if you have the `lsearch' function. */
#define HAVE_LSEARCH 1

/* Define to 1 if you have the <malloc.h> header file. */
#define HAVE_MALLOC_H 1

/* Define to 1 if you have the `memchr' function. */
#define HAVE_MEMCHR 1

/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `memset' function. */
#define HAVE_MEMSET 1

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* Define to 1 if you have the <netgroup.h> header file. */
/* #undef HAVE_NETGROUP_H */

/* Define to 1 if you use NRL OPIE. */
/* #undef HAVE_OPIE */

/* Define to 1 if you use PAM authentication. */
/* #undef HAVE_PAM */

/* Define to 1 if you have the <pam/pam_appl.h> header file. */
/* #undef HAVE_PAM_PAM_APPL_H */

/* Define to 1 if you have the <paths.h> header file. */
#define HAVE_PATHS_H 1

/* Define if your struct sockadr has an sa_len field. */
/* #undef HAVE_SA_LEN */

/* Define to 1 if you use SecurID for authentication. */
/* #undef HAVE_SECURID */

/* Define to 1 if you have the `seteuid' function. */
#define HAVE_SETEUID 1

/* Define to 1 if you have the `setresuid' function. */
#define HAVE_SETRESUID 1

/* Define to 1 if you have the `setreuid' function. */
/* #undef HAVE_SETREUID */

/* Define to 1 if you have the `setrlimit' function. */
#define HAVE_SETRLIMIT 1

/* Define to 1 if you have the `set_auth_parameters' function. */
/* #undef HAVE_SET_AUTH_PARAMETERS */

/* Define to 1 if you use SIA authentication. */
/* #undef HAVE_SIA */

/* Define to 1 if you have the `sigaction' function. */
#define HAVE_SIGACTION 1

/* Define to 1 if <signal.h> has the sigaction_t typedef. */
/* #undef HAVE_SIGACTION_T */

/* Define to 1 if the system has the type `sig_atomic_t'. */
#define HAVE_SIG_ATOMIC_T 1

/* Define to 1 if you use S/Key. */
/* #undef HAVE_SKEY */

/* Define to 1 if your S/Key library has skeyaccess(). */
/* #undef HAVE_SKEYACCESS */

/* Define to 1 if you have the `snprintf' function. */
#define HAVE_SNPRINTF 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `strcasecmp' function. */
#define HAVE_STRCASECMP 1

/* Define to 1 if you have the `strchr' function. */
#define HAVE_STRCHR 1

/* Define to 1 if you have the `strerror' function. */
#define HAVE_STRERROR 1

/* Define to 1 if you have the `strftime' function. */
#define HAVE_STRFTIME 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the `strlcat' function. */
#define HAVE_STRLCAT 1

/* Define to 1 if you have the `strlcpy' function. */
#define HAVE_STRLCPY 1

/* Define to 1 if you have the `strrchr' function. */
#define HAVE_STRRCHR 1

/* Define to 1 if your struct stat has an st_mtim member */
/* #undef HAVE_ST_MTIM */

/* Define to 1 if your struct stat has an st_mtimespec member */
/* #undef HAVE_ST_MTIMESPEC */

/* Define to 1 if you have the `sysconf' function. */
#define HAVE_SYSCONF 1

/* Define to 1 if you have the <sys/bsdtypes.h> header file. */
/* #undef HAVE_SYS_BSDTYPES_H */

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* Define to 1 if you have the <sys/select.h> header file. */
#define HAVE_SYS_SELECT_H 1

/* Define to 1 if you have the <sys/sockio.h> header file. */
/* #undef HAVE_SYS_SOCKIO_H */

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <termios.h> header file and the `tcgetattr'
   function. */
#define HAVE_TERMIOS_H 1

/* Define to 1 if you have the <termio.h> header file. */
/* #undef HAVE_TERMIO_H */

/* Define to 1 if you have struct timespec in sys/time.h */
#define HAVE_TIMESPEC 1

/* Define to 1 if you have a timespecsub macro or function that takes
   two arguments (not three) */
/* #undef HAVE_TIMESPECSUB2 */

/* Define to 1 if you have the `tzset' function. */
#define HAVE_TZSET 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the `utimes' function. */
#define HAVE_UTIMES 1

/* Define to 1 if you have the <utime.h> header file. */
#define HAVE_UTIME_H 1

/* Define to 1 if you have the `vasprintf' function. */
#define HAVE_VASPRINTF 1

/* Define to 1 if you have the `vsnprintf' function. */
#define HAVE_VSNPRINTF 1

/* Define to 1 if you have the `wait3' function. */
/* #undef HAVE_WAIT3 */

/* Define to 1 if you have the `waitpid' function. */
#define HAVE_WAITPID 1

/* Define to 1 if you have the `_innetgr' function. */
/* #undef HAVE__INNETGR */

/* Define to 1 if your crt0.o defines the __progname symbol for you. */
#define HAVE___PROGNAME 1

/* Define to 1 if you want the hostname to be entered into the log file. */
/* #undef HOST_IN_LOG */

/* Define to 1 if you want to ignore '.' and empty PATH elements */
/* #undef IGNORE_DOT_PATH */

/* The message given when a bad password is entered. */
#define INCORRECT_PASSWORD "Sorry, try again."

/* The syslog facility sudo will use. */
#define LOGFAC "local2"

/* Define to SLOG_SYSLOG, SLOG_FILE, or SLOG_BOTH. */
#define LOGGING SLOG_SYSLOG

/* Define if sizeof(long) == sizeof(long long). */
/* #undef LONG_IS_QUAD */

/* Define to 1 if you want a two line OTP (S/Key or OPIE) prompt. */
/* #undef LONG_OTP_PROMPT */

/* The subject of the mail sent by sudo to the MAILTO user/address. */
#define MAILSUBJECT "*** SECURITY information for %h ***"

/* The user or email address that sudo mail is sent to. */
#define MAILTO "root"

/* The max number of chars per log file line (for line wrapping). */
#define MAXLOGFILELEN 80

/* Define to the max length of a uid_t in string context (excluding the NUL).
   */
#define MAX_UID_T_LEN 

/* Define to 1 if you don't want sudo to prompt for a password by default. */
#define NO_AUTHENTICATION 1

/* Define to 1 if you don't want users to get the lecture the first they user
   sudo. */
#define NO_LECTURE 1

/* Define to avoid runing the mailer as root. */
/* #undef NO_ROOT_MAILER */

/* Define to 1 if root should not be allowed to use sudo. */
/* #undef NO_ROOT_SUDO */

/* Define to avoid using POSIX saved ids. */
/* #undef NO_SAVED_IDS */

/* The default password prompt. */
#define PASSPROMPT "Password:"

/* The passwd prompt timeout (in minutes). */
#define PASSWORD_TIMEOUT 5

/* Define to 1 to replace politically incorrect insults with less offensive
   ones. */
/* #undef PC_INSULTS */

/* The syslog priority sudo will use for unsuccessful attempts/errors. */
#define PRI_FAILURE "alert"

/* The syslog priority sudo will use for successful attempts. */
#define PRI_SUCCESS "notice"

/* Define as the return type of signal handlers (`int' or `void'). */
#define RETSIGTYPE void

/* The user sudo should run commands as by default. */
#define RUNAS_DEFAULT "root"

/* Define to 1 to override the user's path with a built-in one. */
/* #undef SECURE_PATH */

/* Define to 1 to send mail when the user is not allowed to run a command. */
/* #undef SEND_MAIL_WHEN_NOT_OK */

/* Define to 1 to send mail when the user is not allowed to run sudo on this
   host. */
/* #undef SEND_MAIL_WHEN_NO_HOST */

/* Define to 1 to send mail when the user is not in the sudoers file. */
#define SEND_MAIL_WHEN_NO_USER 1

/* Define to 1 if you want sudo to start a shell if given no arguments. */
/* #undef SHELL_IF_NO_ARGS */

/* Define to 1 if you want sudo to set $HOME in shell mode. */
/* #undef SHELL_SETS_HOME */

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at run-time.
        STACK_DIRECTION > 0 => grows toward higher addresses
        STACK_DIRECTION < 0 => grows toward lower addresses
        STACK_DIRECTION = 0 => direction of growth unknown */
/* #undef STACK_DIRECTION */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define to 1 if the code in interfaces.c does not compile for you. */
#define STUB_LOAD_INTERFACES 1

/* The umask that the root-run prog should use. */
#define SUDO_UMASK 0777

/* The number of minutes before sudo asks for a password again. */
#define TIMEOUT 5

/* The number of tries a user gets to enter their password. */
#define TRIES_FOR_PASSWORD 3

/* Define to 1 if you wish to use execv() instead of execvp() when running
   programs. */
/* #undef USE_EXECV */

/* Define to 1 if you want to insult the user for entering an incorrect
   password. */
/* #undef USE_INSULTS */

/* Define to 1 if you use GNU stow packaging. */
/* #undef USE_STOW */

/* Define to 1 if you want a different ticket file for each tty. */
/* #undef USE_TTY_TICKETS */

/* Define to "void" if your compiler supports void pointers, else use "char".
   */
#define VOID void

/* Define to avoid using the passwd/shadow file for authentication. */
/* #undef WITHOUT_PASSWD */

/* Enable non-POSIX extensions on AIX. */
#ifndef _ALL_SOURCE
/* # undef _ALL_SOURCE */
#endif

/* Enable non-POSIX extensions on ConvexOS. */
#ifndef _CONVEX_SOURCE
/* # undef _CONVEX_SOURCE */
#endif

/* Enable GNU extensions on systems that have them. */
#ifndef _GNU_SOURCE
# define _GNU_SOURCE	1
#endif

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define if your system lacks the dev_t type. */
/* #undef dev_t */

/* Define to `int' if <sys/types.h> doesn't define. */
/* #undef gid_t */

/* Define if your system lacks the ino_t type. */
/* #undef ino_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef mode_t */

/* Define to `int' if <signal.h> does not define. */
/* #undef sig_atomic_t */

/* Define if your system lacks the size_t type. */
/* #undef size_t */

/* Define if your system lacks the ssize_t type. */
/* #undef ssize_t */

/* Define to `int' if <sys/types.h> doesn't define. */
/* #undef uid_t */

/* Define to empty if the keyword `volatile' does not work. Warning: valid
   code using `volatile' can become incorrect without. Disable with care. */
/* #undef volatile */

/*
 * Macros to pull sec and nsec parts of mtime from struct stat.
 */
#ifdef HAVE_ST_MTIM
# define mtim_getsec(_x)	((_x).st_mtim.tv_sec)
# define mtim_getnsec(_x)	((_x).st_mtim.tv_nsec)
#else
# ifdef HAVE_ST_MTIMESPEC
#  define mtim_getsec(_x)	((_x).st_mtimespec.tv_sec)
#  define mtim_getnsec(_x)	((_x).st_mtimespec.tv_nsec)
# else
#  define mtim_getsec(_x)	((_x).st_mtime)
#  define mtim_getnsec(_x)	(0)
# endif /* HAVE_ST_MTIMESPEC */
#endif /* HAVE_ST_MTIM */

/*
 * Emulate a subset of waitpid() if we don't have it.
 */
#ifdef HAVE_WAITPID
# define sudo_waitpid(p, s, o)	waitpid(p, s, o)
#else
# ifdef HAVE_WAIT3
#  define sudo_waitpid(p, s, o)	wait3(s, o, NULL)
# endif
#endif

/* GNU stow needs /etc/sudoers to be a symlink. */
#ifdef USE_STOW
# define stat_sudoers	stat
#else
# define stat_sudoers	lstat
#endif

#ifdef USE_EXECV
# define EXECV	execv
#else
# define EXECV	execvp
#endif /* USE_EXECV */

/* Macros to set/clear/test flags. */
/* #undef SET */
#define SET(t, f)	((t) |= (f))
/* #undef CLR */
#define CLR(t, f)	((t) &= ~(f))
/* #undef ISSET */
#define ISSET(t, f)     ((t) & (f))

/* New ANSI-style OS defs for HP-UX and ConvexOS. */
#if defined(hpux) && !defined(__hpux)
# define __hpux		1
#endif /* hpux */

#if defined(convex) && !defined(__convex__)
# define __convex__	1
#endif /* convex */

/* BSD compatibility on some SVR4 systems. */
#ifdef __svr4__
# define BSD_COMP
#endif /* __svr4__ */

#endif /* _SUDO_CONFIG_H */
