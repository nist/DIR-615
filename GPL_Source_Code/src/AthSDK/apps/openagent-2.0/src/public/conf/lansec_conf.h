#ifndef LANSEC_CONF_H_
#define LANSEC_CONF_H_

#define LANSEC_SUCCESS 0
#define LANSEC_FAIL -1

#define LANSEC_PATH_LEN 256
#define CONF_PWD_LEN 64

#define LANSEC_CONF_PWD "lansecpwd"

char lansec_conf_path[LANSEC_PATH_LEN];
#define LANSEC_CONF_PATH "/var/etc/openagent_lansec.conf"
/************************************************************************
*
*	structure define
*
************************************************************************/
typedef struct {
    unsigned char conf_pwd[CONF_PWD_LEN];
}lansec_conf;

/***********************************************************************
*
*	function declare
*
***********************************************************************/
int get_lansec_conf(lansec_conf *pconf);
int set_lansec_conf(lansec_conf *pconf);
int init_lansec_conf();

#endif
