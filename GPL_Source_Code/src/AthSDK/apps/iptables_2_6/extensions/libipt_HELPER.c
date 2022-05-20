/* Shared library add-on to iptables to add redirect support. */
#include <stdio.h>
#include <netdb.h>
#include <string.h>
#include <stdlib.h>
#include <getopt.h>
#include <iptables.h>
#include <linux/netfilter_ipv4/ip_tables.h>
#include <linux/netfilter_ipv4/ipt_HELPER.h>

/* Function which prints out usage message. */
static void
help(void)
{
	printf( "  --helper\t<argv0>\t to call user mode application\n");
}

static struct option opts[] = {
	{ "helper", 1, 0, '1' },
	{ 0 }
};

/* Initialize the target. */
static void
init(struct ipt_entry_target *t, unsigned int *nfcache)
{
	return;
}

/* Function which parses command options; returns true if it
   ate an option */
static int
parse(int c, char **argv, int invert, unsigned int *flags,
      const struct ipt_entry *entry,
      struct ipt_entry_target **target)
{
	struct ip_target_helper *helper
		= (struct ip_target_helper *)(*target)->data;
	
	switch (c) {
	case '1':
		if (strlen(optarg) >= sizeof(helper->argv0))
			exit_error(PARAMETER_PROBLEM, "too many lenght of argv0\n");
		strcpy(helper->argv0, optarg);
		*flags = 1;
		return 1;

	default:
		return 0;
	}
}

/* Final check; don't care. */
static void final_check(unsigned int flags)
{
	if (!flags)
		exit_error(PARAMETER_PROBLEM, "You must specify `--helper'");
}

/* Prints out the targinfo. */
static void
print(const struct ipt_ip *ip,
      const struct ipt_entry_target *target,
      int numeric)
{
	struct ip_target_helper *helper
		= (struct ip_target_helper *)target->data;
	printf("HELPER %s\n", helper->argv0);
	return;
}

/* Saves the union ipt_targinfo in parsable form to stdout. */
static void
save(const struct ipt_ip *ip, const struct ipt_entry_target *target)
{
	struct ip_target_helper *helper
		= (struct ip_target_helper *)target->data;
	printf("HELPER %s ", helper->argv0);
	return;
}

static struct iptables_target HELPER = { 
	.next		= NULL,
	.name		= "HELPER",
	.version	= IPTABLES_VERSION,
	.size		= IPT_ALIGN(sizeof(struct ip_target_helper)),
	.userspacesize	= IPT_ALIGN(sizeof(struct ip_target_helper)),
	.help		= &help,
	.init		= &init,
 	.parse		= &parse,
	.final_check	= &final_check,
	.print		= &print,
	.save		= &save,
	.extra_opts	= &opts
};

void _init(void)
{
	register_target(&HELPER);
}
