/* vi: set sw=4 ts=4: */
/*
 * Mini syslogd implementation for busybox
 *
 * Copyright (C) 1999-2004 by Erik Andersen <andersen@codepoet.org>
 *
 * Copyright (C) 2000 by Karl M. Hegbloom <karlheg@debian.org>
 *
 * "circular buffer" Copyright (C) 2001 by Gennady Feldman <gfeldman@gena01.com>
 *
 * Maintainer: Gennady Feldman <gfeldman@gena01.com> as of Mar 12, 2001
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <netdb.h>
#include <paths.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <time.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/param.h>

#include "busybox.h"

/* SYSLOG_NAMES defined to pull some extra junk from syslog.h */
#define SYSLOG_NAMES
#include <sys/syslog.h>
#include <sys/uio.h>

/*
#include "nvram.h"
*/
/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
*/
#include "sutil.h"


/*
#include "shvar.h"
*/
/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
*/
#include "scmd_nvram.h"

#ifdef AP93
#include "prj_define.h"
#else
#include "shvar.h"
#endif //AP93

/* Path for the file where all log messages are written */
/* Ken modify for used LOG_FILE_HTTP in shvar.h */
//#define __LOG_FILE "/var/log/messages"

int gNumOfUDPEchoPacket=0;
int gNumOfUDPChargenPacket=0;
int gNumOfTCPEchoPacket=0;
int gNumOfTCPChargenPacket=0;
int gNumOfICMPPacket=0;
int gNumOfXmassTressPacket=0;
int gNumOfFINScanPacket=0;
int gNumOfIMAPScanPacket=0;
int gNumOfACKScanPacket=0;
int gNumOfNullScanPacket=0;
int gNumOfRSTScanPacket=0;

char gfirstUDPEchoSec[20]={0};
char gfirstUDPChargenSec[20]={0};
char gfirstTCPEchoSec[20]={0};
char gfirstTCPChargenSec[20]={0};
char gfirstICMPSec[20]={0};

/* Path to the unix socket */
static char lfile[MAXPATHLEN];
static const char *logSockPath = _PATH_LOG;
/* Ken modify for used LOG_FILE_HTTP in shvar.h */
static const char *logFilePath = LOG_FILE_HTTP;

#ifdef CONFIG_FEATURE_ROTATE_LOGFILE
/* max size of message file before being rotated */
static int logFileSize = 200 * 1024;

/* number of rotated message files */
static int logFileRotate = 1;
#endif

/* interval between marks in seconds */
static int MarkInterval = 20 * 60;

/* localhost's name */
static char LocalHostName[64];

#ifdef CONFIG_FEATURE_REMOTE_LOG
#include <netinet/in.h>
/* udp socket for logging to remote host */
static int remotefd = -1;
static struct sockaddr_in remoteaddr;

/* where do we log? */
static char *RemoteHost;

/* what port to log to? */
static int RemotePort = 514;

/* To remote log or not to remote log, that is the question. */
static int doRemoteLog = FALSE;
static int local_logging = FALSE;
#endif

/* Make loging output smaller. */
static bool small = false;


#define MAXLINE         1024	/* maximum line length */
//log type
#define URLBLOCK			0
#define	URLALLOW			1
#define SERVICEBLOCK        2
#define PORTFORWARDING		3
#define PORTTRIGGERING		4
#define DOS		5
//port forwarding
#define STARTPORT			0
#define	ENDPORT				1
//port trigger
#define	PUBLICPORTS			0
#define TRIGGERPORTS        1
/* circular buffer variables/structures */
#ifdef CONFIG_FEATURE_IPC_SYSLOG

#if CONFIG_FEATURE_IPC_SYSLOG_BUFFER_SIZE < 4
#error Sorry, you must set the syslogd buffer size to at least 4KB.
#error Please check CONFIG_FEATURE_IPC_SYSLOG_BUFFER_SIZE
#endif

#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>

/* our shared key */
static const long KEY_ID = 0x414e4547;	/*"GENA" */

// Semaphore operation structures
static struct shbuf_ds {
	int size;			// size of data written
	int head;			// start of message list
	int tail;			// end of message list
	char data[1];		// data/messages
} *buf = NULL;			// shared memory pointer

static struct sembuf SMwup[1] = { {1, -1, IPC_NOWAIT} };	// set SMwup
static struct sembuf SMwdn[3] = { {0, 0}, {1, 0}, {1, +1} };	// set SMwdn

static int shmid = -1;	// ipc shared memory id
static int s_semid = -1;	// ipc semaphore id
static int shm_size = ((CONFIG_FEATURE_IPC_SYSLOG_BUFFER_SIZE)*1024);	// default shm size
static int circular_logging = FALSE;

/*
 * sem_up - up()'s a semaphore.
 */
static inline void sem_up(int semid)
{
	if (semop(semid, SMwup, 1) == -1) {
		bb_perror_msg_and_die("semop[SMwup]");
	}
}

/*
 * sem_down - down()'s a semaphore
 */
static inline void sem_down(int semid)
{
	if (semop(semid, SMwdn, 3) == -1) {
		bb_perror_msg_and_die("semop[SMwdn]");
	}
}


void ipcsyslog_cleanup(void)
{
	printf("Exiting Syslogd!\n");
	if (shmid != -1) {
		shmdt(buf);
	}

	if (shmid != -1) {
		shmctl(shmid, IPC_RMID, NULL);
	}
	if (s_semid != -1) {
		semctl(s_semid, 0, IPC_RMID, 0);
	}
}

void ipcsyslog_init(void)
{
	if (buf == NULL) {
		if ((shmid = shmget(KEY_ID, shm_size, IPC_CREAT | 1023)) == -1) {
			bb_perror_msg_and_die("shmget");
		}

		if ((buf = shmat(shmid, NULL, 0)) == NULL) {
			bb_perror_msg_and_die("shmat");
		}

		buf->size = shm_size - sizeof(*buf);
		buf->head = buf->tail = 0;

		// we'll trust the OS to set initial semval to 0 (let's hope)
		if ((s_semid = semget(KEY_ID, 2, IPC_CREAT | IPC_EXCL | 1023)) == -1) {
			if (errno == EEXIST) {
				if ((s_semid = semget(KEY_ID, 2, 0)) == -1) {
					bb_perror_msg_and_die("semget");
				}
			} else {
				bb_perror_msg_and_die("semget");
			}
		}
	} else {
		printf("Buffer already allocated just grab the semaphore?");
	}
}

/* jimmy added for IPC syslog , log is FULL */
extern int reverse_print_log(char *log,int len,int max_len,FILE *fp){
	if((len >= max_len) || (strlen(log) == 0)){
        return 1;
    }
    reverse_print_log(log+strlen(log)+1,len+strlen(log),max_len,fp);

	/* ignore booting msg */
	if((strstr(log,"gcc version")) || (strstr(log,"Kernel command line: console=")) ||
		(strstr(log,"SCSI subsystem initialized")) || (strstr(log,"cmdlinepart partitions found on")) ||
		(strstr(log,"MTD partitions on")) || (strstr(log,": \"u-boot\"")) ||
		(strstr(log,": \"Config\"")) || (strstr(log,": \"vmlinux\"")) ||
		(strstr(log,": \"rootfs\"")) || (strstr(log,": \"ART\"")) ||
		(strstr(log,"ClusterIP Version"))
	){
		return 1;
	}

    if(fp != NULL)
		fprintf(fp,"%s",log);
	else
		printf("%s",log);
	return 1;
}
/* ----------------------------------------- */

