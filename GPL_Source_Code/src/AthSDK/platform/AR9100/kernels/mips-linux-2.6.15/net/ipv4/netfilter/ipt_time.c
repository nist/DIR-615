/*
  This is a module which is used for time matching
  It is using some modified code from dietlibc (localtime() function)
  that you can find at http://www.fefe.de/dietlibc/
  This file is distributed under the terms of the GNU General Public
  License (GPL). Copies of the GPL can be obtained from: ftp://prep.ai.mit.edu/pub/gnu/GPL
  2001-05-04 Fabrice MARIE <fabrice@netfilter.org> : initial development.
  2001-21-05 Fabrice MARIE <fabrice@netfilter.org> : bug fix in the match code,
     thanks to "Zeng Yu" <zengy@capitel.com.cn> for bug report.
  2001-26-09 Fabrice MARIE <fabrice@netfilter.org> : force the match to be in LOCAL_IN or PRE_ROUTING only.
  2001-30-11 Fabrice : added the possibility to use the match in FORWARD/OUTPUT with a little hack,
     added Nguyen Dang Phuoc Dong <dongnd@tlnet.com.vn> patch to support timezones.
  2004-05-02 Fabrice : added support for date matching, from an idea of Fabien COELHO.
*/

#include <linux/module.h>
#include <linux/skbuff.h>
#include <linux/netfilter_ipv4/ip_tables.h>
#include <linux/netfilter_ipv4/ipt_time.h>
#include <linux/time.h>

MODULE_AUTHOR("Fabrice MARIE <fabrice@netfilter.org>");
MODULE_DESCRIPTION("Match arrival timestamp/date");
MODULE_LICENSE("GPL");

struct tm
{
	int tm_sec;                   /* Seconds.     [0-60] (1 leap second) */
	int tm_min;                   /* Minutes.     [0-59] */
	int tm_hour;                  /* Hours.       [0-23] */
	int tm_mday;                  /* Day.         [1-31] */
	int tm_mon;                   /* Month.       [0-11] */
	int tm_year;                  /* Year - 1900.  */
	int tm_wday;                  /* Day of week. [0-6] */
	int tm_yday;                  /* Days in year.[0-365] */
	int tm_isdst;                 /* DST.         [-1/0/1]*/

	long int tm_gmtoff;           /* we don't care, we count from GMT */
	const char *tm_zone;          /* we don't care, we count from GMT */
};

void
localtime(const u32 time, struct tm *r);

static int
match(const struct sk_buff *skb,
      const struct net_device *in,
      const struct net_device *out,
      const void *matchinfo,
      int offset,
      int *hotdrop)
{
	const struct ipt_time_info *info = matchinfo;   /* match info for rule */
	struct tm currenttime;                          /* time human readable */
	u_int8_t days_of_week[7] = {64, 32, 16, 8, 4, 2, 1};
	u_int16_t packet_time;

	u_int8_t is_over_night_schedule=0;
	u_int8_t match_today_schedule_day=0;
	u_int8_t match_today_schedule_time=0;
	u_int8_t match_yesterday_schedule_day=0;
	u_int8_t match_yesterday_schedule_time=0;
	
	if(info->time_start > info->time_stop)
	{
		/*  NickChou add is_over_night_schedule at 2009.4.22
			Ex. PM 15:00 ~ AM 10:00 on Wed
			=>  PM 15:00 ~ PM 24:00 on Wed
			and AM 00:00 ~ AM 10:00 on Thu
		*/
		is_over_night_schedule=1;
	}
	
	/* We might not have a timestamp, get one */
	if (skb->tstamp.off_sec == 0)
		__net_timestamp((struct sk_buff *)skb);

	/* First we make sure we are in the date start-stop boundaries */
	if ((skb->tstamp.off_sec < info->date_start) || (skb->tstamp.off_sec > info->date_stop))
		return 0; /* We are outside the date boundaries */

	/* Transform the timestamp of the packet, in a human readable form */
	localtime(skb->tstamp.off_sec, &currenttime);

	/* check if we match this timestamp, we start by the days... */
	if( !is_over_night_schedule )
	{
	if ((days_of_week[currenttime.tm_wday] & info->days_match) != days_of_week[currenttime.tm_wday])
		return 0; /* the day doesn't match */
	}
	else /*	NickChou add is_over_night_schedule at 2009.4.22 */
	{
		if( (days_of_week[currenttime.tm_wday] & info->days_match) == days_of_week[currenttime.tm_wday] )
		{
			//printk("Over Night Schedule : today match today schedule !!\n");
			match_today_schedule_day=1;
		}
		if( (currenttime.tm_wday!=0) && ((days_of_week[currenttime.tm_wday-1] & info->days_match) == days_of_week[currenttime.tm_wday-1]) )	
		{
			//printk("Over Night Schedule : today match yesterday schedule : today is not Sunday !!\n");
			match_yesterday_schedule_day=1;
		}
		if( (currenttime.tm_wday==0) && ((days_of_week[6] & info->days_match) == days_of_week[6]) )
	{
			//printk("Over Night Schedule : today match yesterday schedule : today is not Sunday !!\n");
			match_yesterday_schedule_day=1;
		}
						
		if( !(match_today_schedule_day || match_yesterday_schedule_day) )
		{
			//printk("Over Night Schedule !! the day not match !!\n");
			return 0; /* the day doesn't match */
		}	
	}	

	/* ... check the time now */
	packet_time = (currenttime.tm_hour * 60) + currenttime.tm_min;
	
	if(!is_over_night_schedule)
	{
	if ((packet_time < info->time_start) || (packet_time > info->time_stop))
		return 0;
	}	
	else /*	NickChou add is_over_night_schedule at 2009.4.22 */
	{
		if( (match_today_schedule_day==1) && (packet_time > info->time_start) && (packet_time < 24*60) )
		{
			//printk("Over Night Schedule !! match today schedule day and time\n");
			match_today_schedule_time=1;
		}	
		
		if( (match_yesterday_schedule_day==1) && (packet_time > 0) && (packet_time < info->time_stop) )
	{
			//printk("Over Night Schedule !! match yesterday schedule day and time\n");
			match_yesterday_schedule_time=1;
		}
					
		if( !(match_today_schedule_time || match_yesterday_schedule_time) )
		{
			//printk("Over Night Schedule !! the time not match !!\n");
			return 0;
		}	
	}

	/* here we match ! */
	return 1;
}

