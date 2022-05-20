#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <unistd.h>

#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <arpa/inet.h>
#include <net/if.h>

#include <snmp/snmp.h>
#include <snmp/snmp_primitives.h>

class testhandler : public snmp::mib_handler {
public:
	bool handle_get(bool, const snmp::varbind &, snmp::varbind &) const;
};

bool testhandler::handle_get(bool next, const snmp::varbind &req, snmp::varbind &resp) const {
	resp.get_value().instantiate(0x2);

	((asn::integer &)*resp.get_value()) = 23;

	return true;
}

int main(int argc, char **argv) {
	snmp::reg_agent john;

	if (!john.check_startup()) {
		perror("failed to init john");
		return -1;
	}

	john.register_mib(asn::oid("1.3.6.1.2.1.1"), new testhandler());

	while (1) {
		john.data_available();
	}

	return 0;
}