/* write message to buffer */
void circ_message(const char *msg)
{
	int l = strlen(msg) + 1;	/* count the whole message w/ '\0' included */

	sem_down(s_semid);

	/*
	 * Circular Buffer Algorithm:
	 * --------------------------
	 *
	 * Start-off w/ empty buffer of specific size SHM_SIZ
	 * Start filling it up w/ messages. I use '\0' as separator to break up messages.
	 * This is also very handy since we can do printf on message.
	 *
	 * Once the buffer is full we need to get rid of the first message in buffer and
	 * insert the new message. (Note: if the message being added is >1 message then
	 * we will need to "remove" >1 old message from the buffer). The way this is done
	 * is the following:
	 *      When we reach the end of the buffer we set a mark and start from the beginning.
	 *      Now what about the beginning and end of the buffer? Well we have the "head"
	 *      index/pointer which is the starting point for the messages and we have "tail"
	 *      index/pointer which is the ending point for the messages. When we "display" the
	 *      messages we start from the beginning and continue until we reach "tail". If we
	 *      reach end of buffer, then we just start from the beginning (offset 0). "head" and
	 *      "tail" are actually offsets from the beginning of the buffer.
	 *
	 * Note: This algorithm uses Linux IPC mechanism w/ shared memory and semaphores to provide
	 *       a threasafe way of handling shared memory operations.
	 */
	if ((buf->tail + l) < buf->size) {
		/* before we append the message we need to check the HEAD so that we won't
		   overwrite any of the message that we still need and adjust HEAD to point
		   to the next message! */
		if (buf->tail < buf->head) {
			if ((buf->tail + l) >= buf->head) {
				/* we need to move the HEAD to point to the next message
				 * Theoretically we have enough room to add the whole message to the
				 * buffer, because of the first outer IF statement, so we don't have
				 * to worry about overflows here!
				 */
				int k = buf->tail + l - buf->head;	/* we need to know how many bytes
													   we are overwriting to make
													   enough room */
				char *c =
					memchr(buf->data + buf->head + k, '\0',
						   buf->size - (buf->head + k));
				if (c != NULL) {	/* do a sanity check just in case! */
					buf->head = c - buf->data + 1;	/* we need to convert pointer to
													   offset + skip the '\0' since
													   we need to point to the beginning
													   of the next message */
					/* Note: HEAD is only used to "retrieve" messages, it's not used
					   when writing messages into our buffer */
				} else {	/* show an error message to know we messed up? */
					printf("Weird! Can't find the terminator token??? \n");
					buf->head = 0;
				}
			}
		}

		/* in other cases no overflows have been done yet, so we don't care! */
		/* we should be ok to append the message now */
		strncpy(buf->data + buf->tail, msg, l);	/* append our message */
		buf->tail += l;	/* count full message w/ '\0' terminating char */
	} else {
		/* we need to break up the message and "circle" it around */
		char *c;
		int k = buf->tail + l - buf->size;	/* count # of bytes we don't fit */

	/* jimmy added for IPC syslog , log is FULL */
		{
			FILE *fp;//LOG_FILE_FULL
			int i = 0,log_len = 0;
			char *buf_data = NULL;

			i = buf->head;

			if (buf->head == buf->tail || i==buf->tail) {
				printf("<empty syslog>\n");
			}else{
				log_len = buf->tail - i;
				if (log_len < 0)
					log_len += buf->size;
				buf_data = (char *)malloc(log_len);
				if (!buf_data){
					printf("%s, malloc failed !!\n",__FUNCTION__);
				}else{
					if (buf->tail < i) {
						memcpy(buf_data, buf->data+i, buf->size-i);
						memcpy(buf_data+buf->size-i, buf->data, buf->tail);
					} else {
						memcpy(buf_data, buf->data+i, buf->tail-i);
					}

					if((fp = fopen(LOG_FILE_FULL,"w"))!=NULL){
						reverse_print_log(buf_data,0,log_len,fp);
						fclose(fp);
						free(buf_data);
					}
				}
			}
		}
	/* ---------------------------*/
		/* We need to move HEAD! This is always the case since we are going
		 * to "circle" the message.
		 */
		c = memchr(buf->data + k, '\0', buf->size - k);

		if (c != NULL) {	/* if we don't have '\0'??? weird!!! */
			/* move head pointer */
			buf->head = c - buf->data + 1;

			/* now write the first part of the message */
			strncpy(buf->data + buf->tail, msg, l - k - 1);

			/* ALWAYS terminate end of buffer w/ '\0' */
			buf->data[buf->size - 1] = '\0';

			/* now write out the rest of the string to the beginning of the buffer */
			strcpy(buf->data, &msg[l - k - 1]);

			/* we need to place the TAIL at the end of the message */
			buf->tail = k + 1;
		} else {
			printf
				("Weird! Can't find the terminator token from the beginning??? \n");
			buf->head = buf->tail = 0;	/* reset buffer, since it's probably corrupted */
		}

	}
	sem_up(s_semid);
}
/* jimmy added for IPC log
	- when syslogd receiving SIGTERM, dump logs from shared memory to specific file
	- when syslogd starts, read in logs from old file ,if the file exists
*/
/* 
	Note:
		/var/log/message_die_bak is also used in httpd/cmobasicapi.c
		when user clean log via UI, will also remove this file.
*/
#define LOG_FILE_ON_DIE "/var/log/message_die_bak"
void read_die_log(void){
	FILE *fp;
	char buf_tmp[1024];
	if((fp = fopen(LOG_FILE_ON_DIE,"r"))!=NULL){
		while(!feof(fp)){
			fgets(buf_tmp,1024,fp);
			if(!feof(fp))
				circ_message(buf_tmp);
		}
		fclose(fp);
		unlink(LOG_FILE_ON_DIE);
	}
}

/* jimmy added*/
void bak_log_on_die(void)
{
	FILE *fp;//LOG_FILE_ON_DIE
	int i = 0,log_len = 0;
	char *buf_data = NULL;

	i = buf->head;

	if (buf->head == buf->tail || i==buf->tail) {
		printf("<empty syslog>\n");
	}else{
		log_len = buf->tail - i;
		if (log_len < 0)
			log_len += buf->size;
		buf_data = (char *)malloc(log_len);
		if (!buf_data){
			printf("%s, malloc failed !!\n",__FUNCTION__);
		}else{
			if (buf->tail < i) {
				memcpy(buf_data, buf->data+i, buf->size-i);
				memcpy(buf_data+buf->size-i, buf->data, buf->tail);
			} else {
				memcpy(buf_data, buf->data+i, buf->tail-i);
			}

			if((fp = fopen(LOG_FILE_ON_DIE,"w"))!=NULL){
				for (i=0; i < log_len; i+=strlen(buf_data+i)+1) {
					fprintf(fp,"%s", buf_data+i);
				}
				fclose(fp);
			}
			free(buf_data);
		}
	}
}
/* --------------------------------------------------------- */
#endif							/* CONFIG_FEATURE_IPC_SYSLOG */

/* Note: There is also a function called "message()" in init.c */
/* Print a message to the log file. */
static void message(char *fmt, ...) __attribute__ ((format(printf, 1, 2)));
static void message(char *fmt, ...)
{
	int fd;
	struct flock fl;
	va_list arguments;

	fl.l_whence = SEEK_SET;
	fl.l_start = 0;
	fl.l_len = 1;

#ifdef CONFIG_FEATURE_IPC_SYSLOG
	if ((circular_logging == TRUE) && (buf != NULL)) {
		char b[1024];

		va_start(arguments, fmt);
		vsnprintf(b, sizeof(b) - 1, fmt, arguments);
		va_end(arguments);
		circ_message(b);

	} else
#endif
	if ((fd =
			 device_open(logFilePath,
							 O_WRONLY | O_CREAT | O_NOCTTY | O_APPEND |
							 O_NONBLOCK)) >= 0) {
		fl.l_type = F_WRLCK;
		fcntl(fd, F_SETLKW, &fl);
#ifdef CONFIG_FEATURE_ROTATE_LOGFILE
		if ( logFileSize > 0 ) {
			struct stat statf;
			int r = fstat(fd, &statf);
			if( !r && (statf.st_mode & S_IFREG)
				&& (lseek(fd,0,SEEK_END) > logFileSize) ) {
				if(logFileRotate > 0) {
					int i;
					char oldFile[(strlen(logFilePath)+3)], newFile[(strlen(logFilePath)+3)];
					for(i=logFileRotate-1;i>0;i--) {
						sprintf(oldFile, "%s.%d", logFilePath, i-1);
						sprintf(newFile, "%s.%d", logFilePath, i);
						rename(oldFile, newFile);
					}
					sprintf(newFile, "%s.%d", logFilePath, 0);
					fl.l_type = F_UNLCK;
					fcntl (fd, F_SETLKW, &fl);
					close(fd);
					rename(logFilePath, newFile);
					fd = device_open (logFilePath,
						   O_WRONLY | O_CREAT | O_NOCTTY | O_APPEND |
						   O_NONBLOCK);
					fl.l_type = F_WRLCK;
					fcntl (fd, F_SETLKW, &fl);
				} else {
					/* Ken modify for log full check */
					fl.l_type = F_UNLCK;
					fcntl (fd, F_SETLKW, &fl);
					close(fd);
					rename(logFilePath, LOG_FILE_FULL);
					fd = device_open (logFilePath,
						   O_WRONLY | O_CREAT | O_NOCTTY | O_APPEND |
						   O_NONBLOCK);
					fl.l_type = F_WRLCK;
					fcntl (fd, F_SETLKW, &fl);
					ftruncate( fd, 0 );
				}
			}
		}
#endif
		va_start(arguments, fmt);
		vdprintf(fd, fmt, arguments);
		va_end(arguments);
		fl.l_type = F_UNLCK;
		fcntl(fd, F_SETLKW, &fl);
		close(fd);
	} else {
		/* Always send console messages to /dev/console so people will see them. */
		if ((fd =
			 device_open(_PATH_CONSOLE,
						 O_WRONLY | O_NOCTTY | O_NONBLOCK)) >= 0) {
			va_start(arguments, fmt);
			vdprintf(fd, fmt, arguments);
			va_end(arguments);
			close(fd);
		} else {
			fprintf(stderr, "Bummer, can't print: ");
			va_start(arguments, fmt);
			vfprintf(stderr, fmt, arguments);
			fflush(stderr);
			va_end(arguments);
		}
	}
}