static int
checkentry(const char *tablename,
           const struct ipt_ip *ip,
           void *matchinfo,
           unsigned int matchsize,
           unsigned int hook_mask)
{
	struct ipt_time_info *info = matchinfo;   /* match info for rule */

	/* First, check that we are in the correct hooks */
	if (hook_mask
            & ~((1 << NF_IP_PRE_ROUTING) | (1 << NF_IP_LOCAL_IN) | (1 << NF_IP_FORWARD) | (1 << NF_IP_LOCAL_OUT)))
	{
		printk("ipt_time: error, only valid for PRE_ROUTING, LOCAL_IN, FORWARD and OUTPUT)\n");
		return 0;
	}

	/* Check the size */
	if (matchsize != IPT_ALIGN(sizeof(struct ipt_time_info)))
		return 0;
	/* Now check the coherence of the data ... */
	if ((info->time_start > 1439) ||        /* 23*60+59 = 1439*/
	    (info->time_stop  > 1439))
	{
		printk(KERN_WARNING "ipt_time: invalid argument\n");
		return 0;
	}

	return 1;
}

static struct ipt_match time_match = {
	.name = "time",
	.match = &match,
	.checkentry = &checkentry,
	.me = THIS_MODULE
};

static int __init init(void)
{
	printk("ipt_time loading\n");
	return ipt_register_match(&time_match);
}

static void __exit fini(void)
{
	ipt_unregister_match(&time_match);
	printk("ipt_time unloaded\n");
}

module_init(init);
module_exit(fini);


/* The part below is borowed and modified from dietlibc */

/* seconds per day */
#define SPD 24*60*60

void
localtime(const u32 time, struct tm *r) {
	u32 i, timep;
	extern struct timezone sys_tz;
	const unsigned int __spm[12] =
		{ 0,
		  (31),
		  (31+28),
		  (31+28+31),
		  (31+28+31+30),
		  (31+28+31+30+31),
		  (31+28+31+30+31+30),
		  (31+28+31+30+31+30+31),
		  (31+28+31+30+31+30+31+31),
		  (31+28+31+30+31+30+31+31+30),
		  (31+28+31+30+31+30+31+31+30+31),
		  (31+28+31+30+31+30+31+31+30+31+30),
		};
	register u32 work;

	timep = time - (sys_tz.tz_minuteswest * 60);
	work=timep%(SPD);
	r->tm_sec=work%60; work/=60;
	r->tm_min=work%60; r->tm_hour=work/60;
	work=timep/(SPD);
	r->tm_wday=(4+work)%7;
	for (i=1970; ; ++i) {
		register time_t k= (!(i%4) && ((i%100) || !(i%400)))?366:365;
		if (work>k)
			work-=k;
		else
			break;
	}
	r->tm_year=i-1900;
	for (i=11; i && __spm[i]>work; --i) ;
	r->tm_mon=i;
	r->tm_mday=work-__spm[i]+1;
}
