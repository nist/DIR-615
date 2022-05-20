/*
 * Note: this file originally auto-generated by mib2c using
 *       : mib2c.array-user.conf,v 5.18.2.4 2005/04/26 22:13:28 rstory Exp $
 *
 * $Id: macFilterTable.c,v 1.1.1.1 2007/08/30 10:28:09 roy Exp $
 *
 *
 * For help understanding NET-SNMP in general, please check the 
 *     documentation and FAQ at:
 *
 *     http://www.net-snmp.org/
 *
 *
 * For help understanding this code, the agent and how it processes
 *     requests, please check the following references.
 *
 *     http://www.net-snmp.org/tutorial-5/
 *
 *
 * You can also join the #net-snmp channel on irc.freenode.net
 *     and ask for help there.
 *
 *
 * And if all else fails, send a detailed message to the developers
 *     describing the problem you are having to:
 *
 *    net-snmp-coders@lists.sourceforge.net
 *
 *
 * Yes, there is lots of code here that you might not use. But it is much
 * easier to remove code than to add it!
 */
#include <net-snmp/net-snmp-config.h>
#include <net-snmp/net-snmp-includes.h>
#include <net-snmp/agent/net-snmp-agent-includes.h>

#include <net-snmp/library/snmp_assert.h>

#include "macFilterTable.h"

static netsnmp_handler_registration *my_handler = NULL;
static netsnmp_table_array_callbacks cb;

oid             macFilterTable_oid[] = { macFilterTable_TABLE_OID };
size_t          macFilterTable_oid_len = OID_LENGTH(macFilterTable_oid);

#define MACSIZE 5
#ifdef macFilterTable_IDX2
/************************************************************
 * keep binary tree to find context by name
 */
static int      macFilterTable_cmp(const void *lhs, const void *rhs);

/************************************************************
 * compare two context pointers here. Return -1 if lhs < rhs,
 * 0 if lhs == rhs, and 1 if lhs > rhs.
 */
static int
macFilterTable_cmp(const void *lhs, const void *rhs)
{
    macFilterTable_context *context_l = (macFilterTable_context *) lhs;
    macFilterTable_context *context_r = (macFilterTable_context *) rhs;

    /*
     * check primary key, then secondary. Add your own code if
     * there are more than 2 indexes
     */
    int             rc;

    /*
     * TODO: implement compare. Remove this ifdef code and
     * add your own code here.
     */
#ifdef TABLE_CONTAINER_TODO
    snmp_log(LOG_ERR,
             "macFilterTable_compare not implemented! Container order undefined\n");
    return 0;
#endif

    /*
     * EXAMPLE (assuming you want to sort on a name):
     *   
     * rc = strcmp( context_l->xxName, context_r->xxName );
     *
     * if(rc)
     *   return rc;
     *
     * TODO: fix secondary keys (or delete if there are none)
     *
     * if(context_l->yy < context_r->yy) 
     *   return -1;
     *
     * return (context_l->yy == context_r->yy) ? 0 : 1;
     */
}

/************************************************************
 * search tree
 */
/** TODO: set additional indexes as parameters */
macFilterTable_context *
macFilterTable_get(const char *name, int len)
{
    macFilterTable_context tmp;

    /** we should have a secondary index */
    netsnmp_assert(cb.container->next != NULL);

    /*
     * TODO: implement compare. Remove this ifdef code and
     * add your own code here.
     */
#ifdef TABLE_CONTAINER_TODO
    snmp_log(LOG_ERR, "macFilterTable_get not implemented!\n");
    return NULL;
#endif

    /*
     * EXAMPLE:
     *
     * if(len > sizeof(tmp.xxName))
     *   return NULL;
     *
     * strncpy( tmp.xxName, name, sizeof(tmp.xxName) );
     * tmp.xxName_len = len;
     *
     * return CONTAINER_FIND(cb.container->next, &tmp);
     */
}
#endif


/************************************************************
 * Initializes the macFilterTable module
 */
