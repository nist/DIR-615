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
#include <sys/msg.h>
#include <string.h>
#include <stdio.h>

#include "msgq.h"
//#include "logger.h"
/*
 ********************************************************************
 * Function name: Creat_msg();
 * Description: Creat message queue.
 * Parameter: char *str_mq
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int creat_msgq(char *str_mq)
{
    key_t mqkey;
    int oflag,mqid;

    //char filenm[] = "shared-file";
//    char filenm[16] = {};
	char id = 0xFF;
    oflag = IPC_CREAT;

//	sprintf(filenm, "%s_mq", str_mq);

//TODO: classfy different mq as string / id
	if (!strcmp(str_mq,"agent_mq") || !strcmp(str_mq, "shared-file"))
	{
		id = 0xFF;
	} else if (!strcmp(str_mq, "lansec_mq")) {
		id = 0xFE;
	} else if (!strcmp(str_mq, "landev_mq")) {
		id = 0xFD;
	} else if (!strcmp(str_mq, "layer3_mq")) { 
		id = 0xFC;
	} else if (!strcmp(str_mq, "wandev_mq")) {
		id = 0xFB;
	}
//    mqkey = ftok(filenm,0xFF);
    mqkey = ftok(str_mq, id);
    mqid = msgget(mqkey, oflag);
    if (mqid == -1){
        //LOG(m_public, ERROR, "msgget failed.\n");
        printf("msgget failed.\n");
        return FAIL;
    }
    return mqid;
}
/*
 ********************************************************************
 * Function name: send_msg();
 * Description: Send message queue.
 * Parameter: int mqid:id of mq; long type: type of send mq; char *text:text
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int send_msg(int mqid, long type, char *text)
{
    int res = 0;

    struct msgbuf {
        long mtype;
        char mtext[MAX_SEND_SIZE];
    }msg;
    msg.mtype = type;
    strcpy(msg.mtext, text);
    res = msgsnd(mqid, &msg, strlen(msg.mtext) + 1, 0);
    if(res == -1) {
        //LOG(m_public, ERROR, "msgsnd failed.\n");
        printf("msgsnd failed.\n");
        return FAIL;
    }
    return SUCCESS;
}
/*
 ********************************************************************
 * Function name: read_msg();
 * Description: Read message queue.
 * Parameter: int mqid:id of mq; long type: type of recv mq; char *text:text
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int read_msg(int mqid, long type, char *text)
{
    int res = 0;
    int flag = 0;
    struct msgbuf {
        long mtype;
        char mtext[MAX_READ_SIZE];
    }msg;    
    memset(msg.mtext, '\0', sizeof(msg.mtext));
//    msg.mtype = type;
    res = msgrcv(mqid, &msg, MAX_READ_SIZE, type, flag); 
    if (res == -1) {
        //LOG(m_public, ERROR, "msgrcv failed.\n");
        printf("msgrcv failed.\n");
		return FAIL;
    }
    strcpy(text, msg.mtext);
    return SUCCESS;
}
