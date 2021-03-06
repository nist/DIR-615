/*
 * Note: this file originally auto-generated by mib2c using
 *        : mib2c.scalar.conf,v 1.7 2003/04/08 14:57:04 dts12 Exp $
 */

#include <net-snmp/net-snmp-config.h>
#include <net-snmp/net-snmp-includes.h>
#include <net-snmp/agent/net-snmp-agent-includes.h>
#include "jackey.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
/** Initializes the jackey module */
void
init_jackey(void)
{
    static oid      testSNMPSet_oid[] = { 1, 3, 6, 1, 4, 1, 1, 1 };

    DEBUGMSGTL(("jackey", "Initializing\n"));

    netsnmp_register_scalar(netsnmp_create_handler_registration
                            ("testSNMPSet", handle_testSNMPSet,
                             testSNMPSet_oid, OID_LENGTH(testSNMPSet_oid),
                             HANDLER_CAN_RWRITE));
}
struct in_addr test;
static long ipsettest;
int
handle_testSNMPSet(netsnmp_mib_handler *handler,
                   netsnmp_handler_registration *reginfo,
                   netsnmp_agent_request_info *reqinfo,
                   netsnmp_request_info *requests)
{
    /*
     * We are never called for a GETNEXT if it's registered as a
     * "instance", as it's "magically" handled for us.  
     */

    /*
     * a instance handler also only hands us one request at a time, so
     * we don't need to loop over a list of requests; we'll only get one. 
     */

    switch (reqinfo->mode) {

	
    case MODE_GET:
       
	inet_aton("192.168.0.1",&test);
	
	snmp_set_var_typed_value(requests->requestvb, ASN_IPADDRESS,
                                 (u_char *)
                                 &test.s_addr/* XXX: a pointer to the scalar's data */
                                 ,sizeof(uint32_t)
                                 /*
                                  * XXX: the length of the data in bytes 
                                  */ );
        break;

        /*
         * SET REQUEST
         *
         * multiple states in the transaction.  See:
         * http://www.net-snmp.org/tutorial-5/toolkit/mib_module/set-actions.jpg
         */
    case MODE_SET_RESERVE1:
	ipsettest = *((long *) requests->requestvb->val.string);
	test.s_addr = ipsettest;
	//printf("IP is %s\n",inet_ntoa(test));	
//        if ( /* XXX: check incoming data in requests->requestvb->val.XXX for failures, like an incorrect type or an illegal value or ... */ ) {
//            netsnmp_set_request_error(reqinfo, requests,
                                      /* XXX: set error code depending on problem (like SNMP_ERR_WRONGTYPE or SNMP_ERR_WRONGVALUE or ... */
//                                      );
//        }
	if(strcmp(inet_ntoa(test),"NULL") == 0 || strcmp(inet_ntoa(test),"0.0.0.0") == 0)
		netsnmp_set_request_error(reqinfo, requests,SNMP_ERR_WRONGVALUE);
        break;

    case MODE_SET_RESERVE2:
        /*
         * XXX malloc "undo" storage buffer 
         */
//        if ( /* XXX if malloc, or whatever, failed: */ ) {
//            netsnmp_set_request_error(reqinfo, requests,
//                                      SNMP_ERR_RESOURCEUNAVAILABLE);
//        }
        break;

    case MODE_SET_FREE:
        /*
         * XXX: free resources allocated in RESERVE1 and/or
         * RESERVE2.  Something failed somewhere, and the states
         * below won't be called. 
         */
        break;

    case MODE_SET_ACTION:
        /*
         * XXX: perform the value change here 
         */
//        if ( /* XXX: error? */ ) {
//            netsnmp_set_request_error(reqinfo, requests, /* some error */
//                                      );
//        }
	
        break;

    case MODE_SET_COMMIT:
        /*
         * XXX: delete temporary storage 
         */
//        if ( /* XXX: error? */ ) {
            /*
             * try _really_really_ hard to never get to this point 
             */
//            netsnmp_set_request_error(reqinfo, requests,
//                                      SNMP_ERR_COMMITFAILED);
//        }
        break;

    case MODE_SET_UNDO:
        /*
         * XXX: UNDO and return to previous value for the object 
         */
//        if ( /* XXX: error? */ ) {
            /*
             * try _really_really_ hard to never get to this point 
             */
//            netsnmp_set_request_error(reqinfo, requests,
//                                      SNMP_ERR_UNDOFAILED);
//        }
        break;

    default:
        /*
         * we should never get here, so this is a really bad error 
         */
        return SNMP_ERR_GENERR;
    }

    return SNMP_ERR_NOERROR;
}
