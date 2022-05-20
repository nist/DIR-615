/*
 * Multicast Routing Daemon (MRD)
 *   pim_interface.cpp
 *
 * Copyright (C) 2004, 2005
 *  Universidade de Aveiro, Instituto Telecomunicacoes - Polo Aveiro
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Authors:	Hugo Santos, <hsantos@av.it.pt>
 */

#include <mrdpriv/pim/interface.h>
#include <mrdpriv/pim/router.h>
#include <mrdpriv/pim/group.h>
#include <mrdpriv/pim/neighbour.h>

#include <mrd/mrd.h>

#include <errno.h>

extern in6_addr pim_all_routers;
extern sockaddr_in6 pim_all_routers_addr;

enum {
	pim_intf_method_flap = 1000,
	pim_intf_method_force_timeout
};

static const method_info pim_intf_methods[] = {
	{ "flap", 0, pim_intf_method_flap, false, 0 },
	{ "force-timeout", "Forces the timeout of a neighbor",
		pim_intf_method_force_timeout, false, 0 },
	{ 0 }
};

pim_interface::pim_interface()
	: interface_node(pim),
	  hello_timer_id("pim hello timer", this, std::mem_fun(&pim_interface::send_hello)) {

	intf_state = NOT_READY;

	gen_id = rand();

	elected_dr = 0;
	m_landelay_enabled = true;
}

pim_interface::~pim_interface() {
}

bool pim_interface::check_startup() {
	if (!interface_node::check_startup())
		return false;
	import_methods(pim_intf_methods);
	return true;
}

void pim_interface::attached(interface *intf) {
	interface_node::attached(intf);

	((conf_node *)conf())->attach_watcher(this);

	std::string tmrname = "pim hello timer (";
	tmrname += owner()->name();
	tmrname += ")";

	hello_timer_id.name = tmrname;

	update_hello_interval(conf()->hello_interval());

	check_lan_delay();
}

void pim_interface::shutdown() {
	send_hellox(0);

	neighbours_def n = neighbours;

	neighbours.clear();

	for (neighbours_def::const_iterator j = n.begin(); j != n.end(); ++j) {
		pim->lost_neighbour(*j);
		(*j)->shutdown();
		delete *j;
	}

	((conf_node *)conf())->dettach_watcher(this);

	owner()->dettach_node(this);
}

bool pim_interface::output_info(base_stream &ctx, bool extended) const {
	if (get_state() == NOT_READY)
		return false;

	ctx << "PIM" << endl;

	ctx.inc_level();

	ctx << "DR Priority: " << conf()->dr_priority() << endl;
	ctx << "LAN Propagation Delay: " << conf()->propagation_delay() << "ms "
		<< "Override Interval: " << conf()->override_interval() << "ms" << endl;

	if (elected_dr)
		ctx << "DR: " << elected_dr->localaddr() << endl;
	else
		ctx << "DR: self" << endl;

	ctx << "Neighbours:" << endl;

	ctx.inc_level();

	if (neighbours.empty()) {
		ctx << "(None)" << endl;
	} else {
		for (neighbours_def::const_iterator j = neighbours.begin();
						j != neighbours.end(); j++) {
			(*j)->output_info(ctx, extended);
		}
	}

	ctx.dec_level();

	ctx.dec_level();

	return true;
}

bool pim_interface::output_info(base_stream &out, const std::vector<std::string> &args) const {
	bool extended = !args.empty() && args[0] == "extended";

	return output_info(out, extended);
}

void pim_interface::address_added_or_removed(bool added, const inet6_addr &addr) {
	added_or_removed_address(added, addr);
}

