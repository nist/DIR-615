/*
 * Note: this file originally auto-generated by mib2c using
 *       version : 1.17 $ of : mfd-data-access.m2c,v $ 
 *
 * $Id: ifXTable_data_access.c,v 1.1.1.1 2007/08/30 10:28:10 roy Exp $
 */
/*
 * standard Net-SNMP includes 
 */
#include <net-snmp/net-snmp-config.h>
#include <net-snmp/net-snmp-includes.h>
#include <net-snmp/agent/net-snmp-agent-includes.h>

/*
 * include our parent header 
 */
#include "ifXTable.h"


#include "ifXTable_data_access.h"

/** @ingroup interface 
 * @addtogroup data_access data_access: Routines to access data
 *
 * These routines are used to locate the data used to satisfy
 * requests.
 * 
 * @{
 */
/**********************************************************************
 **********************************************************************
 ***
 *** Table ifXTable
 ***
 **********************************************************************
 **********************************************************************/
/*
 * IF-MIB::ifXTable is subid 1 of ifMIBObjects.
 * Its status is Current.
 * OID: .1.3.6.1.2.1.31.1.1, length: 9
 */

/**
 * initialization for ifXTable data access
 *
 * This function is called during startup to allow you to
 * allocate any resources you need for the data table.
 *
 * @param ifXTable_reg
 *        Pointer to ifXTable_registration
 *
 * @retval MFD_SUCCESS : success.
 * @retval MFD_ERROR   : unrecoverable error.
 */
int
ifXTable_init_data(ifXTable_registration * ifXTable_reg)
{
    DEBUGMSGTL(("verbose:ifXTable:ifXTable_init_data", "called\n"));

    /*
     * TODO:303:o: Initialize ifXTable data.
     */

    return MFD_SUCCESS;
}                               /* ifXTable_init_data */

/**
 * container overview
 *
 * N/A; we use the ifTable container
 */


/**
 * prepare row for processing.
 *
 *  When the agent has located the row for a request, this function is
 *  called to prepare the row for processing. If you fully populated
 *  the data context during the index setup phase, you may not need to
 *  do anything.
 *
 * @param rowreq_ctx pointer to a context.
 *
 * @retval MFD_SUCCESS     : success.
 * @retval MFD_ERROR       : other error.
 */
int
ifXTable_row_prep(ifXTable_rowreq_ctx * rowreq_ctx)
{
    DEBUGMSGTL(("verbose:ifXTable:ifXTable_row_prep", "called\n"));

    netsnmp_assert(NULL != rowreq_ctx);

    /*
     * TODO:390:o: Prepare row for request.
     * If populating row data was delayed, this is the place to
     * fill in the row for this request.
     */

    return MFD_SUCCESS;
}                               /* ifXTable_row_prep */

/** @} */