#ifdef CONFIG_FEATURE_REMOTE_LOG
static void init_RemoteLog(void)
{
	memset(&remoteaddr, 0, sizeof(remoteaddr));
	remotefd = socket(AF_INET, SOCK_DGRAM, 0);

	if (remotefd < 0) {
		bb_error_msg("cannot create socket");
	}

	remoteaddr.sin_family = AF_INET;
	remoteaddr.sin_addr = *(struct in_addr *) *(xgethostbyname(RemoteHost))->h_addr_list;
	remoteaddr.sin_port = htons(RemotePort);
}
#endif

static void logMessage(int pri, char *msg)
{
	time_t now;
	char *timestamp;
	static char res[20] = "";
	static char local_res[20] = "";
#ifdef CONFIG_FEATURE_REMOTE_LOG	
	static char line[MAXLINE + 1];
#endif
	CODE *c_pri, *c_fac;

	if (pri != 0) {
		for (c_fac = facilitynames;
			 c_fac->c_name && !(c_fac->c_val == LOG_FAC(pri) << 3); c_fac++);
		for (c_pri = prioritynames;
			 c_pri->c_name && !(c_pri->c_val == LOG_PRI(pri)); c_pri++);
		if (c_fac->c_name == NULL || c_pri->c_name == NULL) {
			snprintf(res, sizeof(res), "<%d>", pri);
		} else {
			snprintf(res, sizeof(res), "%s.%s", c_fac->c_name, c_pri->c_name);
			/*NickChou, 07.09.13 if using remote log server, we don't change log format*/
			strcpy(local_res, res);
		}
	}

	if (strlen(msg) < 16 || msg[3] != ' ' || msg[6] != ' ' ||
		msg[9] != ':' || msg[12] != ':' || msg[15] != ' ') {
		time(&now);
		timestamp = ctime(&now) + 4;
		timestamp[15] = '\0';
	} else {
		timestamp = msg;
		timestamp[15] = '\0';
		msg += 16;
	}

	/* todo: supress duplicates */

#ifdef CONFIG_FEATURE_REMOTE_LOG
	if (doRemoteLog == TRUE) {
		/* trying connect the socket */
		if (-1 == remotefd) {
			init_RemoteLog();
		}

		/* if we have a valid socket, send the message */
		if (-1 != remotefd) {
			now = 1;
			snprintf(line, sizeof(line), "<%d>%s", pri, msg);

		retry:
			/* send message to remote logger */
			if(( -1 == sendto(remotefd, line, strlen(line), 0,
							(struct sockaddr *) &remoteaddr,
							sizeof(remoteaddr))) && (errno == EINTR)) {
				/* sleep now seconds and retry (with now * 2) */
				sleep(now);
				now *= 2;
				goto retry;
			}
		}
	}

	if (local_logging == TRUE)
#endif
	{
		/* now spew out the message to wherever it is supposed to go */
		if (small)
			message("%s %s\n", timestamp, msg);
		else
			//message("%s %s %s %s\n", timestamp, LocalHostName, res, msg);
			message("%s %s %s %s\n", timestamp, LocalHostName, local_res, msg);
	}
}

static void quit_signal(int sig)
{
/* jimmy added for IPC syslog */
	bak_log_on_die();
/* ------------- */
	logMessage(LOG_SYSLOG | LOG_INFO, "System log daemon exiting.");
	unlink(lfile);
#ifdef CONFIG_FEATURE_IPC_SYSLOG
	ipcsyslog_cleanup();
#endif

	exit(TRUE);
}

static void domark(int sig)
{
	if (MarkInterval > 0) {
		logMessage(LOG_SYSLOG | LOG_INFO, "-- MARK --");
		alarm(MarkInterval);
	}
}

 static void debug2file(char *name,char *value){
	FILE *fp_debug = NULL;
	char tmp[100] = {};
	fp_debug = fopen("debug.txt","a+");
	if(fp_debug == NULL)
		return;
	sprintf(tmp,"%s%s%s%s",name,"   =   ",value,"\n");	
	fputs(tmp,fp_debug);
	fclose(fp_debug);
}

int check_previous_in_FW_log(char *serach_log)
{
	FILE *fp;
	char temp[1024]={};
	char log_content[1024]={0};
	fp = fopen(LOG_FILE,"r");
	if(fp == NULL)
		printf("file does not exist!\n");
	else
	{

			while(fgets(temp,1024,fp))
			{
				if(strstr(temp,serach_log))
					return 0;
			}
	}
	fclose(fp);
	return 1;
}
int check_previous(char *block_site_address,char *client_ip_address,int type)
{
	FILE *fp;
	char temp[1024]={};
	char log_content[1024]={0};
	fp = fopen("/var/log/messages","r");
	if(fp == NULL)
		printf("file does not exist!\n");
	else
	{
		if(type == URLBLOCK)
		{
			while(fgets(temp,1024,fp))
			{
				sprintf(log_content,"Blocked Site=%s",block_site_address);
				if(strstr(temp,log_content))
					return 0;
			}
		}
		if(type == URLALLOW)
        {
            while(fgets(temp,1024,fp))
            {
                sprintf(log_content,"Allowed Site==%s",block_site_address);
                if(strstr(temp,log_content))
                    return 0;
            }
        }
		if(type == SERVICEBLOCK)
        {
            while(fgets(temp,1024,fp))
            {
                sprintf(log_content,"Blocked Service=%s",block_site_address);
                if(strstr(temp,log_content))
                    return 0;
            }
        }
		if(type == PORTFORWARDING)
        {
            while(fgets(temp,1024,fp))
            {
                sprintf(log_content,"Port Forwarding=%s",block_site_address);
                if(strstr(temp,log_content))
                    return 0;
            }
        }
		if(type == PORTTRIGGERING)
        {
            while(fgets(temp,1024,fp))
            {
                sprintf(log_content,"Port Triggering=%s",block_site_address);
                if(strstr(temp,log_content))
                    return 0;
            }
        }


	}
	fclose(fp);
	return 1;
}

char *return_block_services_name(char *nvram_value)
{
	char temp_value[256]={};
	char *enable,*name;

	strcpy(temp_value,nvram_value);
	enable = strtok(temp_value,"/");
	name = strtok(NULL,"/");
	return name;
}

char *retunr_port_forwarding(char *nvram_value, int type)
{
	char temp_value[256]={};
	char *enable,*name,*proto,*start_port,*end_port;
	strcpy(temp_value,nvram_value);
	enable = strtok(temp_value,"/");
    name = strtok(NULL,"/");
	proto = strtok(NULL,"/");
	start_port = strtok(NULL,"/");
	end_port = strtok(NULL,"/");
	if(type == STARTPORT)
		return start_port;
	if(type == ENDPORT)
		return end_port;
}

char *retunr_port_trigger(char *nvram_value, int type)
{
    char temp_value[256]={};
    char *enable,*name,*trigger_proto,*trigger_ports,*public_porto,*public_ports;
    strcpy(temp_value,nvram_value);
    enable = strtok(temp_value,"/");
    name = strtok(NULL,"/");
    trigger_proto = strtok(NULL,"/");
    trigger_ports = strtok(NULL,"/");
    public_porto = strtok(NULL,"/");
	public_ports = strtok(NULL,"/");
    if(type == PUBLICPORTS)
        return public_ports;
    if(type == TRIGGERPORTS)
        return trigger_ports;
}

int check_router_forward_func(void)
{
	FILE *fp;
	char *buff;
	int return_status = 0;

	_system("iptables -t nat -n -L PREROUTING > /var/tmp/ip_prerout_table");
	fp = fopen ("/var/tmp/ip_prerout_table", "r");
	if(fp == NULL) {
		printf("check_router_forward_funcvoid file open failed\n");
		return 0;
	}
	buff = (char *) malloc(1024);
	memset(buff, 0, 1024);
	while(fgets(buff, 1024, fp))
	{
		printf("%s\n", buff);
		if (strstr(buff, "DNAT") )
		{
			return_status = 1;
			break;
		}
		else
			continue;
	}

	free(buff);
	fclose(fp);
	return return_status;
}