void pim_interface::added_or_removed_address(bool added, const inet6_addr &addr) {
	if (added) {
		if (addr.is_linklocal()) {
			if (intf_state != NOT_READY)
				return;

			if (pim->pim_sock.join_mc(owner(), pim_all_routers) < 0) {
				pim->log().fatal() << "(PIM) failed to join all "
					<< "pim routers multicast group on "
					<< *owner() << "(" << owner()->index()
					<< "): " << strerror(errno) << endl;
			}

			if (!start_timers())
				pim->log().fatal() << "(PIM) interface " << owner()->name()
					<< ": failed to start required timers" << endl;

			state was = intf_state;
			intf_state = owner()->globals().empty() ? LOCAL_READY : READY;

			if (was != intf_state)
				loginfo(DEBUG) << "interface state changed to "
					<< (intf_state == LOCAL_READY ? "LOCAL_READY" : "READY") << endl;

			pim->interface_state_changed(this, NOT_READY);
		} else {
			if (intf_state == LOCAL_READY) {
				intf_state = READY;

				loginfo(DEBUG) << "interface state changed to READY" << endl;

				pim->interface_state_changed(this, LOCAL_READY);
			}
		}
	} else {
		if (addr.is_linklocal()) {
			if (owner()->linklocals().empty()) {
				intf_state = NOT_READY;

				pim->pim_sock.leave_mc(owner(), pim_all_routers);

				loginfo(DEBUG) << "interface state changed to NOT_READY" << endl;

				// stop hello timer

				pim->interface_state_changed(this, LOCAL_READY);
			}
		} else {
			if (owner()->globals().empty() && intf_state == READY) {
				intf_state = LOCAL_READY;
				loginfo(DEBUG) << "interface state changed to LOCAL_READY" << endl;
				pim->interface_state_changed(this, READY);
			}

			if (pim->my_address() == addr) {
				pim->check_my_address(true);
			}
		}
	}
}

bool pim_interface::send_local(sockaddr_in6 *dst, pim_message *msg, uint16_t len) const {
	return pim->sendmsg(owner()->localaddr(), dst, msg, len);
}

bool pim_interface::send_all_routers(pim_message *msg, uint16_t len) const {
	return send_local(&pim_all_routers_addr, msg, len);
}

bool pim_interface::start_timers() {
	hello_timer_id.start(true);

	return true;
}

void pim_interface::data_available(const sockaddr_in6 *src, const sockaddr_in6 *dst) {
	pim_message *pimmsg = g_mrd->ipktb->header<pim_message>();

	int len = g_mrd->ipktb->rlength;

	if (pimmsg->type() != pim_msg_register) {
		loginfo(MESSAGE_SIG) << pimmsg->type_name() << " message from " << src->sin6_addr
			<< " to " << dst->sin6_addr << " len " << len << endl;
	}

	if (pimmsg->type() == pim_msg_register)
		len = sizeof(pim_register_message);

	if (!(pimmsg->has_valid_checksum(src->sin6_addr, dst->sin6_addr, len)
		|| (pimmsg->type() == pim_msg_register &&
		pimmsg->has_valid_checksum(src->sin6_addr, dst->sin6_addr, g_mrd->ipktb->rlength)))) {

		loginfo(MESSAGE_ERR) << "dropping PIM message from " << src->sin6_addr
			<< " to " << dst->sin6_addr << " with size " << g_mrd->ipktb->rlength
			<< ", bad checksum" << endl;
		return;
	}

	if (dst->sin6_addr == pim_all_routers) {
		if ((int)src->sin6_scope_id != owner()->index()) {
			loginfo(MESSAGE_ERR) << "dropping PIM message, wrong interface" << endl;
			return;
		}

		switch (pimmsg->type()) {
		case pim_msg_hello:
			handle_hello(src, (pim_hello_message *)g_mrd->ipktb->pheader(), g_mrd->ipktb->rlength);
			break;
		case pim_msg_joinprune:
			handle_joinprune(src, (pim_joinprune_message *)g_mrd->ipktb->pheader(), g_mrd->ipktb->rlength);
			break;
		case pim_msg_assert:
			handle_assert(src, (pim_assert_message *)g_mrd->ipktb->pheader(), g_mrd->ipktb->rlength);
			break;
		case pim_msg_bootstrap:
			handle_bootstrap(src, dst, (pim_bootstrap_message *)g_mrd->ipktb->pheader(), g_mrd->ipktb->rlength);
			break;
		default:
			break;
		}

	} else {
		switch (pimmsg->type()) {
		case pim_msg_register:
			handle_register(src, dst);
			break;
		case pim_msg_register_stop:
			handle_register_stop(src);
			break;
		case pim_msg_bootstrap:
			handle_bootstrap(src, dst, (pim_bootstrap_message *)g_mrd->ipktb->pheader(), g_mrd->ipktb->rlength);
			break;
		case pim_msg_candidate_rp_adv:
			handle_candidate_rp_adv(src,
				(pim_candidate_rp_adv_message *)g_mrd->ipktb->pheader(),
				g_mrd->ipktb->rlength);
			break;
		default:
			break;
		}
	}
}

pim_neighbour *pim_interface::get_best_neighbour() const {
	return neighbours.empty() ? 0 : *neighbours.begin();
}

