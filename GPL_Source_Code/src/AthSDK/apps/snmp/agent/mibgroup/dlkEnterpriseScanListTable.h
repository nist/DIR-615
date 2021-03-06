/*
 * Note: this file originally auto-generated by mib2c using
 *        : mib2c.array-user.conf,v 5.18.2.4 2005/04/26 22:13:28 rstory Exp $
 *
 * $Id: dlkEnterpriseScanListTable.h,v 1.1.1.1 2007/08/30 10:28:09 roy Exp $
 *
 * Yes, there is lots of code here that you might not use. But it is much
 * easier to remove code than to add it!
 */
#ifndef DLKENTERPRISESCANLISTTABLE_H
#define DLKENTERPRISESCANLISTTABLE_H

#ifdef __cplusplus
extern          "C" {
#endif


#include <net-snmp/net-snmp-config.h>
#include <net-snmp/library/container.h>
#include <net-snmp/agent/table_array.h>

        /** Index scanListIndex is internal */

    typedef struct dlkEnterpriseScanListTable_context_s {
        netsnmp_index   index;
                         /** THIS MUST BE FIRST!!! */

    /*************************************************************
     * You can store data internally in this structure.
     *
     * TODO: You will probably have to fix a few types here...
     */
        /** INTEGER = ASN_INTEGER */
        long            scanListIndex;

        /** OCTETSTR = ASN_OCTET_STR */
        unsigned char   scanList[65535];
        long            scanList_len;


        /*
         * OR
         *
         * Keep a pointer to your data
         */
        void           *data;

        /*
         *add anything else you want here
         */

    } dlkEnterpriseScanListTable_context;

/*************************************************************
 * function declarations
 */
    void            init_dlkEnterpriseScanListTable(void);
    void            initialize_table_dlkEnterpriseScanListTable(void);
    const dlkEnterpriseScanListTable_context
        *dlkEnterpriseScanListTable_get_by_idx(netsnmp_index *);
    const dlkEnterpriseScanListTable_context
        *dlkEnterpriseScanListTable_get_by_idx_rs(netsnmp_index *,
                                                  int row_status);
    int            
        dlkEnterpriseScanListTable_get_value(netsnmp_request_info *,
                                             netsnmp_index *,
                                             netsnmp_table_request_info *);


/*************************************************************
 * oid declarations
 */
    extern oid      dlkEnterpriseScanListTable_oid[];
    extern size_t   dlkEnterpriseScanListTable_oid_len;

#define dlkEnterpriseScanListTable_TABLE_OID 1,3,6,1,4,1,171,1,2,1,10,1

/*************************************************************
 * column number definitions for table dlkEnterpriseScanListTable
 */
#define COLUMN_SCANLISTINDEX 1
#define COLUMN_SCANLIST 2
#define dlkEnterpriseScanListTable_COL_MIN 1
#define dlkEnterpriseScanListTable_COL_MAX 2

    /*
     * comment out the following line if you don't handle SET-REQUEST for dlkEnterpriseScanListTable 
     */
#define dlkEnterpriseScanListTable_SET_HANDLING

    /*
     * comment out the following line if you can't create new rows 
     */
#define dlkEnterpriseScanListTable_ROW_CREATION

    /*
     * comment out the following line if you don't want the secondary index 
     */
#define dlkEnterpriseScanListTable_IDX2

#ifdef dlkEnterpriseScanListTable_SET_HANDLING

    int            
        dlkEnterpriseScanListTable_extract_index
        (dlkEnterpriseScanListTable_context * ctx, netsnmp_index * hdr);

    void           
        dlkEnterpriseScanListTable_set_reserve1(netsnmp_request_group *);
    void           
        dlkEnterpriseScanListTable_set_reserve2(netsnmp_request_group *);
    void           
        dlkEnterpriseScanListTable_set_action(netsnmp_request_group *);
    void           
        dlkEnterpriseScanListTable_set_commit(netsnmp_request_group *);
    void           
        dlkEnterpriseScanListTable_set_free(netsnmp_request_group *);
    void           
        dlkEnterpriseScanListTable_set_undo(netsnmp_request_group *);

    dlkEnterpriseScanListTable_context
        *dlkEnterpriseScanListTable_duplicate_row
        (dlkEnterpriseScanListTable_context *);
    netsnmp_index 
        *dlkEnterpriseScanListTable_delete_row
        (dlkEnterpriseScanListTable_context *);

    int            
        dlkEnterpriseScanListTable_can_delete
        (dlkEnterpriseScanListTable_context * undo_ctx,
         dlkEnterpriseScanListTable_context * row_ctx,
         netsnmp_request_group * rg);


#ifdef dlkEnterpriseScanListTable_ROW_CREATION
    dlkEnterpriseScanListTable_context
        *dlkEnterpriseScanListTable_create_row(netsnmp_index *);
#endif
#endif

#ifdef dlkEnterpriseScanListTable_IDX2
    dlkEnterpriseScanListTable_context
        *dlkEnterpriseScanListTable_get(const char *name, int len);
#endif

#ifdef __cplusplus
}
#endif
#endif /** DLKENTERPRISESCANLISTTABLE_H */