void do_dos_protect_for_udp_chargen_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {};
	char src_port[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	char *wan_eth_value = NULL;
	INIT_NVRAM_VALUE(wan_eth_value);
	
	/*
	if( !nvram_match("wan_proto", "static")  || !nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, nvram_safe_get("wan_eth") );			
	} else {
	*/
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	if( !cmd_nvram_match("wan_proto", "static")  || !cmd_nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, cmd_nvram_safe_get("wan_eth",wan_eth_value));			
	} else {
		
	    /* Must modify for multi pppoe later */
	    strcpy(wan_eth, "ppp0");
	}
	
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	FREE_NVRAM_VALUE(wan_eth_value);
	
	
	if(strstr(msg_buf, "lan") == NULL)
	{
		//attack router itself
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		lan_ip_start = strstr(msg_buf,"SRC");
		lan_ip_end = strstr(msg_buf,"DST");
		lan_ip_start = lan_ip_start + 4;
		lan_ip_end = lan_ip_end - 1;
		memset(client_ip, 0, sizeof(client_ip));
		strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
		src_pot_start = strstr(msg_buf,"SPT");
		src_pot_end = strstr(msg_buf,"DPT");
		src_pot_start = src_pot_start + 4;
		src_pot_end = src_pot_end - 1;
		strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
		sprintf(log_buf,"%s %s [DoS Attck : UDP chargen] from source %s, port %s \n", buf, LocalHostName, client_ip, src_port);	
		if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);		
	}
	else
	{
		// attack exposed LAN hosts
		gNumOfUDPChargenPacket++;	
		
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		strftime(buf, sizeof(buf), "%s", tm);	
		sscanf(buf, "%s", cur_sec);
		
		if(gNumOfUDPChargenPacket == 1)
			sscanf(buf, "%s", gfirstUDPChargenSec);
		else	
			sscanf(buf, "%s", cur_sec);
		memset(buf, 0, sizeof(buf));
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		
		/* if it has detected 50 or more packets going to the port in 10 secs*/
		/*block this traffic for 5 min*/
		if(gNumOfUDPChargenPacket >50)
		{	
			if((atol(cur_sec) - atol(gfirstUDPChargenSec) )< 10)	
			{
				_system("iptables -I SPI_FORWARD -i %s -p udp --destination-port 19 -j DROP", wan_eth);
				lan_ip_start = strstr(msg_buf,"SRC");
				lan_ip_end = strstr(msg_buf,"DST");
				lan_ip_start = lan_ip_start + 4;
				lan_ip_end = lan_ip_end - 1;
				memset(client_ip, 0, sizeof(client_ip));
				strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
				src_pot_start = strstr(msg_buf,"SPT");
				src_pot_end = strstr(msg_buf,"DPT");
				src_pot_start = src_pot_start + 4;
				src_pot_end = src_pot_end - 1;
				strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
				save2file(LOG_FILE,"[DoS Attck : UDP chargen] from source %s, port %s, %s\n", client_ip, src_port, buf);	

				if(fork()==0)
				{
					sleep(300);
					_system("iptables -D SPI_FORWARD -i %s -p udp --destination-port 19 -j DROP", wan_eth);
					exit(0);
				}
			}
			gNumOfUDPChargenPacket =0;
		}
		else 
		{
			/* if it has detected 50 or less packets but exceeds 10 secs duration*/
			/*reset to 0*/
			if((atol(cur_sec) - atol(gfirstUDPChargenSec) )> 10)	
			{
				gNumOfUDPChargenPacket =0;
			}
		}
	}

}

void do_dos_protect_for_udp_echo_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {};
	char src_port[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	char *wan_eth_value = NULL;
	INIT_NVRAM_VALUE(wan_eth_value);
	
	/*
	if( !nvram_match("wan_proto", "static")  || !nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, nvram_safe_get("wan_eth") );			
	} else {
	*/
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	if( !cmd_nvram_match("wan_proto", "static")  || !cmd_nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, cmd_nvram_safe_get("wan_eth",wan_eth_value));			
	} else {
	    /* Must modify for multi pppoe later */
	    strcpy(wan_eth, "ppp0");
	}
	
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	FREE_NVRAM_VALUE(wan_eth_value);

	if(strstr(msg_buf, "lan") == NULL)
	{
		//attack router itself
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		lan_ip_start = strstr(msg_buf,"SRC");
		lan_ip_end = strstr(msg_buf,"DST");
		lan_ip_start = lan_ip_start + 4;
		lan_ip_end = lan_ip_end - 1;
		memset(client_ip, 0, sizeof(client_ip));
		strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
		src_pot_start = strstr(msg_buf,"SPT");
		src_pot_end = strstr(msg_buf,"DPT");
		src_pot_start = src_pot_start + 4;
		src_pot_end = src_pot_end - 1;
		strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
		sprintf(log_buf,"%s %s [DoS Attck : UDP echo] from source %s, port %s \n", buf, LocalHostName, client_ip, src_port);		
		if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);		
	}
	else
	{
		gNumOfUDPEchoPacket++;	
		
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		strftime(buf, sizeof(buf), "%s", tm);	
		sscanf(buf, "%s", cur_sec);
		
		if(gNumOfUDPEchoPacket == 1)
		{
			time(&clock);
			tm = gmtime(&clock);
			memset(buf, 0, sizeof(buf));
			strftime(buf, sizeof(buf), "%s", tm);	
			sscanf(buf, "%s", gfirstUDPEchoSec);
		}
		else
		{
			time(&clock);
			tm = gmtime(&clock);
			memset(buf, 0, sizeof(buf));
			strftime(buf, sizeof(buf), "%s", tm);	
			sscanf(buf, "%s", cur_sec);
		}
		memset(buf, 0, sizeof(buf));
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		
		/* if it has detected 50 or more packets going to the port in 10 secs*/
		/*block this traffic for 5 min*/
		if(gNumOfUDPEchoPacket >50)
		{	
			if((atoi(cur_sec) - atoi(gfirstUDPEchoSec) )< 10)	
				{
					_system("iptables -I SPI_FORWARD -i %s -p udp --destination-port 7 -j DROP", wan_eth);
					lan_ip_start = strstr(msg_buf,"SRC");
					lan_ip_end = strstr(msg_buf,"DST");
					lan_ip_start = lan_ip_start + 4;
					lan_ip_end = lan_ip_end - 1;
					memset(client_ip, 0, sizeof(client_ip));
					strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
					src_pot_start = strstr(msg_buf,"SPT");
					src_pot_end = strstr(msg_buf,"DPT");
					src_pot_start = src_pot_start + 4;
					src_pot_end = src_pot_end - 1;
					strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
					save2file(LOG_FILE,"[DoS Attck : UDP echo] from source %s, port %s, %s\n", client_ip, src_port, buf);	

					if(fork()==0)
					{
						sleep(300);
						_system("iptables -D SPI_FORWARD -i %s -p udp --destination-port 7 -j DROP", wan_eth);
					exit(0);
				}
					}
					gNumOfUDPEchoPacket =0;
				}
		else 
		{
			/* if it has detected 50 or less packets but exceeds 10 secs duration*/
			/*reset to 0*/
			if((atol(cur_sec) - atol(gfirstUDPEchoSec) )> 10)	
			{
				gNumOfUDPEchoPacket =0;
			}
		}
	}

}