pim_neighbour *pim_interface::choose_neighbour_towards(const inet6_addr &addr, const inet6_addr &hint) {
	pim_neighbour *neigh = 0;

	if (!hint.is_any())
		neigh = get_neighbour(hint);

	if (!neigh)
		neigh = get_best_neighbour();

	return neigh;
}

pim_neighbour *pim_interface::get_neighbour(const inet6_addr &addr) const {
	for (neighbours_def::const_iterator i = neighbours.begin(); i != neighbours.end(); i++) {
		if ((*i)->has_address(addr))
			return *i;
	}
	return 0;
}

void pim_interface::handle_hello(const sockaddr_in6 *from,
				 pim_hello_message *msg, uint16_t len) {
	/* rejected by configuration */
	if (!conf()->neigh_acl_accepts(from->sin6_addr))
		return;

	uint16_t holdtime = 0;
	bool has_dr_priority = false;
	uint32_t dr_priority = 0;
	bool has_genid = false;
	uint32_t genid = rand();
	bool has_lan_delay = false;
	uint16_t propdelay = 0, overrinter = 0;
	bool trackbit = false;
	std::list<in6_addr> secaddrs;

	int slen = sizeof(pim_hello_message);

	pim_hello_option *opt = msg->options();

	while (slen < len) {
		uint16_t optlen = ntohs(opt->length);

		switch (ntohs(opt->type)) {
		case pim_hello_option::holdtime:
			if (optlen == 2) {
				memcpy(&holdtime, opt->data(), 2);
				holdtime = ntohs(holdtime);
			}
			break;
		case pim_hello_option::lan_prune_delay:
			if (optlen == 4) {
				has_lan_delay = true;

				uint16_t *ptr = (uint16_t *)opt->data();

				memcpy(&propdelay, ptr, 2);
				memcpy(&overrinter, ptr + 1, 2);

				propdelay = ntohs(propdelay);
				overrinter = ntohs(overrinter);

				trackbit = (propdelay & 0x8000) != 0;
				propdelay &= 0x7fff;
			}
			break;
		case pim_hello_option::dr_priority:
			if (optlen == 4) {
				has_dr_priority = true;
				memcpy(&dr_priority, opt->data(), 4);
				dr_priority = ntohl(dr_priority);
			}
			break;
		case pim_hello_option::genid:
			if (optlen == 4) {
				has_genid = true;
				memcpy(&genid, opt->data(), 4);
				genid = ntohl(genid);
			}
			break;
		case pim_hello_option::addrlist:
			if (optlen % sizeof(pim_encoded_unicast_address) == 0) {
				int count = optlen / sizeof(pim_encoded_unicast_address);
				pim_encoded_unicast_address *secaddr = (pim_encoded_unicast_address *)opt->data();
				for (int j = 0; j < count; j++) {
					in6_addr addr;
					memcpy(&addr, &secaddr->addr, sizeof(in6_addr));
					secaddr++;
					secaddrs.push_back(addr);
				}
			}
			break;
		}

		slen += sizeof(pim_hello_option) + optlen;
		opt = opt->next();
	}

	pim_neighbour *neigh = 0;
	for (neighbours_def::iterator i = neighbours.begin(); i != neighbours.end(); i++) {
		if ((*i)->localaddr() == inet6_addr(from->sin6_addr)) {
			neigh = *i;
			break;
		}
	}

	if (holdtime == 0) {
		if (neigh) {
			neighbour_timed_out(neigh);
			return;
		}
	}

	if (neigh && neigh->has_genid() && neigh->genid() != genid) {
		loginfo(NORMAL) << "Neighbour " << neigh->localaddr()
			<< " had different GenID, forcing neighbour timeout" << endl;
		remove_neighbour(neigh, false);
		neigh = 0;
	}

	bool is_new = false;

	if (!neigh) {
		neigh = new pim_neighbour(this, from->sin6_addr);
		if (neigh) {
			neighbours.push_back(neigh);
			is_new = true;
		} else {
			logwarn() << "failed to create neighbour state" << endl;
			return;
		}
	}

	neigh->set_secundary_addresses(secaddrs);

	if (has_dr_priority)
		neigh->set_dr_priority(dr_priority);
	if (has_genid)
		neigh->set_genid(genid);
	if (has_lan_delay)
		neigh->set_lan_delay(propdelay, overrinter, trackbit);

	neigh->set_holdtime(holdtime * 1000);

	if (is_new)
		found_new_neighbour(neigh);

	check_lan_delay();
	elect_subnet_dr();
}

