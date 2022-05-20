/* Shared library add-on to iptables to add MAC address support. */
#include <stdio.h>
#include <netdb.h>
#include <string.h>
#include <stdlib.h>
#include <getopt.h>
#if defined(__GLIBC__) && __GLIBC__ == 2
#include <net/ethernet.h>
#else
#include <linux/if_ether.h>
#endif
#include <iptables.h>
#include "../libiptc/linux_list.h"
#include <linux/list.h>
#include <linux/netfilter_ipv4/ipt_alg.h>

static void
help(void)
{
	printf(
"ALG v%s options:\n"
" --tri-ports [port1:port2] --dst-ports [port1:port2]\n"
" --tri-proto [tcp|udp|both] --dst-proto [tcp|udp|both]\n"
" --tri-dev device --dst-dev device\n"
"\n", IPTABLES_VERSION);
}

static struct option opts[] = {
	{ "tri-ports", 1, 0, '1' },
	{ "dst-ports", 1, 0, '2' },
	{ "tri-proto", 1, 0, '3' },
	{ "dst-proto", 1, 0, '4' },
	{ "tri-dev", 1, 0, '5' },
	{ "dst-dev", 1, 0, '6' },
	{0}
};

/* Initialize the match. */
static void
init(struct ipt_entry_match *m, unsigned int *nfcache)
{
	/* Can't cache this */
	*nfcache |= NFC_UNKNOWN;
}
/*
static void
parse_tri(const char *alg, struct ipt_alg_info *info)
{
	u_int32_t port1, port2;
	const char *p;
	char buf[12];

	bzero(buf, sizeof(buf));
	
	if ((p = strchr(alg, ':')) == NULL)
		goto err_args;

	strncpy(buf, alg, p - alg);
	if (string_to_number(buf, 0, 0xFFFF, &port1) == -1){
		goto err_args;
	}
	
	if (string_to_number(p+1, 0, 0xFFFF, &port2) == -1)
		goto err_args;
	printf("tri port convert to:%d:%d\n", port1, port2);
	info->tri.ports[0] = port1;
	info->tri.ports[1] = port2;
	return;
	
err_args:
	exit_error(PARAMETER_PROBLEM,
		"Invalid --tri-ports %s", alg);
}
*/
static void 
print_multi_ports(struct alg_multi_ports *m)
{
	int i = 0;
	for (i = 0; i < m->count; i++) {
		if (m->pflag[i]) {
			printf("%d:%d ", m->ports[i], m->ports[i+1]);
			i++;
		} else
			printf("%d ", m->ports[i]);
	}
}

static void 
dumpall_multi_ports(struct alg_multi_ports *m)
{
	if (m->dev[0] == '\0')
		printf("any dev ");
	else
		printf("[%s] ", m->dev);
	
	if (m->proto == IPPROTO_TCP)
		printf("tcp ");
	else if (m->proto == IPPROTO_UDP)
		printf("udp ");
	else
		printf("both ");
	
	print_multi_ports(m);
	return;
}

static void
__add_multi_port(char *s, struct alg_multi_ports *m)
{
	char buf[16], *p;
	int i = 0;

	bzero(buf, sizeof(buf));
	p = s;
	if (*p == '\0')
		return;
	
	while (*p != ':' && *p != ',' && *p != '\0') {
		buf[i++] = *p;
		p++;
	}
	if (*p == ':')
		m->pflag[m->count] = 1;
	
	if (string_to_number(buf, 0, 0xFFFF, (unsigned int *)
			&m->ports[m->count++]) == -1)
		goto err_args;
	//printf("Convert to %d\n",m->ports[m->count-1]);
	
	if (*p == '\0')
		return;
	return __add_multi_port(p+1,m);
			
err_args:
	exit_error(PARAMETER_PROBLEM,
		"Invalid --dst-ports %s", buf);
}