void do_dos_protect_for_tcp_echo_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {};
	char src_port[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	char *wan_eth_value = NULL;
	INIT_NVRAM_VALUE(wan_eth_value);

	/*
	if( !nvram_match("wan_proto", "static")  || !nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, nvram_safe_get("wan_eth") );			
	} else {
	*/
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	if( !cmd_nvram_match("wan_proto", "static")  || !cmd_nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, cmd_nvram_safe_get("wan_eth",wan_eth_value) );			
	} else {
		
	    /* Must modify for multi pppoe later */
	    strcpy(wan_eth, "ppp0");
	}
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	FREE_NVRAM_VALUE(wan_eth_value);
	

	if(strstr(msg_buf, "lan") == NULL)
	{
		//attack router itself
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		lan_ip_start = strstr(msg_buf,"SRC");
		lan_ip_end = strstr(msg_buf,"DST");
		lan_ip_start = lan_ip_start + 4;
		lan_ip_end = lan_ip_end - 1;
		memset(client_ip, 0, sizeof(client_ip));
		strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
		src_pot_start = strstr(msg_buf,"SPT");
		src_pot_end = strstr(msg_buf,"DPT");
		src_pot_start = src_pot_start + 4;
		src_pot_end = src_pot_end - 1;
		strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
		sprintf(log_buf,"%s %s [DoS Attck : tcp echo] from source %s, port %s \n",buf, LocalHostName, client_ip, src_port);	
		if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);		
	}
	else
	{
		gNumOfTCPEchoPacket++;	
		
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		strftime(buf, sizeof(buf), "%s", tm);	
		sscanf(buf, "%s", cur_sec);

		if(gNumOfTCPEchoPacket == 1)
		{
			time(&clock);
			tm = gmtime(&clock);
			memset(buf, 0, sizeof(buf));
			strftime(buf, sizeof(buf), "%s", tm);	
			sscanf(buf, "%s", gfirstTCPEchoSec);
		}
		else
		{
			time(&clock);
			tm = gmtime(&clock);
			memset(buf, 0, sizeof(buf));
			strftime(buf, sizeof(buf), "%s", tm);	
			sscanf(buf, "%s", cur_sec);
		}
		memset(buf, 0, sizeof(buf));
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		
		/* if it has detected 50 or more packets going to the port in 10 secs*/
		/*block this traffic for 5 min*/
		if(gNumOfTCPEchoPacket >50)
		{	
			if((atoi(cur_sec) - atoi(gfirstTCPEchoSec) )< 10)	
			{
					_system("iptables -I SPI_FORWARD -i %s -p tcp --destination-port 7 -j DROP", wan_eth);
					lan_ip_start = strstr(msg_buf,"SRC");
					lan_ip_end = strstr(msg_buf,"DST");
					lan_ip_start = lan_ip_start + 4;
					lan_ip_end = lan_ip_end - 1;
					memset(client_ip, 0, sizeof(client_ip));
					strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
					src_pot_start = strstr(msg_buf,"SPT");
					src_pot_end = strstr(msg_buf,"DPT");
					src_pot_start = src_pot_start + 4;
					src_pot_end = src_pot_end - 1;
					strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
					save2file(LOG_FILE,"[DoS Attck : tcp echo] from source %s, port %s, %s\n", client_ip, src_port, buf);	

					if(fork()==0)
					{
						sleep(300);
						_system("iptables -D SPI_FORWARD -i %s -p tcp --destination-port 7 -j DROP", wan_eth);
						exit(0);
					}
			}
			gNumOfTCPEchoPacket =0;
		}
		else 
		{
			/* if it has detected 50 or less packets but exceeds 10 secs duration*/
			/*reset to 0*/
			if((atol(cur_sec) - atol(gfirstTCPEchoSec) )> 10)	
			{
				gNumOfTCPEchoPacket =0;
			}
		}
	}
}




void do_dos_protect_for_tcp_chargen_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {};
	char src_port[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
		
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	char *wan_eth_value = NULL;
	INIT_NVRAM_VALUE(wan_eth_value);

	/*
	if( !nvram_match("wan_proto", "static")  || !nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, nvram_safe_get("wan_eth") );			
	} else {
	*/
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	if( !cmd_nvram_match("wan_proto", "static")  || !cmd_nvram_match("wan_proto", "dhcpc") ) {
            strcpy(wan_eth, cmd_nvram_safe_get("wan_eth",wan_eth_value) );			
	} else {
	    /* Must modify for multi pppoe later */
	    strcpy(wan_eth, "ppp0");
	}
	
	/*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
	FREE_NVRAM_VALUE(wan_eth_value);

	if(strstr(msg_buf, "lan") == NULL)
	{
		//attack router itself
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		lan_ip_start = strstr(msg_buf,"SRC");
		lan_ip_end = strstr(msg_buf,"DST");
		lan_ip_start = lan_ip_start + 4;
		lan_ip_end = lan_ip_end - 1;
		memset(client_ip, 0, sizeof(client_ip));
		strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
		src_pot_start = strstr(msg_buf,"SPT");
		src_pot_end = strstr(msg_buf,"DPT");
		src_pot_start = src_pot_start + 4;
		src_pot_end = src_pot_end - 1;
		strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
		sprintf(log_buf,"%s %s [DoS Attck : tcp chargen] from source %s, port %s \n",buf, LocalHostName, client_ip, src_port);
		if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);		
	}
	else
	{
		gNumOfTCPChargenPacket++;	

		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		strftime(buf, sizeof(buf), "%s", tm);	
		sscanf(buf, "%s", cur_sec);
		
		if(gNumOfTCPChargenPacket == 1)
			sscanf(buf, "%s", gfirstTCPChargenSec);
		else
			sscanf(buf, "%s", cur_sec);

		memset(buf, 0, sizeof(buf));
		strftime(buf,sizeof(buf),"%b %d %X",tm);
		
		/* if it has detected 50 or more packets going to the port in 10 secs*/
		/*block this traffic for 5 min*/
		if(gNumOfTCPChargenPacket >50)
		{	
			if((atoi(cur_sec) - atoi(gfirstTCPChargenSec) )< 10)	
			{
				_system("iptables -I SPI_FORWARD -i %s -p tcp --destination-port 19 -j DROP", wan_eth);
				lan_ip_start = strstr(msg_buf,"SRC");
				lan_ip_end = strstr(msg_buf,"DST");
				lan_ip_start = lan_ip_start + 4;
				lan_ip_end = lan_ip_end - 1;
				memset(client_ip, 0, sizeof(client_ip));
				strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
				src_pot_start = strstr(msg_buf,"SPT");
				src_pot_end = strstr(msg_buf,"DPT");
				src_pot_start = src_pot_start + 4;
				src_pot_end = src_pot_end - 1;
				strncpy(src_port,src_pot_start,src_pot_end - src_pot_start);
				save2file(LOG_FILE,"[DoS Attck : tcp chargen] from source %s, port %s, %s\n", client_ip, src_port, buf);	

				if(fork()==0)
				{
					sleep(300);
					_system("iptables -D SPI_FORWARD -i %s -p tcp --destination-port 19 -j DROP", wan_eth);
					exit(0);
				}
			}
			gNumOfTCPChargenPacket =0;
		}
		else 
		{
			/* if it has detected 50 or less packets but exceeds 10 secs duration*/
			/*reset to 0*/
			if((atol(cur_sec) - atol(gfirstTCPChargenSec) )> 10)	
			{
					gNumOfTCPChargenPacket =0;
			}
		}
	}

}

void do_dos_protect_for_icmp_flood(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {};
	time_t clock;
	struct tm *tm;

	gNumOfICMPPacket++;	
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	strftime(buf, sizeof(buf), "%s", tm);	
	sscanf(buf, "%s", cur_sec);

	if(gNumOfICMPPacket == 1)
	{
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		strftime(buf, sizeof(buf), "%s", tm);	
		sscanf(buf, "%s", gfirstICMPSec);
	}
	else
	{
		time(&clock);
		tm = gmtime(&clock);
		memset(buf, 0, sizeof(buf));
		strftime(buf, sizeof(buf), "%s", tm);	
		sscanf(buf, "%s", cur_sec);
	}
	
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected 50 or more packets going to the port in 10 secs*/
	/*block this traffic for 5 min*/
	if(gNumOfICMPPacket >50)
	{	
		if((atoi(cur_sec) - atoi(gfirstICMPSec) )< 10)	
		{
			_system("iptables -I SPI_INPUT -p icmp -j DROP");
			
			lan_ip_start = strstr(msg_buf,"SRC");
			lan_ip_end = strstr(msg_buf,"DST");
			lan_ip_start = lan_ip_start + 4;
			lan_ip_end = lan_ip_end - 1;
			memset(client_ip, 0, sizeof(client_ip));
			strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
			save2file(LOG_FILE,"%s %s [DoS Aattck : icmp flood] from source %s \n", buf, LocalHostName, client_ip);	

			if(fork()==0)
			{
				sleep(60);
				_system("iptables -D SPI_INPUT -p icmp -j DROP");
				exit(0);
			}
		}
		gNumOfICMPPacket =0;
	}
	else 
	{
		/* if it has detected 50 or less packets but exceeds 10 secs duration*/
		/*reset to 0*/
		if((atol(cur_sec) - atol(gfirstICMPSec) )> 10)	
		{
			gNumOfICMPPacket =0;
		}
	}

	}

void do_dos_protect_for_ipspoof_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	time_t clock;
	struct tm *tm;	
	char log_buf[256]={0};
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
        
	sprintf(log_buf,"%s %s [DoS Aattck : ip spoof attack] from source %s \n", buf, LocalHostName, client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);

}


void do_dos_protect_for_udp_port_scan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end;
	char buf[256]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;	
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	lan_ip_start = strstr(msg_buf,"DST");
	lan_ip_end = strstr(msg_buf,"LEN");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	
	sprintf(log_buf,"%s %s [DoS Aattck : udp port scan attack] from source %s \n", buf, LocalHostName, client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);
}

