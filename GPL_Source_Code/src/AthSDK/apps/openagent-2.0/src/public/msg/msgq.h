#define MAX_READ_SIZE 256
#define MAX_SEND_SIZE 256

#define SUCCESS 0
#define FAIL -1
/**********************************************************************
*
*	function prototype
*
***********************************************************************/
int creat_msgq(char *str_msg);
int send_msg(int mqid, long type, char *text);
int read_msg(int mqid, long type, char *test);