static void
parse_mport(char *alg, struct alg_multi_ports *mport)
{
	char *p;

	p = strtok(alg, ",");
	if (p) {
		__add_multi_port(p, mport);
		while ((p = strtok(NULL, ","))) {
			__add_multi_port(p, mport);
		}
	} else
		__add_multi_port(alg, mport);
	
	//print_multi_ports(mport);
}

static void
parse_proto(char *alg, struct alg_multi_ports *mport)
{
	if (strcmp(alg, "TCP") == 0 || strcmp(alg, "tcp") == 0) {
			mport->proto = IPPROTO_TCP;
			//printf(" tcp ");
			return;
	} else if (strcmp(alg, "UDP") == 0 || strcmp(alg, "udp") == 0) {
			mport->proto = IPPROTO_UDP;
			//printf(" udp ");
			return;
	} else if (strcmp(alg, "BOTH") == 0 || strcmp(alg, "Both") == 0) {
			mport->proto = 0;
			//printf(" both ");
			return;
	}

	exit_error(PARAMETER_PROBLEM, "--tri-proto [tcp|udp|both] or"
	"dst-proto [tcp|udp|both]");
}

static void
parse_dev(char *alg, struct alg_multi_ports *mport)
{
	strncat(mport->dev, alg, 16);
	return;
}

/* Function which parses command options; returns true if it
   ate an option */
static int
parse(int c, char **argv, int invert, unsigned int *flags,
      const struct ipt_entry *entry,
      unsigned int *nfcache,
      struct ipt_entry_match **match)
{
	struct ipt_alg_info *macinfo = (struct ipt_alg_info *)(*match)->data;
	
	switch (c) {
	case '1':
		parse_mport(argv[optind-1], &macinfo->tri);
		*flags = 1;
		break;
	case '2':
		parse_mport(argv[optind-1], &macinfo->dst);
		*flags = 2;
		break;
	case '3':
		parse_proto(argv[optind-1], &macinfo->tri);
		*flags = 3;
		break;
	case '4':
		parse_proto(argv[optind-1], &macinfo->dst);
		*flags = 4;
		break;
	case '5':
		parse_dev(argv[optind-1], &macinfo->tri);
		*flags = 4;
		break;
	case '6':
		parse_dev(argv[optind-1], &macinfo->dst);
		*flags = 4;
		break;
	default:
		printf("parse return 0");
		return 0;
	}
	return 1;
}
/*
static void print_dst(struct alg_multi_ports *dst)
{
	printf("%d:%d", dst->ports[0], dst->ports[1]);
}
*/
/* Final check; must have specified --mac. */
static void final_check(unsigned int flags)
{
	if (!flags)
		exit_error(PARAMETER_PROBLEM,
			   "You must specify `--tri-ports' and --dst-ports");
}

/* Prints out the matchinfo. */
static void
print(const struct ipt_ip *ip,
      const struct ipt_entry_match *match,
      int numeric)
{
	printf("ALG ");

	dumpall_multi_ports(& ((struct ipt_alg_info *)match->data)->tri);
	dumpall_multi_ports(& ((struct ipt_alg_info *)match->data)->dst);
}

/* Saves the union ipt_matchinfo in parsable form to stdout. */
static void save(const struct ipt_ip *ip, const struct ipt_entry_match *match)
{

	printf("--tri-ports ");
	dumpall_multi_ports(& ((struct ipt_alg_info *)match->data)->tri);
	printf("--dst-ports ");
	dumpall_multi_ports(& ((struct ipt_alg_info *)match->data)->dst);
}

static struct iptables_match alg = { 
	.next		= NULL,
 	.name		= "alg",
	.version	= IPTABLES_VERSION,
	.size		= IPT_ALIGN(sizeof(struct ipt_alg_info)),
	.userspacesize	= IPT_ALIGN(sizeof(struct ipt_alg_info)),
	.help		= &help,
	.init		= &init,
	.parse		= &parse,
	.final_check	= &final_check,
	.print		= &print,
	.save		= &save,
	.extra_opts	= opts
};

void _init(void)
{
	register_match(&alg);
}