/*Drop ICMP types */
void do_dos_protect_for_icmp_scan(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	time(&clock);
	tm = gmtime(&clock);	
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	
	sprintf(log_buf,"%s %s [DoS Aattck : icmp scan] from source %s \n", buf, LocalHostName, client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);

}

/*Drop packets with tcp-flags FIN set*/
void do_dos_protect_for_FINScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;

	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected --tcp-flags ALL FIN*/

	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);

	sprintf(log_buf,"%s %s [DoS Aattck : FIN scan attack] from source %s \n",buf, LocalHostName,  client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);
	if(fork()==0)
	{
		sleep(300);
		_system("iptables -D SPI_INPUT -i %s -p tcp -m tcp --tcp-flags ALL FIN -j DROP", wan_eth);
		exit(0);
	}
}


/*Drop packets with tcp-flags FIN,URG,PSH set*/
void do_dos_protect_for_XmasScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;

	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	strftime(buf,sizeof(buf),"%b %d %X",tm);

	/* if it has detected --tcp-flags FIN,URG,PSH set*/

	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start, lan_ip_end - lan_ip_start);

	sprintf(log_buf,"%s %s attack: [DoS Aattck : Xmas Tress scan attack] from source %s \n", buf, LocalHostName, client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);
}

/*Drop packets with tcp-flags FIN,SYN set*/
void do_dos_protect_for_IMAP_FINSYNScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;

	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected --tcp-flags ALL FIN,SYN*/

	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);

	sprintf(log_buf,"%s %s [DoS Aattck : IMAP scan attack] from source %s \n", buf, LocalHostName, client_ip);
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);

}

/*Drop packets with tcp-flags ACK set*/
void do_dos_protect_for_ACKScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;

	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected --tcp-flags ALL ACK*/

	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	sprintf(log_buf,"%s %s [DoS Aattck : ACK scan attack] from source %s \n",buf, LocalHostName, client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);
}

/*Drop packets with non tcp-flags set*/
void do_dos_protect_for_NullScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;

	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected --tcp-flags ALL NULL*/
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	
	sprintf(log_buf,"%s %s [DoS Aattck : NULL scan attack] from source %s, %s\n", buf, LocalHostName, client_ip);	
	if(check_router_forward_func())
	{
		
		/*
		if( !nvram_match("spi_enable", "1") )
		*/
		/*  Date: 2009-01-12
		*   Name: Rock Chen 
		*   Reason: using the new sutil 
		*   Notice:
		*/
		if( !cmd_nvram_match("spi_enable", "1") )
		
			if(check_previous_in_FW_log(log_buf))	
				save2file(LOG_FILE, log_buf);
	}
	else
	{
		if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);
	}

}

/*Drop packets with tcp-flags SYN,RST set*/
void do_dos_protect_for_SYNRSTScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected --tcp-flags ALL SYN, RST*/
	/* drop this kind of packet by inserting iptables rule to the first line*/	
	
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	
	sprintf(log_buf,"%s %s [DoS Aattck : SYN/RST scan attack] from source %s, %s\n", buf,LocalHostName, client_ip);
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);

}

/*Drop packets with tcp-flags RST set*/
void do_dos_protect_for_RSTScan_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;

	gNumOfRSTScanPacket++;	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	/* if it has detected --tcp-flags ALL RST*/
	
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);

	sprintf(log_buf,"%s %s [DoS Aattck : RST scan attack] from source %s \n",buf, LocalHostName, client_ip);
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);


}

void do_dos_protect_for_winnuke_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);

	sprintf(log_buf,"%s %s [DoS Aattck : winnuke attack] from source %s \n",buf,LocalHostName, client_ip);	
	if(check_previous_in_FW_log(log_buf))	
		save2file(LOG_FILE, log_buf);
}

void do_dos_protect_for_land_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	sprintf(log_buf,"%s %s [DoS Aattck : land attack] from source %s \n",buf, LocalHostName, client_ip);
	if(check_router_forward_func())
	{
		/*
		if( !nvram_match("spi_enable", "1") )
		*/
		/*  Date: 2009-01-12
		*   Name: Rock Chen 
		*   Reason: using the new sutil 
		*   Notice:
		*/
		if( !cmd_nvram_match("spi_enable", "1") )
		
			if(check_previous_in_FW_log(log_buf))	
				save2file(LOG_FILE, log_buf);
	}
	else
	{
	      	if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);
	}

}

void do_dos_protect_for_smurf_attack(char *msg_buf)
{
	char *lan_ip_start,*lan_ip_end,*src_pot_start, *src_pot_end;
	char buf[256]={0};
	char cur_sec[20]={0};
	char client_ip[32] = {0};
	char wan_eth[32] = {0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	
	time(&clock);
	tm = gmtime(&clock);
	memset(buf, 0, sizeof(buf));
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	lan_ip_start = strstr(msg_buf,"SRC");
	lan_ip_end = strstr(msg_buf,"DST");
	lan_ip_start = lan_ip_start + 4;
	lan_ip_end = lan_ip_end - 1;
	memset(client_ip, 0, sizeof(client_ip));
	strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);

	sprintf(log_buf,"%s %s [DoS Aattck : smurf attack] from source %s \n",buf, LocalHostName, client_ip);		
	if(check_router_forward_func())
	{
		/*
		if( !nvram_match("spi_enable", "1") )
		*/
		/*  Date: 2009-01-12
		*   Name: Rock Chen 
		*   Reason: using the new sutil 
		*   Notice:
		*/
		if( !cmd_nvram_match("spi_enable", "1") )
		
			if(check_previous_in_FW_log(log_buf))	
				save2file(LOG_FILE, log_buf);
	}
	else
	{
	      	if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);
	}

}

void do_dos_protect_for_kernel_attack(char *msg_buf)
{
	char buf[256]={0};
	char log_buf[256]={0};
	time_t clock;
	struct tm *tm;
	char *url_start;
	
	time(&clock);
	tm = localtime(&clock) ;
	//strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
	strftime(buf,sizeof(buf),"%b %d %X",tm);
	url_start = strstr(msg_buf, "%s [DoS Attack");
	sprintf(log_buf,"%s %s %s\n",buf, LocalHostName, url_start);
	if(check_router_forward_func())
	{
		/*
		if( !nvram_match("spi_enable", "1") )
		*/
		/*  Date: 2009-01-12
		*   Name: Rock Chen 
		*   Reason: using the new sutil 
		*   Notice:
		*/
		if( !cmd_nvram_match("spi_enable", "1") )
			if(check_previous_in_FW_log(log_buf))	
				save2file(LOG_FILE, log_buf);
	}
	else
	{
	      	if(check_previous_in_FW_log(log_buf))	
			save2file(LOG_FILE, log_buf);
	}
}


/* This must be a #define, since when CONFIG_DEBUG and BUFFERS_GO_IN_BSS are
 * enabled, we otherwise get a "storage size isn't constant error. */