void
init_macFilterTable(void)
{
	netsnmp_index index;
   	oid index_oid[MAX_OID_LEN];
   	oid *mac_content;
        mac_content = index_oid;
        char *mac[MACSIZE] = {"00:00:00:00:00:00",\
			      "11:11:11:11:11:11",\
			      "22:22:22:22:22:22",\
			      "33:33:33:33:33:33",\
			      "44:44:44:44:44:44"};
   	int i;
	macFilterTable_context *ctx;
	initialize_table_macFilterTable();
	for(i=0;i<MACSIZE;i++)
		index_oid[i] = i;
	for (i = 0; i< MACSIZE; i++) {
    /*
       First value of an index that is ASN_OCTET_STR is
       the length of the string.
     */

        index.oids = mac_content;
        index.len = 1;
        ctx = NULL;
        /* Search for it first. */
        ctx = CONTAINER_FIND (cb.container, & index);
        if (!ctx) {
          /* No dice. We add the new row */
                ctx = macFilterTable_create_row( & index);
                CONTAINER_INSERT (cb.container, ctx);
                mac_content++;
                ctx->macFilterList_len = strlen(*(mac+i));
                memcpy(ctx->macFilterList,*(mac+i),strlen(*(mac+i)));
        }

   }

}

/************************************************************
 * the *_row_copy routine
 */
static int
macFilterTable_row_copy(macFilterTable_context * dst,
                        macFilterTable_context * src)
{
    if (!dst || !src)
        return 1;

    /*
     * copy index, if provided
     */
    if (dst->index.oids)
        free(dst->index.oids);
    if (snmp_clone_mem((void *) &dst->index.oids, src->index.oids,
                       src->index.len * sizeof(oid))) {
        dst->index.oids = NULL;
        return 1;
    }
    dst->index.len = src->index.len;


    /*
     * copy components into the context structure
     */
    dst->macFilterIndex = src->macFilterIndex;

    memcpy(dst->macFilterList, src->macFilterList, src->macFilterList_len);
    dst->macFilterList_len = src->macFilterList_len;

    return 0;
}

#ifdef macFilterTable_SET_HANDLING

/**
 * the *_extract_index routine
 *
 * This routine is called when a set request is received for an index
 * that was not found in the table container. Here, we parse the oid
 * in the the individual index components and copy those indexes to the
 * context. Then we make sure the indexes for the new row are valid.
 */
int
macFilterTable_extract_index(macFilterTable_context * ctx,
                             netsnmp_index * hdr)
{
    /*
     * temporary local storage for extracting oid index
     *
     * extract index uses varbinds (netsnmp_variable_list) to parse
     * the index OID into the individual components for each index part.
     */
    netsnmp_variable_list var_macFilterIndex;
    int             err;

    /*
     * copy index, if provided
     */
    if (hdr) {
        netsnmp_assert(ctx->index.oids == NULL);
        if (snmp_clone_mem((void *) &ctx->index.oids, hdr->oids,
                           hdr->len * sizeof(oid))) {
            return -1;
        }
        ctx->index.len = hdr->len;
    }

    /*
     * initialize variable that will hold each component of the index.
     * If there are multiple indexes for the table, the variable_lists
     * need to be linked together, in order.
     */
    memset(&var_macFilterIndex, 0x00, sizeof(var_macFilterIndex));
    var_macFilterIndex.type = ASN_INTEGER;      /* type hint for parse_oid_indexes */
       /** TODO: link this index to the next, or NULL for the last one */
#ifdef TABLE_CONTAINER_TODO
    snmp_log(LOG_ERR,
             "macFilterTable_extract_index index list not implemented!\n");
    return 0;
#else
    var_macFilterIndex.next_variable = NULL;
#endif


    /*
     * parse the oid into the individual index components
     */
    err = parse_oid_indexes(hdr->oids, hdr->len, &var_macFilterIndex);
    if (err == SNMP_ERR_NOERROR) {
        /*
         * copy index components into the context structure
         */
        ctx->macFilterIndex = *var_macFilterIndex.val.integer;


        /*
         * TODO: check index for valid values. For EXAMPLE:
         *
         * if ( *var_macFilterIndex.val.integer != XXX ) {
         *    err = -1;
         * }
         */
    }

    /*
     * parsing may have allocated memory. free it.
     */
    snmp_reset_var_buffers(&var_macFilterIndex);

    return err;
}