void pim_interface::handle_joinprune(const sockaddr_in6 *_from, pim_joinprune_message *msg, uint16_t len) {
	/* Just to be sure */
	if (g_mrd->has_address(_from->sin6_addr))
		return;

	base_stream &os = loginfo(MESSAGE_CONTENT);
	os.inc_level();
	_debug_pim_dump(os, *msg);
	os.dec_level();

	inet6_addr upneigh(msg->upstream_neigh.addr);

	if (!g_mrd->has_address(upneigh)) {
		/* Lets monitor the Join/Prunes in the link
		 * to react properly */

		handle_external_joinprune(_from, msg, len);

		return;
	}

	pim_neighbour *neigh = pim->get_neighbour(_from->sin6_addr);
	if (!neigh) {
		loginfo(DEBUG) << "dropping JOIN/PRUNE message from " << _from->sin6_addr
			<< ", not from known neighbour" << endl;
		return;
	}

	uint16_t j, njs, nps;
	pim_group_node *node;
	pim_source_state_base *state;
	pim_encoded_source_address *addr;

	pim_joinprune_group *grp = msg->groups();

	for (uint8_t i = 0; i < msg->ngroups; i++, grp = grp->next()) {
		inet6_addr groupaddr(grp->maddr.addr, grp->maddr.masklen);

		groupconf *entry = g_mrd->match_group_configuration(groupaddr);
		pim_groupconf_node *info = entry ? (pim_groupconf_node *)entry->get_child("pim") : 0;

		njs = grp->join_count();
		nps = grp->prune_count();

		addr = grp->addrs();

		for (j = 0; j < njs; j++, addr++) {
			inet6_addr srcaddr(addr->addr, addr->masklen);

			if (addr->wc() && addr->rpt()) {
				if (!info || info->get_property_address("accept_rp").matches(srcaddr)) {
					address_set prunes;

					grp->pruned_addrs(prunes);

					handle_join_wc_rpt(groupaddr, srcaddr, prunes, ntohs(msg->holdtime), addr->rpt());
				} else {
					/// 3.2.2.1.1
				}
			} else if (!addr->wc() && !addr->rpt()) {
				handle_join_source(groupaddr, srcaddr, ntohs(msg->holdtime) * 1000, addr->rpt());
			} else {
				handle_join(groupaddr, srcaddr, ntohs(msg->holdtime) * 1000, addr->rpt());
			}
		}

		for (j = 0; j < nps; j++, addr++) {
			node = pim->get_group(groupaddr);
			if (node) {
				inet6_addr srcaddr(addr->addr, addr->masklen);

				if (!addr->wc()) {
					state = node->get_state(srcaddr, addr->rpt());

					if (state) {
						state->set_oif(owner(), ntohs(msg->holdtime) * 1000, false);
					}
				} else if (addr->wc() && addr->rpt()) {
					if (node->has_wildcard() && node->rpaddr() == srcaddr) {
						node->wildcard()->set_oif(owner(), 0, false);
					}
				}
			}
		}
	}
}

void pim_interface::handle_external_joinprune(const sockaddr_in6 *_from,
				pim_joinprune_message *msg, uint16_t len) {
	uint16_t j, njs, nps;
	pim_group_node *node;
	pim_encoded_source_address *addr;

	pim_neighbour *upneigh = pim->get_neighbour(msg->upstream_neigh.addr);
	if (!upneigh)
		return;

	uint32_t holdtime = ntohs(msg->holdtime) * 1000;

	pim_joinprune_group *grp = msg->groups();

	for (uint8_t i = 0; i < msg->ngroups; i++, grp = grp->next()) {
		inet6_addr groupaddr(grp->maddr.addr, grp->maddr.masklen);

		node = pim->get_group(groupaddr);
		if (!node)
			continue;

		njs = grp->join_count();
		nps = grp->prune_count();

		addr = grp->addrs();

		for (j = 0; j < njs; j++, addr++) {
			inet6_addr srcaddr(addr->addr, addr->masklen);

			if (!addr->wc() && !addr->rpt()) {
				pim_group_source_state *state = node->get_state(srcaddr);
				if (state && state->upstream_neighbour() == upneigh) {
					/* A (S,G) that is being currenty joined */

					/* If (S,G) is joined and we see a Join,
					 * supress our next one, if sent in the following
					 * `override` milisecs */
					if (state->upstream_path()->is_joined())
						state->upstream_path()->update_last_seen(holdtime);
				}
			}
		}

		for (j = 0; j < nps; j++, addr++) {
			inet6_addr srcaddr(addr->addr, addr->masklen);

			if (!addr->wc() && !addr->rpt()) {
				pim_group_source_state *state = node->get_state(srcaddr);
				if (state && state->upstream_neighbour() == upneigh) {
					/* A (S,G) that is being currenty pruned */

					/* If (S,G) is joined and we see a Prune,
					 * trigger a Join message upstream */
					if (state->upstream_path()->is_joined())
						state->upstream_path()->refresh_now();
				}
			}
		}
	}

}

