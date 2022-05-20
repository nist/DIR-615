/* vi: set sw=4 ts=4: */
/*
 * Mini watchdog implementation for busybox
 *
 * Copyright (C) 2003  Paul Mundt <lethal@linux-sh.org>
 * Copyright (C) 2006  Bernhard Fischer <busybox@busybox.net>
 *
 * Licensed under the GPL v2 or later, see the file LICENSE in this tarball.
 */

#include "libbb.h"

#if 0//WATCH_DOG
#define WATCH_MSG(fmt, arg...)       printf(fmt, ##arg)
#else
#define WATCH_MSG(fmt, arg...) 
#endif

#if 1//def WATCH_DOG
#define WATCHDOG_DEVICE    "/dev/watchdog"
static int watchdog =0;
#endif

#define OPT_FOREGROUND 0x01
#define OPT_TIMER      0x02

static void watchdog_shutdown(int ATTRIBUTE_UNUSED sig) ATTRIBUTE_NORETURN;
static void watchdog_shutdown(int ATTRIBUTE_UNUSED sig)
{
	write(3, "V", 1);	/* Magic, see watchdog-api.txt in kernel */
	if (ENABLE_FEATURE_CLEAN_UP)
		close(3);
	exit(0);
}

int watchdog_main(int argc, char **argv);
int watchdog_main(int argc, char **argv)
{
	//unsigned opts;
	unsigned timer_duration = 3; /* Userspace timer duration, in seconds */
	//char *t_arg;

#if 1//def WATCH_DOG
	WATCH_MSG("\nwatchdog open start !!\n");	
	watchdog = open(WATCHDOG_DEVICE, O_RDWR);
	if(!watchdog){
		printf("watchdog open fail!\n");	
	}	
#endif    	

	//opt_complementary = "=1"; /* must have 1 argument */
	//opts = getopt32(argc, argv, "Ft:", &t_arg);

	//if (opts & OPT_TIMER)
		//timer_duration = xatou(t_arg);

	//if (!(opts & OPT_FOREGROUND)) {
		//bb_daemonize_or_rexec(DAEMON_CHDIR_ROOT, argv);
	//}

	//signal(SIGHUP, watchdog_shutdown);
	//signal(SIGINT, watchdog_shutdown);

	/* Use known fd # - avoid needing global 'int fd' */
	//xmove_fd(xopen(argv[argc - 1], O_WRONLY), 3);
	WATCH_MSG("watchdog timer_duration=%d\n",timer_duration);
	while (1) {

#if 1//def WATCH_DOG
		if(watchdog){				
			//WATCH_MSG("watchdog write !!\n");
			if(!write(watchdog, "keep_alive", 1)){
				printf("watchdog keep_alive fail!\n");	
				close(watchdog);
			}	
		}
		else{
			WATCH_MSG("watchdog open again\n");
			watchdog = open(WATCHDOG_DEVICE, O_WRONLY);
			if(!watchdog){
				printf("watchdog open again fail!\n");	
			}	
		}			
#endif    	

		/*
		 * Make sure we clear the counter before sleeping, as the counter value
		 * is undefined at this point -- PFM
		 */
		//write(3, "", 1);
		sleep(timer_duration);
	}

	//watchdog_shutdown(0);
	/* return EXIT_SUCCESS; */
}