/************************************************************
 * the *_can_delete routine is called to determine if a row
 * can be deleted.
 *
 * return 1 if the row can be deleted
 * return 0 if the row cannot be deleted
 */
int
macFilterTable_can_delete(macFilterTable_context * undo_ctx,
                          macFilterTable_context * row_ctx,
                          netsnmp_request_group * rg)
{

    /*
     * TODO: check for other deletion requirements here
     */
    return 1;
}

#ifdef macFilterTable_ROW_CREATION
/************************************************************
 * the *_create_row routine is called by the table handler
 * to create a new row for a given index. If you need more
 * information (such as column values) to make a decision
 * on creating rows, you must create an initial row here
 * (to hold the column values), and you can examine the
 * situation in more detail in the *_set_reserve1 or later
 * states of set processing. Simple check for a NULL undo_ctx
 * in those states and do detailed creation checking there.
 *
 * returns a newly allocated macFilterTable_context
 *   structure if the specified indexes are not illegal
 * returns NULL for errors or illegal index values.
 */
macFilterTable_context *
macFilterTable_create_row(netsnmp_index * hdr)
{
    macFilterTable_context *ctx =
        SNMP_MALLOC_TYPEDEF(macFilterTable_context);
    if (!ctx)
        return NULL;

    /*
     * TODO: check indexes, if necessary.
     */
    if (macFilterTable_extract_index(ctx, hdr)) {
        free(ctx->index.oids);
        free(ctx);
        return NULL;
    }

    /*
     * netsnmp_mutex_init(ctx->lock);
     * netsnmp_mutex_lock(ctx->lock); 
     */

    /*
     * TODO: initialize any default values here. This is also
     * first place you really should allocate any memory for
     * yourself to use.  If you allocated memory earlier,
     * make sure you free it for earlier error cases!
     */
    /**
    */

    return ctx;
}
#endif

/************************************************************
 * the *_duplicate row routine
 */
macFilterTable_context *
macFilterTable_duplicate_row(macFilterTable_context * row_ctx)
{
    macFilterTable_context *dup;

    if (!row_ctx)
        return NULL;

    dup = SNMP_MALLOC_TYPEDEF(macFilterTable_context);
    if (!dup)
        return NULL;

    if (macFilterTable_row_copy(dup, row_ctx)) {
        free(dup);
        dup = NULL;
    }

    return dup;
}

/************************************************************
 * the *_delete_row method is called to delete a row.
 */
netsnmp_index  *
macFilterTable_delete_row(macFilterTable_context * ctx)
{
    /*
     * netsnmp_mutex_destroy(ctx->lock); 
     */

    if (ctx->index.oids)
        free(ctx->index.oids);

    /*
     * TODO: release any memory you allocated here...
     */

    /*
     * release header
     */
    free(ctx);

    return NULL;
}


/************************************************************
 * RESERVE is used to check the syntax of all the variables
 * provided, that the values being set are sensible and consistent,
 * and to allocate any resources required for performing the SET.
 * After this stage, the expectation is that the set ought to
 * succeed, though this is not guaranteed. (In fact, with the UCD
 * agent, this is done in two passes - RESERVE1, and
 * RESERVE2, to allow for dependancies between variables).
 *
 * BEFORE calling this routine, the agent will call duplicate_row
 * to create a copy of the row (unless this is a new row; i.e.
 * row_created == 1).
 *
 * next state -> SET_RESERVE2 || SET_FREE
 */
