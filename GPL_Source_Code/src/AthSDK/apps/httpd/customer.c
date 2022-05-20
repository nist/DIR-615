#ifndef __CUSTOMER__
#define __CUSTOMER__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern http_main(int, char *);

typedef struct mapping_s{
	char *nvram_mapping_name;
}mapping_t;
mapping_t customer_ui_to_nvram[]= {
	{"customer_variable_00"}	
};
int customer_variable_num = sizeof(customer_ui_to_nvram)/sizeof(customer_ui_to_nvram[0]);

int main(int argc, char *argv)
{
	
    httpd_main(NULL, NULL);
	
}


#endif//__CUSTOMER__