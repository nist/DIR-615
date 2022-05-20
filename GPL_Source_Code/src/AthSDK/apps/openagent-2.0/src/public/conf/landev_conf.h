#ifndef LANDEV_CONF_H_
#define LANDEV_CONF_H_

#define LANDEV_SUCCESS 0
#define LANDEV_FAIL -1

#define LANDEV_PATH_LEN 256
//#define CONF_PWD_LEN 64

//#define LANSEC_CONF_PWD "lansecpwd"

char landev_conf_path[LANDEV_PATH_LEN];
#define LANDEV_CONF_PATH "/var/etc/openagent_landev.conf"
/************************************************************************
*
*	structure define
*
************************************************************************/
typedef struct {
//    unsigned char conf_pwd[CONF_PWD_LEN];
}landev_conf;

/***********************************************************************
*
*	function declare
*
***********************************************************************/
int get_landev_conf(landev_conf *pconf);
int set_landev_conf(landev_conf *pconf);
int init_landev_conf();

#endif