void
macFilterTable_set_reserve1(netsnmp_request_group * rg)
{
    macFilterTable_context *row_ctx =
        (macFilterTable_context *) rg->existing_row;
    macFilterTable_context *undo_ctx =
        (macFilterTable_context *) rg->undo_info;
    netsnmp_variable_list *var;
    netsnmp_request_group_item *current;
    int             rc;


    /*
     * TODO: loop through columns, check syntax and lengths. For
     * columns which have no dependencies, you could also move
     * the value/range checking here to attempt to catch error
     * cases as early as possible.
     */
    for (current = rg->list; current; current = current->next) {

        var = current->ri->requestvb;
        rc = SNMP_ERR_NOERROR;

        switch (current->tri->colnum) {

        default:/** We shouldn't get here */
            rc = SNMP_ERR_GENERR;
            snmp_log(LOG_ERR, "unknown column in "
                     "macFilterTable_set_reserve1\n");
        }

        if (rc)
            netsnmp_set_mode_request_error(MODE_SET_BEGIN, current->ri,
                                           rc);
        rg->status = SNMP_MAX(rg->status, current->ri->status);
    }

    /*
     * done with all the columns. Could check row related
     * requirements here.
     */
}

void
macFilterTable_set_reserve2(netsnmp_request_group * rg)
{
    macFilterTable_context *row_ctx =
        (macFilterTable_context *) rg->existing_row;
    macFilterTable_context *undo_ctx =
        (macFilterTable_context *) rg->undo_info;
    netsnmp_request_group_item *current;
    netsnmp_variable_list *var;
    int             rc;

    rg->rg_void = rg->list->ri;

    /*
     * TODO: loop through columns, check for valid
     * values and any range constraints.
     */
    for (current = rg->list; current; current = current->next) {

        var = current->ri->requestvb;
        rc = SNMP_ERR_NOERROR;

        switch (current->tri->colnum) {

        default:/** We shouldn't get here */
            netsnmp_assert(0); /** why wasn't this caught in reserve1? */
        }

        if (rc)
            netsnmp_set_mode_request_error(MODE_SET_BEGIN, current->ri,
                                           rc);
    }

    /*
     * done with all the columns. Could check row related
     * requirements here.
     */
}

/************************************************************
 * Assuming that the RESERVE phases were successful, the next
 * stage is indicated by the action value ACTION. This is used
 * to actually implement the set operation. However, this must
 * either be done into temporary (persistent) storage, or the
 * previous value stored similarly, in case any of the subsequent
 * ACTION calls fail.
 *
 * In your case, changes should be made to row_ctx. A copy of
 * the original row is in undo_ctx.
 */
void
macFilterTable_set_action(netsnmp_request_group * rg)
{
    netsnmp_variable_list *var;
    macFilterTable_context *row_ctx =
        (macFilterTable_context *) rg->existing_row;
    macFilterTable_context *undo_ctx =
        (macFilterTable_context *) rg->undo_info;
    netsnmp_request_group_item *current;


    /*
     * TODO: loop through columns, copy varbind values
     * to context structure for the row.
     */
    for (current = rg->list; current; current = current->next) {

        var = current->ri->requestvb;

        switch (current->tri->colnum) {

        default:/** We shouldn't get here */
            netsnmp_assert(0); /** why wasn't this caught in reserve1? */
        }
    }

    /*
     * done with all the columns. Could check row related
     * requirements here.
     */
    /*
     * TODO: if you have dependencies on other tables, this would be
     * a good place to check those, too.
     */
}

/************************************************************
 * Only once the ACTION phase has completed successfully, can
 * the final COMMIT phase be run. This is used to complete any
 * writes that were done into temporary storage, and then release
 * any allocated resources. Note that all the code in this phase
 * should be "safe" code that cannot possibly fail (cue
 * hysterical laughter). The whole intent of the ACTION/COMMIT
 * division is that all of the fallible code should be done in
 * the ACTION phase, so that it can be backed out if necessary.
 *
 * BEFORE calling this routine, the agent will update the
 * container (inserting a row if row_created == 1, or removing
 * the row if row_deleted == 1).
 *
 * AFTER calling this routine, the agent will delete the
 * undo_info.
 */
