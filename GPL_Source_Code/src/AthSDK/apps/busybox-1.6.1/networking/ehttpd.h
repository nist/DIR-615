#ifndef __EHTTPD__
#define __EHTTPD__
#include <stdio.h>

extern int call_cmd(const char *cmd);
extern int allowed_page(const char *url, const char *fromfunc);
extern int auth_session_timeout(const char *rmt_ip_str);
extern int auth_session_exist(const char *rmt_ip_str);
extern int str_replace(char *str, const char *dst, const char *tok, size_t slen);

#define INDEX_PAGE	"redirect2login.html"
#define SESSION_TIMEOUT	60
#endif