struct create_group_pim_intf_context : mrd::create_group_context {
	address_set prunedaddrs;
	uint32_t holdtime;
	bool rpt, wc;
};

void pim_interface::handle_join_wc_rpt(const inet6_addr &grpaddr,
		const inet6_addr &src, const address_set &pruneaddrs,
		uint16_t ht, bool rpt) {

	group *grp = g_mrd->get_group_by_addr(grpaddr);

	uint32_t holdtime = ht * 1000;

	if (grp)
		handle_join_wc_rpt(grp, src, pruneaddrs, holdtime, rpt);
	else {
		create_group_pim_intf_context *ctx = new create_group_pim_intf_context;

		if (!ctx)
			return;

		ctx->groupaddr = grpaddr;
		ctx->requester = src;

		ctx->prunedaddrs = pruneaddrs;
		ctx->holdtime = holdtime;
		ctx->rpt = rpt;
		ctx->wc = true;

		g_mrd->create_group(pim, this, ctx);
	}
}

void pim_interface::event(int type, void *ptr) {
	if (type != mrd::CreatedGroup) {
		interface_node::event(type, ptr);
		return;
	}

	create_group_pim_intf_context *ctx = (create_group_pim_intf_context *)ptr;

	if (ctx->wc)
		handle_join_wc_rpt(ctx->result, ctx->requester, ctx->prunedaddrs, ctx->holdtime, ctx->rpt);
	else
		handle_join_source(ctx->result, ctx->requester, ctx->holdtime, ctx->rpt);

	delete ctx;
}

void pim_interface::handle_join_wc_rpt(group *grp, const inet6_addr &src,
		const address_set &pruneaddrs, uint32_t holdtime, bool rpt) {
	if (!grp)
		return;

	pim_group_node *node = (pim_group_node *)grp->node_owned_by(pim);

	/// 3.2.2.1.2
	if (!node) {
		/* Either PIM is disabled for this group or we didn't have
		 * enough memory in the past */
		return;
	}

	if (node->has_rp() && !(node->rpaddr() == src)) {
		/*
		 * We already have a group instance for G, and the currently
		 * used RP address differs from the requested one, ignore Join.
		 */
		return;
	}

	bool had = node->has_wildcard();

	if (!had) {
		if (!node->create_wildcard()) {
			return;
		}
	}

	node->wildcard()->set_oif(owner(), holdtime);

	if (!had) {
		rp_source rpsrc;
		inet6_addr possiblerp = node->rp_for_group(rpsrc);
		if (!(possiblerp == src)) {
			logwarn() << "configuration problem, requested RP"
				<< " is different from the RP that would be"
				<< " choosen. Accepting requested RP" << endl;
		}

		node->set_rp(src, rps_join);

		/// 3.2.2.1.5
		node->wildcard()->check_upstream_path();
	}

	handle_join(node, src, holdtime, rpt);
}

void pim_interface::handle_join_source(const inet6_addr &grpaddr, const inet6_addr &src, uint32_t holdtime, bool rpt) {
	group *grp = g_mrd->get_group_by_addr(grpaddr);

	if (grp)
		handle_join_source(grp, src, holdtime, rpt);
	else {
		create_group_pim_intf_context *ctx = new create_group_pim_intf_context;

		if (!ctx)
			return;

		ctx->groupaddr = grpaddr;
		ctx->requester = src;

		ctx->holdtime = holdtime;
		ctx->rpt = rpt;
		ctx->wc = false;

		g_mrd->create_group(pim, this, ctx);
	}
}

void pim_interface::handle_join_source(group *grp, const inet6_addr &src, uint32_t holdtime, bool rpt) {
	if (!grp)
		return;

	pim_group_node *node = (pim_group_node *)grp->node_owned_by(pim);

	if (!node)
		return;

	pim_source_state_base *state = node->get_state(src, rpt);

	if (!state) {
		/// 3.2.2.2

		/* If we don't have a state for G, as it is a join, downstream
		 * wanted to revert Prune to Join, which doesnt make sense here. */
		if (rpt)
			return;

		node->create_state(src, rpt, owner(), false, holdtime);

//		if (pimrouter->mrib().rpf_check(node, src, owner()))
//			node->create_state(src, owner(), false, holdtime);
//		else
//			g_mrd->log().debug() << "Downstream Join failed: RPF check failed." << endl;
	}

	handle_join(node, src, holdtime, rpt);
}