void
macFilterTable_set_commit(netsnmp_request_group * rg)
{
    netsnmp_variable_list *var;
    macFilterTable_context *row_ctx =
        (macFilterTable_context *) rg->existing_row;
    macFilterTable_context *undo_ctx =
        (macFilterTable_context *) rg->undo_info;
    netsnmp_request_group_item *current;

    /*
     * loop through columns
     */
    for (current = rg->list; current; current = current->next) {

        var = current->ri->requestvb;

        switch (current->tri->colnum) {

        default:/** We shouldn't get here */
            netsnmp_assert(0); /** why wasn't this caught in reserve1? */
        }
    }

    /*
     * done with all the columns. Could check row related
     * requirements here.
     */
}

/************************************************************
 * If either of the RESERVE calls fail, the write routines
 * are called again with the FREE action, to release any resources
 * that have been allocated. The agent will then return a failure
 * response to the requesting application.
 *
 * AFTER calling this routine, the agent will delete undo_info.
 */
void
macFilterTable_set_free(netsnmp_request_group * rg)
{
    netsnmp_variable_list *var;
    macFilterTable_context *row_ctx =
        (macFilterTable_context *) rg->existing_row;
    macFilterTable_context *undo_ctx =
        (macFilterTable_context *) rg->undo_info;
    netsnmp_request_group_item *current;

    /*
     * loop through columns
     */
    for (current = rg->list; current; current = current->next) {

        var = current->ri->requestvb;

        switch (current->tri->colnum) {

        default:/** We shouldn't get here */
            /** should have been logged in reserve1 */
        ;}
    }

    /*
     * done with all the columns. Could check row related
     * requirements here.
     */
}

/************************************************************
 * If the ACTION phase does fail (for example due to an apparently
 * valid, but unacceptable value, or an unforeseen problem), then
 * the list of write routines are called again, with the UNDO
 * action. This requires the routine to reset the value that was
 * changed to its previous value (assuming it was actually changed),
 * and then to release any resources that had been allocated. As
 * with the FREE phase, the agent will then return an indication
 * of the error to the requesting application.
 *
 * BEFORE calling this routine, the agent will update the container
 * (remove any newly inserted row, re-insert any removed row).
 *
 * AFTER calling this routing, the agent will call row_copy
 * to restore the data in existing_row from the date in undo_info.
 * Then undo_info will be deleted (or existing row, if row_created
 * == 1).
 */
void
macFilterTable_set_undo(netsnmp_request_group * rg)
{
    netsnmp_variable_list *var;
    macFilterTable_context *row_ctx =
        (macFilterTable_context *) rg->existing_row;
    macFilterTable_context *undo_ctx =
        (macFilterTable_context *) rg->undo_info;
    netsnmp_request_group_item *current;

    /*
     * loop through columns
     */
    for (current = rg->list; current; current = current->next) {

        var = current->ri->requestvb;

        switch (current->tri->colnum) {

        default:/** We shouldn't get here */
            netsnmp_assert(0); /** why wasn't this caught in reserve1? */
        }
    }

    /*
     * done with all the columns. Could check row related
     * requirements here.
     */
}

#endif /** macFilterTable_SET_HANDLING */


/************************************************************
 *
 * Initialize the macFilterTable table by defining its contents and how it's structured
 */
