/*
 * Note: this file originally auto-generated by mib2c using
 *        : mib2c.array-user.conf,v 5.18.2.4 2005/04/26 22:13:28 rstory Exp $
 *
 * $Id: dlkEnterpriseClientListTable.h,v 1.1.1.1 2007/08/30 10:28:09 roy Exp $
 *
 * Yes, there is lots of code here that you might not use. But it is much
 * easier to remove code than to add it!
 */
#ifndef DLKENTERPRISECLIENTLISTTABLE_H
#define DLKENTERPRISECLIENTLISTTABLE_H

#ifdef __cplusplus
extern          "C" {
#endif


#include <net-snmp/net-snmp-config.h>
#include <net-snmp/library/container.h>
#include <net-snmp/agent/table_array.h>

        /** Index clientListIndex is internal */

    typedef struct dlkEnterpriseClientListTable_context_s {
        netsnmp_index   index;
                         /** THIS MUST BE FIRST!!! */

    /*************************************************************
     * You can store data internally in this structure.
     *
     * TODO: You will probably have to fix a few types here...
     */
        /** INTEGER = ASN_INTEGER */
        long            clientListIndex;

        /** OCTETSTR = ASN_OCTET_STR */
        unsigned char   clientList[65535];
        long            clientList_len;


        /*
         * OR
         *
         * Keep a pointer to your data
         */
        void           *data;

        /*
         *add anything else you want here
         */

    } dlkEnterpriseClientListTable_context;

/*************************************************************
 * function declarations
 */
    void            init_dlkEnterpriseClientListTable(void);
    void            initialize_table_dlkEnterpriseClientListTable(void);
    const dlkEnterpriseClientListTable_context
        *dlkEnterpriseClientListTable_get_by_idx(netsnmp_index *);
    const dlkEnterpriseClientListTable_context
        *dlkEnterpriseClientListTable_get_by_idx_rs(netsnmp_index *,
                                                    int row_status);
    int            
        dlkEnterpriseClientListTable_get_value(netsnmp_request_info *,
                                               netsnmp_index *,
                                               netsnmp_table_request_info
                                               *);


/*************************************************************
 * oid declarations
 */
    extern oid      dlkEnterpriseClientListTable_oid[];
    extern size_t   dlkEnterpriseClientListTable_oid_len;

#define dlkEnterpriseClientListTable_TABLE_OID 1,3,6,1,4,1,171,1,4,2,8,1

/*************************************************************
 * column number definitions for table dlkEnterpriseClientListTable
 */
#define COLUMN_CLIENTLISTINDEX 1
#define COLUMN_CLIENTLIST 2
#define dlkEnterpriseClientListTable_COL_MIN 1
#define dlkEnterpriseClientListTable_COL_MAX 2

    /*
     * comment out the following line if you don't handle SET-REQUEST for dlkEnterpriseClientListTable 
     */
#define dlkEnterpriseClientListTable_SET_HANDLING

    /*
     * comment out the following line if you can't create new rows 
     */
#define dlkEnterpriseClientListTable_ROW_CREATION

    /*
     * comment out the following line if you don't want the secondary index 
     */
#define dlkEnterpriseClientListTable_IDX2

#ifdef dlkEnterpriseClientListTable_SET_HANDLING

    int            
        dlkEnterpriseClientListTable_extract_index
        (dlkEnterpriseClientListTable_context * ctx, netsnmp_index * hdr);

    void           
        dlkEnterpriseClientListTable_set_reserve1(netsnmp_request_group *);
    void           
        dlkEnterpriseClientListTable_set_reserve2(netsnmp_request_group *);
    void           
        dlkEnterpriseClientListTable_set_action(netsnmp_request_group *);
    void           
        dlkEnterpriseClientListTable_set_commit(netsnmp_request_group *);
    void           
        dlkEnterpriseClientListTable_set_free(netsnmp_request_group *);
    void           
        dlkEnterpriseClientListTable_set_undo(netsnmp_request_group *);

    dlkEnterpriseClientListTable_context
        *dlkEnterpriseClientListTable_duplicate_row
        (dlkEnterpriseClientListTable_context *);
    netsnmp_index 
        *dlkEnterpriseClientListTable_delete_row
        (dlkEnterpriseClientListTable_context *);

    int            
        dlkEnterpriseClientListTable_can_delete
        (dlkEnterpriseClientListTable_context * undo_ctx,
         dlkEnterpriseClientListTable_context * row_ctx,
         netsnmp_request_group * rg);


#ifdef dlkEnterpriseClientListTable_ROW_CREATION
    dlkEnterpriseClientListTable_context
        *dlkEnterpriseClientListTable_create_row(netsnmp_index *);
#endif
#endif

#ifdef dlkEnterpriseClientListTable_IDX2
    dlkEnterpriseClientListTable_context
        *dlkEnterpriseClientListTable_get(const char *name, int len);
#endif

#ifdef __cplusplus
}
#endif
#endif /** DLKENTERPRISECLIENTLISTTABLE_H */