void pim_interface::handle_join(const inet6_addr &grpaddr, const inet6_addr &src, uint32_t holdtime, bool rpt) {
	group *grp = g_mrd->get_group_by_addr(grpaddr);
	if (!grp)
		return;

	pim_group_node *node = (pim_group_node *)grp->node_owned_by(pim);

	if (node)
		handle_join(node, src, holdtime, rpt);
}

void pim_interface::handle_join(pim_group_node *node, const inet6_addr &src, uint32_t holdtime, bool rpt) {
	pim_source_state_base *state = node->get_state(src, rpt);
	if (state)
		state->set_oif(owner(), holdtime);
}

void pim_interface::handle_bootstrap(const sockaddr_in6 *src, const sockaddr_in6 *dst,
					pim_bootstrap_message *msg, uint16_t length) {
#ifndef PIM_NO_BSR
	pim->bsr().handle_bootstrap_message(this, src, dst, msg, length);
#endif
}

void pim_interface::handle_assert(const sockaddr_in6 *from, pim_assert_message *msg, uint16_t length) {
	base_stream &os = loginfo(MESSAGE_CONTENT);
	os.inc_level();
	_debug_pim_dump(os, *msg);
	os.dec_level();

	if (!get_neighbour(from->sin6_addr))
		return;

	inet6_addr grpaddr(msg->gaddr.addr, msg->gaddr.masklen);
	pim_group_node *node = pim->get_group(grpaddr);

	bool rpt = ntohl(msg->metric_pref) & 0x80000000;
	uint32_t metric_pref = ntohl(msg->metric_pref) & 0x7fffffff;
	uint32_t metric = ntohl(msg->metric);

	if (node) {
		if (!IN6_IS_ADDR_UNSPECIFIED(&msg->saddr.addr)) {
			pim_group_source_state *state = node->get_state(msg->saddr.addr);
			if (state) {
				pim_common_oif::assert_state prev = pim_common_oif::AssertNoInfo;
				bool existed = false;

				pim_common_oif *oif = (pim_common_oif *)state->get_oif(owner());
				if (oif) {
					prev = oif->current_assert_state();
					existed = true;
				}

				state->handle_assert(owner(), from->sin6_addr,
						     rpt, metric, metric_pref);

				/* for some future reason the oif may be released meanwhile */
				oif = (pim_common_oif *)state->get_oif(owner());

				if (!oif && existed) {
					/* transitioned somehow */
					return;
				}

				pim_common_oif::assert_state current = oif ?
					oif->current_assert_state() : pim_common_oif::AssertNoInfo;

				if (current != pim_common_oif::AssertNoInfo || current != prev) {
					/* (S,G) Assert state machine is not NoInfo
					 * or a transition occurred: no (*,G) handling */
					return;
				}
			}
		}

		if (node->has_wildcard()) {
			node->wildcard()->handle_assert(owner(), from->sin6_addr,
						        rpt, metric, metric_pref);
		}
	}
}

void pim_interface::handle_register(const sockaddr_in6 *src, const sockaddr_in6 *dst) {
	g_mrd->ipktb->read_offset = g_mrd->ipktb->send_offset = sizeof(pim_register_message);
	g_mrd->ipktb->rlength -= sizeof(pim_register_message);

	pim_group_node *node = pim->get_group(g_mrd->ipktb->ip6_header()->ip6_dst);
	if (node)
		node->do_register(&src->sin6_addr, &dst->sin6_addr, *g_mrd->ipktb);
}

void pim_interface::handle_register_stop(const sockaddr_in6 *src) {
	pim_register_stop_message *msg = g_mrd->ipktb->header<pim_register_stop_message>();

	pim_group_node *node = pim->get_group(msg->gaddr.addr);
	if (node)
		node->register_stop(src->sin6_addr, msg->uaddr.addr);
}

void pim_interface::handle_candidate_rp_adv(const sockaddr_in6 *from,
			pim_candidate_rp_adv_message *msg, uint16_t len) {
#ifndef PIM_NO_BSR
	pim->bsr().handle_candidate_rp_adv(this, from, msg, len);
#endif
}

