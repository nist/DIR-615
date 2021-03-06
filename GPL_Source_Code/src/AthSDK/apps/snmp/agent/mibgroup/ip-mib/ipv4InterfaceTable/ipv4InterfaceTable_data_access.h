/*
 * Note: this file originally auto-generated by mib2c using
 *       version : 1.17 $ of : mfd-data-access.m2c,v $
 *
 * $Id: ipv4InterfaceTable_data_access.h,v 1.1.1.1 2007/08/30 10:28:11 roy Exp $
 */
#ifndef IPV4INTERFACETABLE_DATA_ACCESS_H
#define IPV4INTERFACETABLE_DATA_ACCESS_H

#ifdef __cplusplus
     extern          "C" {
#endif


         /*
          *********************************************************************
          * function declarations
          */

         /*
          *********************************************************************
          * Table declarations
          */
/**********************************************************************
 **********************************************************************
 ***
 *** Table ipv4InterfaceTable
 ***
 **********************************************************************
 **********************************************************************/
         /*
          * IP-MIB::ipv4InterfaceTable is subid 28 of ip.
          * Its status is Current.
          * OID: .1.3.6.1.2.1.4.28, length: 8
          */


         int
             ipv4InterfaceTable_init_data(ipv4InterfaceTable_registration *
                                          ipv4InterfaceTable_reg);


         void           
             ipv4InterfaceTable_container_init(netsnmp_container
                                               **container_ptr_ptr);
         void            ipv4InterfaceTable_container_shutdown(netsnmp_container
                                                               *container_ptr);

         int            
             ipv4InterfaceTable_container_load(netsnmp_container
                                               *container);
         void           
             ipv4InterfaceTable_container_free(netsnmp_container
                                               *container);

         int
             ipv4InterfaceTable_row_prep(ipv4InterfaceTable_rowreq_ctx *
                                         rowreq_ctx);

         void
             ipv4InterfaceTable_check_entry_for_updates(const
                                                        ifTable_rowreq_ctx
                                                        * ift_rrc,
                                                        netsnmp_interface_entry
                                                        *entry);


#ifdef __cplusplus
     }
#endif
#endif                          /* IPV4INTERFACETABLE_DATA_ACCESS_H */