static int serveConnection(char *tmpbuf, int n_read)
{
	char *p = tmpbuf;
	char *lan_ip_start,*lan_ip_end,*site_ip_start,*site_ip_end,*url_start,*url_end, *src_pot_start, *src_pot_end;
	char client_ip[32] = {};
	char block_ip[32] = {};
	char src_port[32] = {0};
	char service_name[32] = {};
	char url[4] = {};
	char url_address[256] = {};
	struct hostent *host;
	char buf[256]={};
    time_t clock;
    struct tm *tm;
    
  /*  Date: 2009-01-12
	*   Name: Rock Chen 
	*   Reason: using the new sutil 
	*   Notice:
	*/
  char *log_email_sender_value = NULL;
	char *log_email_server_value = NULL;
	char *log_email_username_value = NULL;
	char *log_email_password_value = NULL;	
	char *model_name_value = NULL;
	char *url_address_value = NULL;  
    

	/*Send alert immediately*/
	/*anyone attempts to visit blocked site will be logged and send out this info by email immediately*/
	time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%b %d %X",tm);

	if(url_start = strstr(tmpbuf, "Blocked Site"))
	{
		
		/*  Date: 2009-01-12
		*   Name: Rock Chen 
		*   Reason: using the new sutil 
		*   Notice:
		*/
		INIT_NVRAM_VALUE(log_email_sender_value);
		INIT_NVRAM_VALUE(log_email_server_value);
		INIT_NVRAM_VALUE(log_email_username_value);
		INIT_NVRAM_VALUE(log_email_password_value);
		INIT_NVRAM_VALUE(model_name_value);
		INIT_NVRAM_VALUE(url_address_value);
		
		/*
		char *recipient = nvram_get("log_email_sender");
		char *server = nvram_get("log_email_server");
		char *username = nvram_get("log_email_username");
		char *password = nvram_get("log_email_password");
		char *modelname = nvram_get("model_name");
		*/
		/*  Date: 2009-01-12
		*   Name: Rock Chen 
		*   Reason: using the new sutil 
		*   Notice:
		*/
		char *recipient = cmd_nvram_get("log_email_sender",log_email_sender_value);
		char *server = cmd_nvram_get("log_email_server",log_email_server_value);
		char *username = cmd_nvram_get("log_email_username",log_email_username_value);
		char *password = cmd_nvram_get("log_email_password",log_email_password_value);
		char *modelname = cmd_nvram_get("model_name",model_name_value);
		
		
		
		url_start = url_start + strlen("Blocked Site") + 1;
        	url_end = strstr(tmpbuf,"IN");
		url_end = url_end - 1;
		strncpy(url,url_start,url_end - url_start);
		lan_ip_start = strstr(tmpbuf,"SRC");
		lan_ip_end = strstr(tmpbuf,"DST");
		lan_ip_start = lan_ip_start + 4;
		lan_ip_end = lan_ip_end - 1;
		strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
		site_ip_start = strstr(tmpbuf,"DST");
		site_ip_end = strstr(tmpbuf,"LEN");
		site_ip_start = site_ip_start + 4;
		site_ip_end = site_ip_end - 1;
		strncpy(block_ip,site_ip_start,site_ip_end - site_ip_start);
		memset(url_address,0,sizeof(url_address));
		sprintf(url_address, "url_domain_filter_%02d", atoi(url));		
		if(check_previous(url,client_ip,URLBLOCK))
		{
			/*
			save2file(LOG_FILE,"[site blocked: %s] from source %s %s\n",nvram_safe_get(url_address),client_ip,buf);
			*/
			/*  Date: 2009-01-12
			*   Name: Rock Chen 
			*   Reason: using the new sutil 
			*   Notice:
			*/
			save2file(LOG_FILE,"[site blocked: %s] from source %s %s\n",cmd_nvram_safe_get(url_address,url_address_value),client_ip,buf);
			
			printf("send_log_by_smtp\n");
			if (fork()) exit(0);
			if(strlen(username) == 0)
				_system("msmtp -T %s --host=%s --from=%s@%s", recipient, server, modelname, server);
			else
				_system("msmtp -T %s --auth= --user=%s --passwd=%s --host=%s --from=%s@%s", recipient, username, password, server, modelname, server);
		}
	}
	else if(url_start = strstr(tmpbuf, "Allowed Site"))
	{
		url_start = url_start + strlen("Allowed Site") + 1;
        url_end = strstr(tmpbuf,"IN");
        url_end = url_end - 1;
        strncpy(url,url_start,url_end - url_start);
        lan_ip_start = strstr(tmpbuf,"SRC");
        lan_ip_end = strstr(tmpbuf,"DST");
        lan_ip_start = lan_ip_start + 4;
        lan_ip_end = lan_ip_end - 1;
        strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
        site_ip_start = strstr(tmpbuf,"DST");
        site_ip_end = strstr(tmpbuf,"LEN");
        site_ip_start = site_ip_start + 4;
        site_ip_end = site_ip_end - 1;
        strncpy(block_ip,site_ip_start,site_ip_end - site_ip_start);
        memset(url_address,0,sizeof(url_address));
        sprintf(url_address, "url_domain_filter_%02d", atoi(url));
		if(check_previous(url,client_ip,URLALLOW))
			/*
			save2file(LOG_FILE,"[site allowed: %s] from source %s %s\n",nvram_safe_get(url_address),client_ip,buf);
			*/
			/*  Date: 2009-01-12
			*   Name: Rock Chen 
			*   Reason: using the new sutil 
			*   Notice:
			*/
			save2file(LOG_FILE,"[site allowed: %s] from source %s %s\n",cmd_nvram_safe_get(url_address,url_address_value),client_ip,buf);
	}
	else if(url_start = strstr(tmpbuf, "Blocked Service"))
	{
		url_start = url_start + strlen("Blocked Service") + 1;
	        url_end = strstr(tmpbuf,"IN");
	        url_end = url_end - 1;
	        strncpy(url,url_start,url_end - url_start);
	        lan_ip_start = strstr(tmpbuf,"SRC");
	        lan_ip_end = strstr(tmpbuf,"DST");
	        lan_ip_start = lan_ip_start + 4;
	        lan_ip_end = lan_ip_end - 1;
	        strncpy(client_ip,lan_ip_start,lan_ip_end - lan_ip_start);
	        site_ip_start = strstr(tmpbuf,"DST");
	        site_ip_end = strstr(tmpbuf,"LEN");
	        site_ip_start = site_ip_start + 4;
	        site_ip_end = site_ip_end - 1;
	        strncpy(block_ip,site_ip_start,site_ip_end - site_ip_start);
	        memset(url_address,0,sizeof(url_address));
	        sprintf(url_address, "block_service_%02d", atoi(url));
	        /*
					strcpy(service_name,return_block_services_name(nvram_safe_get(url_address)));
					*/
					/*  Date: 2009-01-12
					*   Name: Rock Chen 
					*   Reason: using the new sutil 
					*   Notice:
					*/
					strcpy(service_name,return_block_services_name(cmd_nvram_safe_get(url_address,url_address_value)));
					
		if(strcmp(service_name,"") != 0)
			save2file(LOG_FILE,"[service blocked: %s] from source %s %s\n",service_name,client_ip,buf);	
	}
	else if(url_start = strstr(tmpbuf, "Port Forwarding"))
	{
		url_start = url_start + strlen("Port Forwarding") + 1;
	        url_end = strstr(tmpbuf,"IN");
	        url_end = url_end - 1;
	        strncpy(url,url_start,url_end - url_start);
			memset(url_address,0,sizeof(url_address));
	        sprintf(url_address, "port_forward_%02d", atoi(url));
		if(check_previous(url, url_address,PORTFORWARDING))
			save2file(LOG_FILE,"[LAN access from remote] from externalIP:%s to internalIP:%s %s\n",\
			/*
			retunr_port_forwarding(nvram_safe_get(url_address),STARTPORT),\
			retunr_port_forwarding(nvram_safe_get(url_address),ENDPORT),buf);
			*/
			/*  Date: 2009-01-12
			*   Name: Rock Chen 
			*   Reason: using the new sutil 
			*   Notice:
			*/
			retunr_port_forwarding(cmd_nvram_safe_get(url_address,url_address_value),STARTPORT),\
			retunr_port_forwarding(cmd_nvram_safe_get(url_address,url_address_value),ENDPORT),buf);
			
	}
	else if(url_start = strstr(tmpbuf, "Port Triggering"))
	{
		url_start = url_start + strlen("Port Triggering") + 1;
	        url_end = strstr(tmpbuf,"IN");
	        url_end = url_end - 1;
	        strncpy(url,url_start,url_end - url_start);
	        memset(url_address,0,sizeof(url_address));
	        sprintf(url_address, "application_%02d", atoi(url));
		if(check_previous(url, url_address,PORTTRIGGERING))
			save2file(LOG_FILE,"[LAN access from remote] from externalIP:%s to internalIP:%s %s\n",\
			/*
			retunr_port_trigger(nvram_safe_get(url_address),PUBLICPORTS),\
			retunr_port_trigger(nvram_safe_get(url_address),TRIGGERPORTS),buf);
			*/
			/*  Date: 2009-01-12
			*   Name: Rock Chen 
			*   Reason: using the new sutil 
			*   Notice:
			*/
			retunr_port_trigger(cmd_nvram_safe_get(url_address,url_address_value),PUBLICPORTS),\
			retunr_port_trigger(cmd_nvram_safe_get(url_address,url_address_value),TRIGGERPORTS),buf);			
	}
	else if(url_start = strstr(tmpbuf, "udp echo"))
		do_dos_protect_for_udp_echo_attack(tmpbuf);		
	else if(url_start = strstr(tmpbuf, "udp chargen"))
		do_dos_protect_for_udp_chargen_attack(tmpbuf);		
	else if(url_start = strstr(tmpbuf, "tcp echo"))
		do_dos_protect_for_tcp_echo_attack(tmpbuf);		
	else if(url_start = strstr(tmpbuf, "tcp chargen"))
		do_dos_protect_for_tcp_chargen_attack(tmpbuf);		
	else if(url_start = strstr(tmpbuf, "icmp flood"))
		do_dos_protect_for_icmp_flood(tmpbuf);
	else if(url_start = strstr(tmpbuf, "ip spoof"))
		do_dos_protect_for_ipspoof_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "udp port scan"))
		do_dos_protect_for_udp_port_scan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "icmp scan"))
		do_dos_protect_for_icmp_scan(tmpbuf);
	else if(url_start = strstr(tmpbuf, "FIN Scan"))
		do_dos_protect_for_FINScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "Xmas Tress Scan"))
		do_dos_protect_for_XmasScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "IMAP FIN/SYN Scan"))
		do_dos_protect_for_IMAP_FINSYNScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "ACK Scan"))
		do_dos_protect_for_ACKScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "NULL Scan"))
		do_dos_protect_for_NullScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "RST only Scan"))
		do_dos_protect_for_RSTScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "winnuke attack"))
		do_dos_protect_for_winnuke_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "SYNRST Scan"))
		do_dos_protect_for_SYNRSTScan_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "land attack spi"))
		do_dos_protect_for_land_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "smurf attack"))
		do_dos_protect_for_smurf_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "[DoS Attack"))
		do_dos_protect_for_kernel_attack(tmpbuf);
	else if(url_start = strstr(tmpbuf, "DMZ"))
		save2file(LOG_FILE,"[LAN access from remote] NOT IMPLEMENT......\n");
	
	
	/*  Date: 2009-01-12
			*   Name: Rock Chen 
			*   Reason: using the new sutil 
			*   Notice:
	*/	
	/* free nvram value */
	FREE_NVRAM_VALUE(log_email_sender_value);
	FREE_NVRAM_VALUE(log_email_server_value);
	FREE_NVRAM_VALUE(log_email_username_value);
	FREE_NVRAM_VALUE(log_email_password_value);
	FREE_NVRAM_VALUE(model_name_value);
	FREE_NVRAM_VALUE(url_address_value);	

	while (p < tmpbuf + n_read) {

		int pri = (LOG_USER | LOG_NOTICE);
		int num_lt = 0;
		char line[MAXLINE + 1];
		unsigned char c;
		char *q = line;

		while ((c = *p) && q < &line[sizeof(line) - 1]) {
			if (c == '<' && num_lt == 0) {
				/* Parse the magic priority number. */
				num_lt++;
				pri = 0;
				while (isdigit(*(++p))) {
					pri = 10 * pri + (*p - '0');
				}
				if (pri & ~(LOG_FACMASK | LOG_PRIMASK)) {
					pri = (LOG_USER | LOG_NOTICE);
				}
			} else if (c == '\n') {
				*q++ = ' ';
			} else if (iscntrl(c) && (c < 0177)) {
				*q++ = '^';
				*q++ = c ^ 0100;
			} else {
				*q++ = c;
			}
			p++;
		}
		*q = '\0';
		p++;
		/* Now log it */
		logMessage(pri, line);
	}
	return n_read;
}

