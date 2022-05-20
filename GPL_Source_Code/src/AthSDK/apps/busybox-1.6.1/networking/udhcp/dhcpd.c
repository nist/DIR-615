/* vi: set sw=4 ts=4: */
/* dhcpd.c
 *
 * udhcp Server
 * Copyright (C) 1999 Matthew Ramsay <matthewr@moreton.com.au>
 *			Chris Trew <ctrew@moreton.com.au>
 *
 * Rewrite by Russ Dill <Russ.Dill@asu.edu> July 2001
 *
 * Licensed under GPLv2 or later, see file LICENSE in this tarball for details.
 */

#include <syslog.h>
#include "common.h"
#include "dhcpd.h"
#include "options.h"


/* globals */
struct dhcpOfferedAddr *leases;
struct server_config_t server_config;


int udhcpd_main(int argc, char **argv);
int udhcpd_main(int argc, char **argv)
{
	fd_set rfds;
	struct timeval tv;
	int server_socket = -1, bytes, retval, max_sock;
	struct dhcpMessage packet;
	uint8_t *state, *server_id, *requested;
	uint32_t server_id_align, requested_align, static_lease_ip;
	unsigned long timeout_end, num_ips;
	struct option_set *option;
	struct dhcpOfferedAddr *lease, static_lease;

//Huh, dhcpd don't have --foreground, --syslog options?? TODO

	if (!ENABLE_FEATURE_UDHCP_DEBUG) {
		bb_daemonize_or_rexec(DAEMON_CHDIR_ROOT, argv);
		logmode &= ~LOGMODE_STDIO;
	}

	if (ENABLE_FEATURE_UDHCP_SYSLOG) {
		openlog(applet_name, LOG_PID, LOG_LOCAL0);
		logmode |= LOGMODE_SYSLOG;
	}

	/* Would rather not do read_config before daemonization -
	 * otherwise NOMMU machines will parse config twice */
	read_config(argc < 2 ? DHCPD_CONF_FILE : argv[1]);

	udhcp_make_pidfile(server_config.pidfile);

	option = find_option(server_config.options, DHCP_LEASE_TIME);
	server_config.lease = LEASE_TIME;
	if (option) {
		memcpy(&server_config.lease, option->data + 2, 4);
		server_config.lease = ntohl(server_config.lease);
	}

	/* Sanity check */
	num_ips = ntohl(server_config.end) - ntohl(server_config.start) + 1;
	if (server_config.max_leases > num_ips) {
		bb_error_msg("max_leases value (%lu) not sane, "
			"setting to %lu instead",
			server_config.max_leases, num_ips);
		server_config.max_leases = num_ips;
	}

	leases = xzalloc(server_config.max_leases * sizeof(struct dhcpOfferedAddr));
	read_leases(server_config.lease_file);

	if (read_interface(server_config.interface, &server_config.ifindex,
			   &server_config.server, server_config.arp) < 0) {
		retval = 1;
		goto ret;
	}

	/* Setup the signal pipe */
	udhcp_sp_setup();

	timeout_end = time(0) + server_config.auto_time;
	while (1) { /* loop until universe collapses */

		if (server_socket < 0) {
			server_socket = listen_socket(INADDR_ANY, SERVER_PORT,
					server_config.interface);
		}

		max_sock = udhcp_sp_fd_set(&rfds, server_socket);
		if (server_config.auto_time) {
			tv.tv_sec = timeout_end - time(0);
			tv.tv_usec = 0;
		}
		retval = 0;
		if (!server_config.auto_time || tv.tv_sec > 0) {
			retval = select(max_sock + 1, &rfds, NULL, NULL,
					server_config.auto_time ? &tv : NULL);
		}
		if (retval == 0) {
			write_leases();
			timeout_end = time(0) + server_config.auto_time;
			continue;
		}
		if (retval < 0 && errno != EINTR) {
			DEBUG("error on select");
			continue;
		}

		switch (udhcp_sp_read(&rfds)) {
		case SIGUSR1:
			bb_info_msg("Received a SIGUSR1");
			write_leases();
			/* why not just reset the timeout, eh */
			timeout_end = time(0) + server_config.auto_time;
			continue;
		case SIGTERM:
			bb_info_msg("Received a SIGTERM");
			goto ret0;
		case 0: break;		/* no signal */
		default: continue;	/* signal or error (probably EINTR) */
		}

		bytes = udhcp_get_packet(&packet, server_socket); /* this waits for a packet - idle */
		if (bytes < 0) {
			if (bytes == -1 && errno != EINTR) {
				DEBUG("error on read, %s, reopening socket", strerror(errno));
				close(server_socket);
				server_socket = -1;
			}
			continue;
		}

		state = get_option(&packet, DHCP_MESSAGE_TYPE);
		if (state == NULL) {
			bb_error_msg("cannot get option from packet, ignoring");
			continue;
		}

		/* Look for a static lease */
		static_lease_ip = getIpByMac(server_config.static_leases, &packet.chaddr);

		if (static_lease_ip) {
			bb_info_msg("Found static lease: %x", static_lease_ip);

			memcpy(&static_lease.chaddr, &packet.chaddr, 16);
			static_lease.yiaddr = static_lease_ip;
			static_lease.expires = 0;

			lease = &static_lease;
		} else {
			lease = find_lease_by_chaddr(packet.chaddr);
		}

		switch (state[0]) {
		case DHCPDISCOVER:
			DEBUG("Received DISCOVER");

			if (sendOffer(&packet) < 0) {
				bb_error_msg("send OFFER failed");
			}
			break;
		case DHCPREQUEST:
			DEBUG("received REQUEST");

			requested = get_option(&packet, DHCP_REQUESTED_IP);
			server_id = get_option(&packet, DHCP_SERVER_ID);

			if (requested) memcpy(&requested_align, requested, 4);
			if (server_id) memcpy(&server_id_align, server_id, 4);

			if (lease) {
				if (server_id) {
					/* SELECTING State */
					DEBUG("server_id = %08x", ntohl(server_id_align));
					if (server_id_align == server_config.server && requested
					 && requested_align == lease->yiaddr
					) {
						sendACK(&packet, lease->yiaddr);
					}
				} else if (requested) {
					/* INIT-REBOOT State */
					if (lease->yiaddr == requested_align)
						sendACK(&packet, lease->yiaddr);
					else
						sendNAK(&packet);
				} else if (lease->yiaddr == packet.ciaddr) {
					/* RENEWING or REBINDING State */
					sendACK(&packet, lease->yiaddr);
				} else {
					/* don't know what to do!!!! */
					sendNAK(&packet);
				}

			/* what to do if we have no record of the client */
			} else if (server_id) {
				/* SELECTING State */

			} else if (requested) {
				/* INIT-REBOOT State */
				lease = find_lease_by_yiaddr(requested_align);
				if (lease) {
					if (lease_expired(lease)) {
						/* probably best if we drop this lease */
						memset(lease->chaddr, 0, 16);
					/* make some contention for this address */
					} else
						sendNAK(&packet);
				} else if (requested_align < server_config.start
				        || requested_align > server_config.end
				) {
					sendNAK(&packet);
				} else /* else remain silent */ {
					/* XXX: if dhcpd no leased record, or ID mismatch.
					 * 	ex: Happen on udhcpd restart and clear lease.conf
					 * 	client(WIN XP) send a REQUEST packet to reget info.
					 * 	however, server can not identify this packet and
					 * 	ignore it by default.)
					 * 	
					 * 	We wish send a NAK packet to notify client that
					 * 	lease time is expire. and please re-DISCOVERY-OFFER -
					 * 	
					 * 	It might exist a issue when multiple DHCPD in the same
					 * 	network...
					 * */
					sendNAK(&packet);
				}

			} else {
				/* RENEWING or REBINDING State */
			}
			break;
		case DHCPDECLINE:
			DEBUG("Received DECLINE");
			if (lease) {
				memset(lease->chaddr, 0, 16);
				lease->expires = time(0) + server_config.decline_time;
			}
			break;
		case DHCPRELEASE:
			DEBUG("Received RELEASE");
			if (lease)
				lease->expires = time(0);
			break;
		case DHCPINFORM:
			DEBUG("Received INFORM");
			send_inform(&packet);
			break;
		default:
			bb_info_msg("Unsupported DHCP message (%02x) - ignoring", state[0]);
		}
	}
 ret0:
	retval = 0;
 ret:
	if (server_config.pidfile)
		remove_pidfile(server_config.pidfile);
	return retval;
}