void
initialize_table_macFilterTable(void)
{
    netsnmp_table_registration_info *table_info;

    if (my_handler) {
        snmp_log(LOG_ERR,
                 "initialize_table_macFilterTable_handler called again\n");
        return;
    }

    memset(&cb, 0x00, sizeof(cb));

    /** create the table structure itself */
    table_info = SNMP_MALLOC_TYPEDEF(netsnmp_table_registration_info);

    /*
     * if your table is read only, it's easiest to change the
     * HANDLER_CAN_RWRITE definition below to HANDLER_CAN_RONLY 
     */
    my_handler = netsnmp_create_handler_registration("macFilterTable",
                                                     netsnmp_table_array_helper_handler,
                                                     macFilterTable_oid,
                                                     macFilterTable_oid_len,
                                                     HANDLER_CAN_RWRITE);

    if (!my_handler || !table_info) {
        snmp_log(LOG_ERR, "malloc failed in "
                 "initialize_table_macFilterTable_handler\n");
        return; /** mallocs failed */
    }

    /***************************************************
     * Setting up the table's definition
     */
    /*
     * TODO: add any external indexes here.
     */

    /*
     * internal indexes
     */
        /** index: macFilterIndex */
    netsnmp_table_helper_add_index(table_info, ASN_INTEGER);

    table_info->min_column = macFilterTable_COL_MIN;
    table_info->max_column = macFilterTable_COL_MAX;

    /***************************************************
     * registering the table with the master agent
     */
    cb.get_value = macFilterTable_get_value;
    cb.container = netsnmp_container_find("macFilterTable_primary:"
                                          "macFilterTable:"
                                          "table_container");
#ifdef macFilterTable_IDX2
    netsnmp_container_add_index(cb.container,
                                netsnmp_container_find
                                ("macFilterTable_secondary:"
                                 "macFilterTable:" "table_container"));
    cb.container->next->compare = macFilterTable_cmp;
#endif
#ifdef macFilterTable_SET_HANDLING
    cb.can_set = 1;
#ifdef macFilterTable_ROW_CREATION
    cb.create_row = (UserRowMethod *) macFilterTable_create_row;
#endif
    cb.duplicate_row = (UserRowMethod *) macFilterTable_duplicate_row;
    cb.delete_row = (UserRowMethod *) macFilterTable_delete_row;
    cb.row_copy = (Netsnmp_User_Row_Operation *) macFilterTable_row_copy;

    cb.can_delete = (Netsnmp_User_Row_Action *) macFilterTable_can_delete;

    cb.set_reserve1 = macFilterTable_set_reserve1;
    cb.set_reserve2 = macFilterTable_set_reserve2;
    cb.set_action = macFilterTable_set_action;
    cb.set_commit = macFilterTable_set_commit;
    cb.set_free = macFilterTable_set_free;
    cb.set_undo = macFilterTable_set_undo;
#endif
    DEBUGMSGTL(("initialize_table_macFilterTable",
                "Registering table macFilterTable " "as a table array\n"));
    netsnmp_table_container_register(my_handler, table_info, &cb,
                                     cb.container, 1);
}

/************************************************************
 * macFilterTable_get_value
 *
 * This routine is called for get requests to copy the data
 * from the context to the varbind for the request. If the
 * context has been properly maintained, you don't need to
 * change in code in this fuction.
 */
int
macFilterTable_get_value(netsnmp_request_info *request,
                         netsnmp_index * item,
                         netsnmp_table_request_info *table_info)
{
    netsnmp_variable_list *var = request->requestvb;
    macFilterTable_context *context = (macFilterTable_context *) item;

    switch (table_info->colnum) {

    case COLUMN_MACFILTERINDEX:
            /** INTEGER = ASN_INTEGER */
        snmp_set_var_typed_value(var, ASN_INTEGER,
                                 (char *) &context->macFilterIndex,
                                 sizeof(context->macFilterIndex));
        break;

    case COLUMN_MACFILTERLIST:
            /** OCTETSTR = ASN_OCTET_STR */
        snmp_set_var_typed_value(var, ASN_OCTET_STR,
                                 (char *) &context->macFilterList,
                                 context->macFilterList_len);
        break;

    default:/** We shouldn't get here */
        snmp_log(LOG_ERR, "unknown column in "
                 "macFilterTable_get_value\n");
        return SNMP_ERR_GENERR;
    }
    return SNMP_ERR_NOERROR;
}

/************************************************************
 * macFilterTable_get_by_idx
 */
const macFilterTable_context *
macFilterTable_get_by_idx(netsnmp_index * hdr)
{
    return (const macFilterTable_context *)
        CONTAINER_FIND(cb.container, hdr);
}