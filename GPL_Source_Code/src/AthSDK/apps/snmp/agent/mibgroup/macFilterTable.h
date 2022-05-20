/*
 * Note: this file originally auto-generated by mib2c using
 *        : mib2c.array-user.conf,v 5.18.2.4 2005/04/26 22:13:28 rstory Exp $
 *
 * $Id: macFilterTable.h,v 1.1.1.1 2007/08/30 10:28:09 roy Exp $
 *
 * Yes, there is lots of code here that you might not use. But it is much
 * easier to remove code than to add it!
 */
#ifndef MACFILTERTABLE_H
#define MACFILTERTABLE_H

#ifdef __cplusplus
extern          "C" {
#endif


#include <net-snmp/net-snmp-config.h>
#include <net-snmp/library/container.h>
#include <net-snmp/agent/table_array.h>

        /** Index macFilterIndex is internal */

    typedef struct macFilterTable_context_s {
        netsnmp_index   index;
                         /** THIS MUST BE FIRST!!! */

    /*************************************************************
     * You can store data internally in this structure.
     *
     * TODO: You will probably have to fix a few types here...
     */
        /** INTEGER = ASN_INTEGER */
        long            macFilterIndex;

        /** OCTETSTR = ASN_OCTET_STR */
        unsigned char   macFilterList[65535];
        long            macFilterList_len;


        /*
         * OR
         *
         * Keep a pointer to your data
         */
        void           *data;

        /*
         *add anything else you want here
         */

    } macFilterTable_context;

/*************************************************************
 * function declarations
 */
    void            init_macFilterTable(void);
    void            initialize_table_macFilterTable(void);
    const macFilterTable_context *macFilterTable_get_by_idx(netsnmp_index
                                                            *);
    const macFilterTable_context
        *macFilterTable_get_by_idx_rs(netsnmp_index *, int row_status);
    int             macFilterTable_get_value(netsnmp_request_info *,
                                             netsnmp_index *,
                                             netsnmp_table_request_info *);


/*************************************************************
 * oid declarations
 */
    extern oid      macFilterTable_oid[];
    extern size_t   macFilterTable_oid_len;

#define macFilterTable_TABLE_OID 1,3,6,1,4,1,171,1,5,6,2

/*************************************************************
 * column number definitions for table macFilterTable
 */
#define COLUMN_MACFILTERINDEX 1
#define COLUMN_MACFILTERLIST 2
#define macFilterTable_COL_MIN 1
#define macFilterTable_COL_MAX 2

    /*
     * comment out the following line if you don't handle SET-REQUEST for macFilterTable 
     */
#define macFilterTable_SET_HANDLING

    /*
     * comment out the following line if you can't create new rows 
     */
#define macFilterTable_ROW_CREATION

    /*
     * comment out the following line if you don't want the secondary index 
     */
#define macFilterTable_IDX2

#ifdef macFilterTable_SET_HANDLING

    int             macFilterTable_extract_index(macFilterTable_context *
                                                 ctx, netsnmp_index * hdr);

    void            macFilterTable_set_reserve1(netsnmp_request_group *);
    void            macFilterTable_set_reserve2(netsnmp_request_group *);
    void            macFilterTable_set_action(netsnmp_request_group *);
    void            macFilterTable_set_commit(netsnmp_request_group *);
    void            macFilterTable_set_free(netsnmp_request_group *);
    void            macFilterTable_set_undo(netsnmp_request_group *);

    macFilterTable_context
        *macFilterTable_duplicate_row(macFilterTable_context *);
    netsnmp_index  *macFilterTable_delete_row(macFilterTable_context *);

    int             macFilterTable_can_delete(macFilterTable_context *
                                              undo_ctx,
                                              macFilterTable_context *
                                              row_ctx,
                                              netsnmp_request_group * rg);


#ifdef macFilterTable_ROW_CREATION
    macFilterTable_context *macFilterTable_create_row(netsnmp_index *);
#endif
#endif

#ifdef macFilterTable_IDX2
    macFilterTable_context *macFilterTable_get(const char *name, int len);
#endif

#ifdef __cplusplus
}
#endif
#endif /** MACFILTERTABLE_H */