#ifndef WANDEV_CONF_H_
#define WANDEV_CONF_H_

#define WANDEV_SUCCESS 0
#define WANDEV_FAIL -1

#define WANDEV_PATH_LEN 256
//#define CONF_PWD_LEN 64

//#define LANSEC_CONF_PWD "lansecpwd"

char wandev_conf_path[WANDEV_PATH_LEN];
#define WANDEV_CONF_PATH "/var/etc/openagent_wandev.conf"
/************************************************************************
*
*	structure define
*
************************************************************************/
typedef struct {
//    unsigned char conf_pwd[CONF_PWD_LEN];
}wandev_conf;

/***********************************************************************
*
*	function declare
*
***********************************************************************/
int get_wandev_conf(wandev_conf *pconf);
int set_wandev_conf(wandev_conf *pconf);
int init_wandev_conf();

#endif