static void doSyslogd(void) __attribute__ ((noreturn));
static void doSyslogd(void)
{
	struct sockaddr_un sunx;
	socklen_t addrLength;

	int sock_fd;
	fd_set fds;

	/* Set up signal handlers. */
	signal(SIGINT, quit_signal);
	signal(SIGTERM, quit_signal);
	signal(SIGQUIT, quit_signal);
	signal(SIGHUP, SIG_IGN);
	signal(SIGCHLD, SIG_IGN);
#ifdef SIGCLD
	signal(SIGCLD, SIG_IGN);
#endif
	signal(SIGALRM, domark);
	alarm(MarkInterval);

	/* Create the syslog file so realpath() can work. */
	//if (realpath(_PATH_LOG, lfile) != NULL) {
	if (realpath(logSockPath, lfile) != NULL) {
		unlink(lfile);
	}

	memset(&sunx, 0, sizeof(sunx));
	sunx.sun_family = AF_UNIX;
	strncpy(sunx.sun_path, lfile, sizeof(sunx.sun_path));
	if ((sock_fd = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
		//bb_perror_msg_and_die("Couldn't get file descriptor for socket "
		//				   _PATH_LOG);
		bb_perror_msg_and_die("Couldn't get file descriptor for socket %s"
						   ,logSockPath);
	}

	addrLength = sizeof(sunx.sun_family) + strlen(sunx.sun_path);
	if (bind(sock_fd, (struct sockaddr *) &sunx, addrLength) < 0) {
		//bb_perror_msg_and_die("Could not connect to socket " _PATH_LOG);
		bb_perror_msg_and_die("Could not connect to socket %s ", logSockPath);
	}

	if (chmod(lfile, 0666) < 0) {
		//bb_perror_msg_and_die("Could not set permission on " _PATH_LOG);
		bb_perror_msg_and_die("Could not set permission on %s", logSockPath);
	}
#ifdef CONFIG_FEATURE_IPC_SYSLOG
	if (circular_logging == TRUE) {
		ipcsyslog_init();
	}
#endif

#ifdef CONFIG_FEATURE_REMOTE_LOG
	if (doRemoteLog == TRUE) {
		init_RemoteLog();
	}
#endif

/* jimmy added for IPC syslog	*/
	read_die_log();
/* --------------------- */

//	logMessage(LOG_SYSLOG | LOG_INFO, "syslogd started: " BB_BANNER);

	for (;;) {

		FD_ZERO(&fds);
		FD_SET(sock_fd, &fds);

		if (select(sock_fd + 1, &fds, NULL, NULL, NULL) < 0) {
			if (errno == EINTR) {
				/* alarm may have happened. */
				continue;
			}
			bb_perror_msg_and_die("select error");
		}

		if (FD_ISSET(sock_fd, &fds)) {
			int i;

			RESERVE_CONFIG_BUFFER(tmpbuf, MAXLINE + 1);

			memset(tmpbuf, '\0', MAXLINE + 1);
			if ((i = recv(sock_fd, tmpbuf, MAXLINE, 0)) > 0) {
				serveConnection(tmpbuf, i);
			} else {
				bb_perror_msg_and_die("UNIX socket error");
			}
			RELEASE_CONFIG_BUFFER(tmpbuf);
		}				/* FD_ISSET() */
	}					/* for main loop */
}

extern int syslogd_main(int argc, char **argv)
{
	int opt;

	int doFork = TRUE;

	char *p;

	/* do normal option parsing */
	//while ((opt = getopt(argc, argv, "m:nO:s:Sb:R:LC::")) > 0) {
	//while ((opt = getopt(argc, argv, "m:nO:s:p:Sb:R:LC::")) > 0) {
	while ((opt = getopt(argc, argv, "m:nO:s:b:R:LC::")) > 0) {
		switch (opt) {
		case 'm':
			MarkInterval = atoi(optarg) * 60;
			break;
		case 'n':
			doFork = FALSE;
			break;
		case 'O':
			logFilePath = optarg;
			break;
		case 'p' :
			logSockPath = optarg;
#ifdef CONFIG_FEATURE_ROTATE_LOGFILE
		case 's':
			logFileSize = atoi(optarg) * 1024;
			break;
		case 'b':
			logFileRotate = atoi(optarg);
			if( logFileRotate > 99 ) logFileRotate = 99;
			break;
#endif
#ifdef CONFIG_FEATURE_REMOTE_LOG
		case 'R':
			RemoteHost = bb_xstrdup(optarg);
			if ((p = strchr(RemoteHost, ':'))) {
				RemotePort = atoi(p + 1);
				*p = '\0';
			}
			doRemoteLog = TRUE;
			break;
		case 'L':
			local_logging = TRUE;
			break;
#endif
#ifdef CONFIG_FEATURE_IPC_SYSLOG
		case 'C':
			if (optarg) {
				int buf_size = atoi(optarg);
				if (buf_size >= 4) {
					shm_size = buf_size * 1024;
				}
			}
			circular_logging = TRUE;
			break;
#endif
		case 'S':
			small = true;
			break;
		default:
			bb_show_usage();
		}
	}

#ifdef CONFIG_FEATURE_REMOTE_LOG
	/* If they have not specified remote logging, then log locally */
	if (doRemoteLog == FALSE)
		local_logging = TRUE;
#endif


	/* Store away localhost's name before the fork */
	gethostname(LocalHostName, sizeof(LocalHostName));
	if ((p = strchr(LocalHostName, '.'))) {
		*p = '\0';
	}

	umask(0);

	if (doFork == TRUE) {
#if defined(__uClinux__)
		vfork_daemon_rexec(0, 1, argc, argv, "-n");
#else /* __uClinux__ */
		if(daemon(0, 1) < 0)
			bb_perror_msg_and_die("daemon");
#endif /* __uClinux__ */
	}
	doSyslogd();

	return EXIT_SUCCESS;
}

/*
Local Variables
c-file-style: "linux"
c-basic-offset: 4
tab-width: 4
End:
*/
