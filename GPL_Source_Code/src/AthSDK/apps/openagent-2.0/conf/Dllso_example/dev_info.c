/*
 * Copyright(c) 2006-2007, Works Systems, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer. 
 * 2. Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution. 
 * 3. Neither the name of the vendors nor the names of its contributors 
 *    may be used to endorse or promote products derived from this software 
 *    without specific prior written permission. 
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


/******************************************************************************
 * $Author: norp_huang $
 * $Date: 2009/05/25 09:16:48 $
 *****************************************************************************/
#include <time.h>
#include "xml.h"

//deviceinfo
int dev_Manufacturer(int opt_flag, void *mthdval_struct, int locate[])
{
    //int res;
//    char manufc[65] = "Works Systems";
    

    if (!opt_flag) // get function
    {
    	//Call native function to get Manufacturer -- TO DO
	//res = sysGetProductName(manufc, 65);
//	strcpy((char *)mthdval_struct, manufc);
	strcpy((char *)mthdval_struct, DEV_INFO_MANUFACTURER);

        printf("The Manufacturer is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("Manufacturer is unwritable.\n");
        return -1;
    }
}
int dev_ManufacturerOUI(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get ManufacturerOUI -- TO DO
		//strcpy((char *)mthdval_struct, "09D020");
		strcpy((char *)mthdval_struct, DEV_INFO_MANU_OUI);
        printf("The ManufacturerOUI is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("ManufacturerOUI is unwritable.\n");
        return -1;
    }
}
int dev_ModelName(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get ModelName -- TO DO
		//strcpy((char *)mthdval_struct, "3200");
		strcpy((char *)mthdval_struct, DEV_INFO_MODEL_NAME);
        printf("The ModelName is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("ModelName is unwritable.\n");
        return -1;
    }
}
int dev_Description(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get Description -- TO DO
		//strcpy((char *)mthdval_struct, "1111111111");
		strcpy((char *)mthdval_struct, DEV_INFO_DESCRIPTION);
        printf("The Description is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("Description is unwritable.\n");
        return -1;
    }
}
int dev_ProductClass(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get ProductClass -- TO DO
		//strcpy((char *)mthdval_struct, "AX-112W");
		strcpy((char *)mthdval_struct, DEV_INFO_PRODUCT_CLASS);
        printf("The ProductClass is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("ProductClass is unwritable.\n");
        return -1;
    }
}
int dev_SerialNumber(int opt_flag, void *mthdval_struct, int locate[])
{
/*
#ifdef asus_ax112w
    return 0;
#else
*/
    //int res = 0;
    if (!opt_flag) // get function
    {
    	//Call native function to get SerialNumber -- TO DO

	//strcpy((char *)mthdval_struct, "000000002203");
	strcpy((char *)mthdval_struct, DEV_INFO_SERIAL_NUM);
	/*res = get_mac_address((char *)mthdval_struct);
  	if(res != 0)
	{
	    return -1;
	}*/
        printf("The SerialNumber is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("SerialNumber is unwritable.\n");
        return -1;
    }
//#endif
}
int dev_HardwareVersion(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get HardwareVersion -- TO DO
        //strcpy((char *)mthdval_struct, "66");
        strcpy((char *)mthdval_struct, DEV_INFO_HW_VER);

        printf("The HardwareVersion is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("HardwareVersion is unwritable.\n");
        return -1;
    }
}
int dev_SoftwareVersion(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get SoftwareVersion -- TO DO
		//strcpy((char *)mthdval_struct, "65");
		strcpy((char *)mthdval_struct,DEV_INFO_SW_VER);
        printf("The SoftwareVersion is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("SoftwareVersion is unwritable.\n");
        return -1;
    }
}

int dev_SpecVersion(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get SpecVersion -- TO DO
		//strcpy((char *)mthdval_struct, "1111111111");
		strcpy((char *)mthdval_struct, DEV_INFO_SPEC_VER);
        printf("The SpecVersion is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("SpecVersion is unwritable.\n");
        return -1;
    }
}
int dev_ProvisioningCode(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get ProvisioningCode -- TO DO
        //strcpy((char *)mthdval_struct, "123455");
        strcpy((char *)mthdval_struct, DEV_INFO_PROVISION_CODE);
        printf("The ProvisioningCode is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	//Call native function to set ProvisioningCode -- TO DO
    	printf("Set ProvisioningCode to success.\n"); //should be read only!!!
    }
}
int dev_UpTime(int opt_flag, void *mthdval_struct, int locate[])
{
    //unsigned int UpTime;
	
    if (!opt_flag) // get function
    {
    	//Call native function to get UpTime -- TO DO
    	//UpTime = 11111;
    	//strcpy((char *)mthdval_struct, "2000-00-00T00:00:00");
    	strcpy((char *)mthdval_struct, DEV_INFO_UP_TIME);
    	printf("The UpTime of Device is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("The UpTime of Device is unwritable.\n");
        return -1;
    }
}
int dev_DeviceLog(int opt_flag, void *mthdval_struct, int locate[])
{
    if (!opt_flag) // get function
    {
    	//Call native function to get DeviceLog -- TO DO
		//strcpy((char *)mthdval_struct, "1111111111");
		strcpy((char *)mthdval_struct, DEV_INFO_DEV_LOG);
        printf("The DeviceLog is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("DeviceLog is unwritable.\n");
        return -1;
    }
}
int dev_Vendor_CFile_Num(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    unsigned int Vendor_CFile_Num;
	
    if (!opt_flag) // get function
    {
    	//Call native function to get Vendor_CFile_Num -- TO DO
    	//Vendor_CFile_Num = 10;
    	Vendor_CFile_Num = DEV_INFO_VENDOR_CFILE_NUM;
    	*((unsigned int *)mthdval_struct) = Vendor_CFile_Num;
    	printf("The Vendor_CFile_Num of Device is %d.\n", Vendor_CFile_Num);
        return 0;
    }
    else           // set function
    {
    	printf("The Vendor_CFile_Num of Device is unwritable.\n");
        return -1;
    }
}
int dev_Modem_Ver(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get Modem_Ver -- TO DO
		//strcpy((char *)mthdval_struct, "1111111111");
		strcpy((char *)mthdval_struct, DEV_INFO_MODEM_VER);
        printf("The Modem_Ver is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("Modem_Ver is unwritable.\n");
        return -1;
    }
}
int dev_Enable_Opt(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get Enable_Opt -- TO DO
		//strcpy((char *)mthdval_struct, "111,222,333");
		strcpy((char *)mthdval_struct, DEV_INFO_ENABLE_OPT);
        printf("The Enable_Opt is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("Enable_Opt is unwritable.\n");
        return -1;
    }
}
int dev_Additional_Hard_Ver(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get Additional_Hard_Ver -- TO DO
		//strcpy((char *)mthdval_struct, "1111111111");
		strcpy((char *)mthdval_struct, DEV_INFO_ADDITIONAL_HW_VER);
        printf("The Additional_Hard_Ver is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("Additional_Hard_Ver is unwritable.\n");
        return -1;
    }
}
int dev_Additional_Soft_Ver(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get Additional_Soft_Ver -- TO DO
		//strcpy((char *)mthdval_struct, "1111111111");
		strcpy((char *)mthdval_struct, DEV_INFO_ADDITIONAL_SW_VER);
        printf("The Additional_Soft_Ver is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("Additional_Soft_Ver is unwritable.\n");
        return -1;
    }
}
int dev_FirstUserDate(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    //time_t FirstUserDate;
	
    if (!opt_flag) // get function
    {
    	//Call native function to get FirstUserDate -- TO DO
    	//FirstUserDate = 999999999;
    	//strcpy((char *)mthdval_struct, "2000-00-00T00:00:00");
    	strcpy((char *)mthdval_struct, DEV_INFO_1ST_USER_DATE);
    	printf("The FirstUserDate of Device is %d.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("The FirstUserDate of Device is unwritable.\n");
        return -1;
    }
}

//vendorconfig
int dev_VendorFile_name(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get VendorFile_name -- TO DO
	    //strcpy((char *)mthdval_struct, "1111111111");
	    strcpy((char *)mthdval_struct, DEV_INFO_VENDOR_FILE_NAME);
        printf("The VendorFile_name is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("VendorFile_name is unwritable.\n");
        return -1;
    }
}

int dev_VendorFile_version(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get VendorFile_version -- TO DO
	    //strcpy((char *)mthdval_struct, "1111111111");
	    strcpy((char *)mthdval_struct, DEV_INFO_VENDOR_FILE_VER);
        printf("The VendorFile_version is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("VendorFile_version is unwritable.\n");
        return -1;
    }
}

int dev_VendorFile_date(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    //time_t VendorFile_date;
	
    if (!opt_flag) // get function
    {
    	//Call native function to get VendorFile_date -- TO DO
    	//VendorFile_date = 999999999;
    	//strcpy((char *)mthdval_struct, "2000-00-00T00:00:00");
    	strcpy((char *)mthdval_struct, DEV_INFO_VENDOR_FILE_DATE);
    	printf("The VendorFile_date of Device is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("The VendorFile_date of Device is unwritable.\n");
        return -1;
    }
}

int dev_VendorFile_description(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
    {
    	//Call native function to get VendorFile_description -- TO DO
	    //strcpy((char *)mthdval_struct, "1111111111");
	    strcpy((char *)mthdval_struct, DEV_INFO_VENDOR_FILE_DESC);
        printf("The VendorFile_description is %s.\n", (char *)mthdval_struct);
        return 0;
    }
    else           // set function
    {
    	printf("VendorFile_description is unwritable.\n");
        return -1;
    }
}
