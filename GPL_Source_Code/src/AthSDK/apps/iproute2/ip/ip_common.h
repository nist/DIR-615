extern int print_linkinfo(const struct sockaddr_nl *who, 
			  struct nlmsghdr *n, 
			  void *arg);
extern int print_addrinfo(const struct sockaddr_nl *who,
			  struct nlmsghdr *n, 
			  void *arg);
extern int print_neigh(const struct sockaddr_nl *who,
		       struct nlmsghdr *n, void *arg);
extern int print_ntable(const struct sockaddr_nl *who,
			struct nlmsghdr *n, void *arg);
extern int ipaddr_list(int argc, char **argv);
extern int ipaddr_list_link(int argc, char **argv);
extern int iproute_monitor(int argc, char **argv);
extern void iplink_usage(void) __attribute__((noreturn));
extern void iproute_reset_filter(void);
extern void ipaddr_reset_filter(int);
extern void ipneigh_reset_filter(void);
extern void ipntable_reset_filter(void);
extern int print_route(const struct sockaddr_nl *who, 
		       struct nlmsghdr *n, void *arg);
extern int print_prefix(const struct sockaddr_nl *who,
			struct nlmsghdr *n, void *arg);
extern int do_ipaddr(int argc, char **argv);
extern int do_iproute(int argc, char **argv);
extern int do_iprule(int argc, char **argv);
extern int do_ipneigh(int argc, char **argv);
extern int do_ipntable(int argc, char **argv);
extern int do_iptunnel(int argc, char **argv);
extern int do_iplink(int argc, char **argv);
extern int do_ipmonitor(int argc, char **argv);
extern int do_multiaddr(int argc, char **argv);
extern int do_multiroute(int argc, char **argv);
extern int do_xfrm(int argc, char **argv);

static inline int rtm_get_table(struct rtmsg *r, struct rtattr **tb)
{
	__u32 table = r->rtm_table;
	if (tb[RTA_TABLE])
		table = *(__u32*) RTA_DATA(tb[RTA_TABLE]);
	return table;
}

extern struct rtnl_handle rth;