void pim_interface::neighbour_timed_out(pim_neighbour * &neigh) {
	loginfo(NORMAL) << "Neighbour " << neigh->localaddr() << " timed out" << endl;

	remove_neighbour(neigh, true);
}

void pim_interface::remove_neighbour(pim_neighbour *neigh, bool elect) {
	for (neighbours_def::iterator i = neighbours.begin(); i != neighbours.end(); i++) {
		if (*i == neigh) {
			neighbours.erase(i);

			if (elect) {
				check_lan_delay();
				elect_subnet_dr();
			}

			neigh->set_present(false);

			pim->lost_neighbour(neigh);
			neigh->shutdown();
			delete neigh;

			return;
		}
	}
}

void pim_interface::check_lan_delay() {
	m_landelay_enabled = true;

	for (neighbours_def::const_iterator i = neighbours.begin();
			m_landelay_enabled && i != neighbours.end(); ++i)
		m_landelay_enabled = (*i)->has_lan_delay();

	if (m_landelay_enabled) {
		m_propagation_delay = conf()->propagation_delay();
		m_override_interval = conf()->override_interval();

		for (neighbours_def::const_iterator i = neighbours.begin(); i != neighbours.end(); ++i) {
			if ((*i)->propagation_delay() > m_propagation_delay)
				m_propagation_delay = (*i)->propagation_delay();
			if ((*i)->override_interval() > m_override_interval)
				m_override_interval = (*i)->override_interval();
		}
	} else {
		m_propagation_delay = conf()->propagation_delay();
		m_override_interval = conf()->override_interval();
	}
}

bool pim_interface::suppression_enabled() const {
	if (!lan_delay_enabled())
		return true;

	for (neighbours_def::const_iterator i = neighbours.begin(); i != neighbours.end(); ++i) {
		if (!(*i)->tracking_support())
			return true;
	}

	return false;
}

uint32_t pim_interface::suppressed_value() const {
	if (!suppression_enabled())
		return 0;

	uint32_t a = (uint32_t)(conf()->joinprune_interval() * 1.1);
	uint32_t b = (uint32_t)(conf()->joinprune_interval() * 1.4);

	return a + rand() % (b-a);
}

void pim_interface::elect_subnet_dr() {
	bool mayuseprio = true;

	for (neighbours_def::const_iterator i = neighbours.begin(); mayuseprio && i != neighbours.end(); ++i)
		mayuseprio = (*i)->has_dr_priority();

	pim_neighbour *bestneigh = 0;

	// elect DR between known neighbours
	if (!neighbours.empty()) {
		bestneigh = *neighbours.begin();

		neighbours_def::const_iterator i = neighbours.begin();
		i++;

		for (; i != neighbours.end(); i++) {
			if (!mayuseprio || (bestneigh->dr_priority() == (*i)->dr_priority())) {
				if (bestneigh->localaddr() < (*i)->localaddr()) {
					bestneigh = *i;
				}
			} else if (bestneigh->dr_priority() < (*i)->dr_priority()) {
				bestneigh = *i;
			}
		}
	}

	// match the elected neighbour against us
	if (bestneigh) {
		uint32_t my_dr_prio = conf()->dr_priority();

		if (!mayuseprio || (my_dr_prio == bestneigh->dr_priority())) {
			if (bestneigh->localaddr() < inet6_addr(*owner()->linklocal()))
				bestneigh = 0;
		} else {
			if (my_dr_prio > bestneigh->dr_priority())
				bestneigh = 0;
		}
	}

	/* We must set elected_dr before calling dr_changed */
	pim_neighbour *old = elected_dr;

	elected_dr = bestneigh;

	if (old != bestneigh) {
		if (bestneigh && !old) {
			loginfo(NORMAL) << "no longer the DR. New DR is " << bestneigh->localaddr() << endl;
			pim->dr_changed(this, false);
		} else if (old && !bestneigh) {
			loginfo(NORMAL) << "im now the DR." << endl;
			pim->dr_changed(this, true);
		} else if (bestneigh) {
			loginfo(NORMAL) << "New DR is " << bestneigh->localaddr() << endl;
		}
	}
}

void pim_interface::found_new_neighbour(pim_neighbour *neigh) {
	loginfo(NORMAL) << "New Neighbour at " << neigh->localaddr() << endl;

	send_hello();

#ifndef PIM_NO_BSR
	if (am_dr()) {
		pim->bsr().found_new_neighbour(neigh);
	}
#endif

	pim->found_new_neighbour(neigh);
}

void pim_interface::send_hello() {
	send_hellox(conf()->holdtime() / 1000);
}

