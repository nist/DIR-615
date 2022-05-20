/* Shared library add-on to iptables to add string matching support. 
 * 
 * Copyright (C) 2000 Emmanuel Roger  <winfield@freegates.be>
 *
 * ChangeLog
 *     29.12.2003: Michael Rash <mbr@cipherdyne.org>
 *             Fixed iptables save/restore for ascii strings
 *             that contain space chars, and hex strings that
 *             contain embedded NULL chars.  Updated to print
 *             strings in hex mode if any non-printable char
 *             is contained within the string.
 *
 *     27.01.2001: Gianni Tedesco <gianni@ecsc.co.uk>
 *             Changed --tos to --string in save(). Also
 *             updated to work with slightly modified
 *             ipt_string_info.
 */
#include <stdio.h>
#include <netdb.h>
#include <string.h>
#include <stdlib.h>
#include <getopt.h>
#include <ctype.h>

#include <iptables.h>
#include <linux/netfilter_ipv4/ipt_urlfilter.h>


#define proto_token	"://"
#define url_token		"/"


/* Function which prints out usage message. */
static void
help(void)
{
	printf("urlfilter match v%s options:\n"
		"--url [!] url	Match a URL in a packet\n", IPTABLES_VERSION);
}


static struct option opts[] = {
	{ .name = "url",     .has_arg = 1, .flag = 0, .val = '1' },
	{ .name = 0 }
};

static void
parse_url(const unsigned char *s, struct ipt_urlfilter_info *info)
{	
	unsigned char *hostptr, *urlptr;
	int shift = strlen(proto_token);

	if (strlen(s) <= BM_MAX_NLEN)  {
		if( !(hostptr =strstr(s, proto_token)) )  {
			hostptr = s;
			shift = 0;
		}
		if( (urlptr = strstr(hostptr + shift, url_token) ) ) {
			strcpy(info->url, urlptr);
			info->url_len = strlen(urlptr);
			strncpy(info->host, hostptr+shift, urlptr - (hostptr + shift) );
			info->host_len = urlptr - (hostptr + shift);
		} else {
			strcpy(info->host, hostptr);
			info->host_len = strlen(hostptr);
			info->url_len = 0;
		}
	}else 
		exit_error(PARAMETER_PROBLEM, "url too long `%s'", s);
}



/* Function which parses command options; returns true if it
	ate an option */
static int
parse(int c, char **argv, int invert, unsigned int *flags,
		const struct ipt_entry *entry,
		unsigned int *nfcache,
		struct ipt_entry_match **match)
{
	struct ipt_urlfilter_info *urlinfo = (struct ipt_urlfilter_info *)(*match)->data;

	switch (c) {
		case '1':
			if (*flags)
				exit_error(PARAMETER_PROBLEM, "Can't specify multiple urls");
			check_inverse(optarg, &invert, &optind, 0);
			parse_url(argv[optind-1], urlinfo);
			if (invert)
				urlinfo->invert = 1;
			//stringinfo->hostlen=strlen((char *)&stringinfo->host);
			*flags = 1;
			break;

		default:
			return 0;
	}
	return 1;
}


/* Final check; must have specified --string. */
static void
final_check(unsigned int flags)
{
	if (!flags)
		exit_error(PARAMETER_PROBLEM, "url match: You must specify '--url' ");
}



static void
print_url(const char *host, const char *url)
{
	unsigned int i;
	printf("\"");

	/* print host */
	for (i=0; i < strlen(host); i++) {
		if ((unsigned char) host[i] == 0x22)  /* escape any embedded quotes */
			printf("%c", 0x5c);
		printf("%c", (unsigned char) host[i]);
	}

	/* print url */
	for (i=0; i < strlen(url); i++) {
		if ((unsigned char) url[i] == 0x22)  /* escape any embedded quotes */
			printf("%c", 0x5c);
		printf("%c", (unsigned char) url[i]);
	}
	printf("\" ");  /* closing space and quote */
}

/* Prints out the matchinfo. */
static void
print(const struct ipt_ip *ip,
		const struct ipt_entry_match *match,
		int numeric)
{
	const struct ipt_urlfilter_info *info = (const struct ipt_urlfilter_info*) match->data;

	printf("url match %s", (info->invert) ? "!" : "");
	print_url(info->host, info->url);
}


/* Saves the union ipt_matchinfo in parseable form to stdout. */
static void
save(const struct ipt_ip *ip, const struct ipt_entry_match *match)
{
	const struct ipt_urlfilter_info *info = (const struct ipt_urlfilter_info*) match->data;
	printf("--url %s", (info->invert) ? "! ": "");
	print_url(info->host, info->url);
}


static struct iptables_match urlfilter = {
	.name          = "urlfilter",
	.version       = IPTABLES_VERSION,
	.size          = IPT_ALIGN(sizeof(struct ipt_urlfilter_info)),
	.userspacesize = IPT_ALIGN(sizeof(struct ipt_urlfilter_info)),
	.help          = &help,
	.parse         = &parse,
	.final_check   = &final_check,
	.print         = &print,
	.save          = &save,
	.extra_opts    = opts
};


void _init(void)
{
	register_match(&urlfilter);
}
