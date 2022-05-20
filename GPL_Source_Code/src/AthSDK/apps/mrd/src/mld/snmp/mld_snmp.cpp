#include <mrdpriv/snmp/snmp_module.h>

#include <mrdpriv/mld/router.h>

extern mld_router *mldrouter;

class snmp_mld_interface_table : public snmp::mib_table {
public:
	snmp_mld_interface_table();

	bool first_row(index &) const;
	bool next_row(index &) const;
	void get_value(const index &, int, snmp::any &) const;
};

class snmp_mld_cache_table : public snmp::mib_table {
public:
	snmp_mld_cache_table();

	bool first_row(index &) const;
	bool next_row(index &) const;
	void get_value(const index &, int, snmp::any &) const;
};

static snmp_mld_interface_table mld_intftable;
static snmp_mld_cache_table mld_cachetable;

snmp_mld_interface_table::snmp_mld_interface_table() {
	columns.insert(2);
	// columns.insert(3);
	columns.insert(4);
	columns.insert(5);
	columns.insert(6);
	columns.insert(9);
	columns.insert(11);
	columns.insert(12);
	columns.insert(13);

	indexes.push_back(0x2);
}

bool snmp_mld_interface_table::first_row(index &ndx) const {
#if 1
	return false;
#else
	if (!ndx.empty() || mldrouter->m_interfaces.empty())
		return false;

	ndx.push_back(snmp::any());
	return ndx.back().instantiate_with<asn::integer>(mldrouter->m_interfaces.begin()->first);
#endif
}

bool snmp_mld_interface_table::next_row(index &ndx) const {
#if 1
	return false;
#else
	if (ndx.size() != 1 || ndx.back()->get_type() != 0x2)
		return false;

	int index = ndx.back().value<const asn::integer>();

	mld_router::interfaces::const_iterator k = mldrouter->m_interfaces.find(index);
	if (k != mldrouter->m_interfaces.end())
		k++;
	if (k == mldrouter->m_interfaces.end())
		return false;

	ndx.back().value<asn::integer>() = k->first;
	
	return true;
#endif
}

void snmp_mld_interface_table::get_value(const index &ndx, int col, snmp::any &value) const {
#if 0
	if (ndx.size() != 1 || ndx.back()->get_type() != 0x2)
		return;

	mld_router::interfaces::const_iterator k = mldrouter->m_interfaces.find(ndx.back().value<asn::integer>());
	if (k == mldrouter->m_interfaces.end())
		return;

	const mld_interface *intf = k->second;

	switch (col) {
	case 2:
		value.instantiate_with<asn::unsigned32>(intf->intf->conf()->child(MLDI)->optint(query_interval) / 1000);
		break;
	case 4:
		value.instantiate_with<asn::unsigned32>(intf->get_current_version());
		break;
	case 5:
		if (intf->is_querier())
			value.instantiate_with<asn::octet_string>(asn::octet_string(intf->intf->linklocal(), 16));
		else
			value.instantiate_with<asn::octet_string>(asn::octet_string(&in6addr_any, 16));
		break;
	case 6:
		value.instantiate_with<asn::unsigned32>(intf->intf->conf()->child(MLDI)->optint(query_response_interval) / 1000);
		break;
	case 9:
		value.instantiate_with<asn::unsigned32>(intf->intf->conf()->child(MLDI)->optint(robustness_variable));
		break;
	case 11: {
		interface *proxyintf = 0;
		mld_intfconf_node *conf = (mld_intfconf_node *)intf->intf->conf()->child(MLDI);
		if (conf->redirect_signaling) {
			proxyintf = g_mrd->get_interface_by_name(conf->redirect_interface);
		}
		value.instantiate_with<asn::integer>(proxyintf ? proxyintf->index() : 0);
		break;
		}
	case 12:
	case 13:
		if (value.instantiate(0x43))
			value.value<asn::unsigned32>() = intf->get_querier_expiry_time();
		break;
	}
#endif
}

snmp_mld_cache_table::snmp_mld_cache_table() {
	columns.insert(4);
	columns.insert(5);
	columns.insert(6);

	indexes.push_back(0x4);
	indexes.push_back(0x2);
}

bool snmp_mld_cache_table::first_row(index &ndx) const {
	return false;
#if 0
	if (ndx.size() > 1)
		return false;

	if (mldrouter->m_groups.empty())
		return false;

	const mld_group *grp = 0;

	for (mld_router::groups::const_iterator k = mldrouter->m_groups.begin(); k != mldrouter->m_groups.end(); k++) {
		if (!k->second->g_oifs.empty()) {
			grp = k->second;
			break;
		}
	}

	if (!grp)
		return false;
	
	if (ndx.empty()) {
		ndx.push_back(snmp::any());
		if (!ndx.back().instantiate_with<asn::octet_string>(asn::octet_string(grp->owner()->id().address_p(), 16)))
			return false;
	}

	ndx.push_back(snmp::any());

	return ndx.back().instantiate_with<asn::integer>(grp->g_oifs.begin()->first);
#endif
}

bool snmp_mld_cache_table::next_row(index &ndx) const {
	return false;
}

void snmp_mld_cache_table::get_value(const index &ndx, int col, snmp::any &value) const {
#if 0
	if (ndx.size() != 2)
		return;

	inet6_addr addr(ndx.front().value<asn::octet_string>());
	int index = ndx.back().value<asn::integer>();

	std::cerr << "snmp_mld_cache_table::get_value addr: " << addr << std::endl;

	const mld_group *grp = 0;

	for (mld_router::groups::const_iterator k = mldrouter->m_groups.begin(); k != mldrouter->m_groups.end(); k++) {
		if (k->first->id() == addr) {
			grp = k->second;
			break;
		}
	}

	if (!grp)
		return;

	group_interface *_gintf = grp->owner()->local_oif(index);
	if (!_gintf || const_cast<const group_node *>(_gintf->owner_node()) != grp)
		return;

	mld_group_interface *gintf = (mld_group_interface *)_gintf;

	switch (col) {
	case 4:
		// cache last reporter
		value.instantiate_with<asn::octet_string>
			(asn::octet_string(gintf->last_reporter().address_p(), 16));
		break;
	case 5:
		// cache up time
		if (value.instantiate(0x43))
			value.value<asn::unsigned32>() = gintf->uptime() / 10;
		break;
	case 6:
		// cache expiry time
		if (value.instantiate(0x43))
			value.value<asn::unsigned32>() = gintf->time_left_to_expiry() / 10;
		break;
	}
#endif
}

class mld_snmp_module : public mrd_module {
public:
	mld_snmp_module(mrd *m, void *dl) : mrd_module(m, dl) {}

	bool check_startup() { return true; }

	void instantiate_with(snmp_module *);

	void module_loaded(const std::string &name, mrd_module *);
};

module_entry(mld_snmp, mld_snmp_module);

void mld_snmp_module::instantiate_with(snmp_module *snmp) {
	if (!snmp->register_mib(asn::oid("1.3.6.1.2.1.91.1.1.1"), &mld_intftable)) {
		m_mrd->log().warn() << "(MLD SNMP) failed to load MLD interface table MIB" << endl;
	}

	if (!snmp->register_mib(asn::oid("1.3.6.1.2.1.91.1.2.1"), &mld_cachetable)) {
		m_mrd->log().warn() << "(MLD SNMP) failed to load MLD cache table MIB" << endl;
	}
}

void mld_snmp_module::module_loaded(const std::string &name, mrd_module *mld) {
	if (name == "snmp") {
		instantiate_with((snmp_module *)mld);
	}
}