static inline void _hello_advance_option(int &optlen, pim_hello_option * &opt, int length) {
	optlen += sizeof(pim_hello_option) + length;
	opt = opt->next();
}

void pim_interface::send_hellox(uint16_t holdtime) {
	pim_hello_message *hellomsg = g_mrd->opktb->header<pim_hello_message>();

	hellomsg->construct();

	pim_hello_option *opt = hellomsg->options();

	int optlen = 0;

	opt->add_uint16(pim_hello_option::holdtime, holdtime);
	_hello_advance_option(optlen, opt, 2);

	if (owner()->is_multiaccess()) {
		opt->add_uint16pair(pim_hello_option::lan_prune_delay,
				    conf()->propagation_delay(),
				    conf()->override_interval());

		_hello_advance_option(optlen, opt, 4);
	}

	opt->add_uint32(pim_hello_option::genid, gen_id);
	_hello_advance_option(optlen, opt, 4);

	opt->add_uint32(pim_hello_option::dr_priority, conf()->dr_priority());
	_hello_advance_option(optlen, opt, 4);

	const std::set<inet6_addr> &addrs = owner()->globals();
	if (!addrs.empty()) {
		opt->construct(pim_hello_option::addrlist, addrs.size() * sizeof(pim_encoded_unicast_address));

		pim_encoded_unicast_address *addr = (pim_encoded_unicast_address *)opt->data();
		for (std::set<inet6_addr>::const_iterator i = addrs.begin(); i != addrs.end(); i++, addr++) {
			addr->construct(*i);
		}

		_hello_advance_option(optlen, opt, addrs.size() * sizeof(pim_encoded_unicast_address));
	}

	loginfo(MESSAGE_SIG) << "HELLO message to All-Routers, holdtime = " << holdtime << endl;

	send_all_routers(hellomsg, sizeof(pim_hello_message) + optlen);
}

bool pim_interface::call_method(int id, base_stream &out,
				const std::vector<std::string> &args) {
	switch (id) {
	case pim_intf_method_flap:
		return flap_neighbour(out, args, false);
	case pim_intf_method_force_timeout:
		return flap_neighbour(out, args, true);
	}

	return interface_node::call_method(id, out, args);
}

bool pim_interface::flap_neighbour(base_stream &out,
				   const std::vector<std::string> &args,
				   bool remove) {
	if (args.empty())
		return false;

	inet6_addr addr;
	if (!addr.set(args[0]))
		return false;

	pim_neighbour *neigh = 0;
	neighbours_def::iterator i;

	for (i = neighbours.begin(); i != neighbours.end(); i++) {
		if ((*i)->has_address(addr)) {
			neigh = *i;
			break;
		}
	}

	if (!neigh) {
		out << "No such neighbour." << endl;
	} else {
		if (remove) {
			neighbour_timed_out(neigh);
		} else {
			neighbours.erase(i);
			pim->lost_neighbour(neigh);
			neighbours.push_back(neigh);
			pim->found_new_neighbour(neigh);
		}
	}

	return true;
}

void pim_interface::property_changed(node *n, const char *name) {
	if (!strcmp(name, "dr_priority")) {
		if (conf()) {
			loginfo(DEBUG) << "Changed DR-Priority to "
				<< conf()->dr_priority() << endl;

			send_hello();
			elect_subnet_dr();
		}
	} else if (!strcmp(name, "hello_interval")) {
		update_hello_interval(conf()->hello_interval());
	}
}

void pim_interface::update_hello_interval(uint32_t value) {
	if (value == 0) {
		if (hello_timer_id.is_running())
			loginfo(DEBUG) << "Hello Interval set to 0, entering Passive mode." << endl;
		hello_timer_id.stop();
	} else if (intf_state >= LOCAL_READY) {
		hello_timer_id.start_or_update(value, true);
	} else {
		hello_timer_id.update(value, true);
	}
}

uint32_t pim_interface::effective_propagation_delay() const {
	return m_propagation_delay;
}

uint32_t pim_interface::effective_override_interval() const {
	return m_override_interval;
}

bool pim_interface::lan_delay_enabled() const {
	return m_landelay_enabled;
}

base_stream &operator << (base_stream &os, const pim_interface &intf) {
	return os << "PIM(" << *intf.owner() << ")";
}

base_stream &pim_interface::loginfo(int level) const {
	return pim->log().info(level) << *this << " ";
}

base_stream &pim_interface::logwarn() const {
	return pim->log().warn() << *this << " ";
}

