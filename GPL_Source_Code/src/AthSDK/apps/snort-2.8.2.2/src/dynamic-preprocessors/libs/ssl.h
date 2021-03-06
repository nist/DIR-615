/*
 * Copyright (C) 1998-2006 Sourcefire, Inc.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License Version 2 as
 * published by the Free Software Foundation.  You may not use, modify or
 * distribute this program under any other version of the GNU General
 * Public License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 * 
*/

/*
 * Adam Keeton
 * ssl.h
 * 10/09/07
*/

#ifndef SSL_H
#define SSL_H

#include <ctype.h>
#include <stdlib.h>

#define SSL_NO_FLAG             0x00000000

/* SSL record type flags */
#define SSL_CHANGE_CIPHER_FLAG  0x00000001
#define SSL_ALERT_FLAG          0x00000002
#define SSL_POSSIBLE_HS_FLAG    0x00000004 /* For handshakes in TLSv3 that are encrypted */
#define SSL_CLIENT_HELLO_FLAG   0x00000008
#define SSL_SERVER_HELLO_FLAG   0x00000010
#define SSL_CERTIFICATE_FLAG    0x00000020
#define SSL_SERVER_KEYX_FLAG    0x00000040
#define SSL_CLIENT_KEYX_FLAG    0x00000080
#define SSL_CIPHER_SPEC_FLAG    0x00000100
#define SSL_SFINISHED_FLAG      0x00000200
#define SSL_SAPP_FLAG           0x00000400
#define SSL_CAPP_FLAG           0x00000800
#define SSL_HS_SDONE_FLAG       0x00001000

/* Misc state flag */
#define SSL_POSSIBLY_ENC_FLAG   0x00002000

/* Version flags */
#define SSL_VER_SSLV2_FLAG      0x00004000
#define SSL_VER_SSLV3_FLAG      0x00008000
#define SSL_VER_TLS10_FLAG      0x00010000
#define SSL_VER_TLS11_FLAG      0x00020000
#define SSL_VER_TLS12_FLAG      0x00040000

#define SSL_VERFLAGS (SSL_VER_SSLV2_FLAG | SSL_VER_SSLV3_FLAG | \
                     SSL_VER_TLS10_FLAG | SSL_VER_TLS11_FLAG | \
                     SSL_VER_TLS12_FLAG)

/* For rule state matching. These are only set when presently valid,
 * and do not stay set across packets. */
#define SSL_CUR_CLIENT_HELLO_FLAG   0x00080000
#define SSL_CUR_SERVER_HELLO_FLAG   0x00100000
#define SSL_CUR_SERVER_KEYX_FLAG    0x00200000
#define SSL_CUR_CLIENT_KEYX_FLAG    0x00400000
#define SSL_ENCRYPTED_FLAG          0x00800000 /* Provided for external use */
#define SSL_UNKNOWN_FLAG            0x01000000 /* Set when we decoded mostly garbage */

#define SSL_STATEFLAGS (SSL_CUR_CLIENT_HELLO_FLAG | SSL_CUR_SERVER_HELLO_FLAG | \
                        SSL_CUR_SERVER_KEYX_FLAG | SSL_CUR_CLIENT_KEYX_FLAG | \
                        SSL_UNKNOWN_FLAG)

/* Error flags */
#define SSL_BOGUS_HS_DIR_FLAG   0x08000000 /* Record type disagrees with direction */
#define SSL_TRAILING_GARB_FLAG  0x10000000
#define SSL_BAD_TYPE_FLAG       0x20000000
#define SSL_BAD_VER_FLAG        0x40000000
#define SSL_TRUNCATED_FLAG      0x80000000
#define SSL_ARG_ERROR_FLAG      0x00000000 /* Note: overloaded with SSL_NO_FLAG */

/* The following flags are not presently of interest:
* #define SSL_CERT_URL_FLAG       (RFC 3546) 
* #define SSL_CERT_STATUS_FLAG    (RFC 3546) 
* #define SSL_CFINISHED_FLAG      This is contained in encrypted data
* #define SSL_HS_FINISHED_FLAG    Ignored for our purposes
*/

/* The constants used below are from RFC 2246 */

/* SSLv3 & TLS Record types */
#define SSL_CHANGE_CIPHER_REC 20
#define SSL_ALERT_REC 21
#define SSL_HANDSHAKE_REC 22
#define SSL_APPLICATION_REC 23

/* SSLv3 & TLS handshake types */
#define SSL_HS_HELLO_REQ 0
#define SSL_HS_CHELLO    1
#define SSL_HS_SHELLO    2
#define SSL_HS_CERT      11
#define SSL_HS_SKEYX     12
#define SSL_HS_CERT_REQ  13
#define SSL_HS_SHELLO_DONE 14
#define SSL_HS_CERT_VERIFY 15
#define SSL_HS_CKEYX     16
#define SSL_HS_FINISHED  20
#define SSL_CERT_URL     21
#define SSL_CERT_STATUS  22

/* SSLv2 handshake types */
#define SSL_V2_CHELLO  1
#define SSL_V2_CKEY    2
#define SSL_V2_SHELLO  4

#ifdef WIN32
#pragma pack(push,ssl_hdrs,1)
#else
#pragma pack(1)
#endif

typedef struct _SSL_record 
{
    u_int8_t type;
    u_int8_t major;
    u_int8_t minor;
    u_int16_t length;
} SSL_record_t;

#define SSL_REC_PAYLOAD_OFFSET (sizeof(u_int8_t) * 5)

typedef struct _SSL_handshake 
{
    u_int8_t type;    
    u_int8_t length[3];
} SSL_handshake_t;

typedef struct _SSL_handshake_hello
{
    u_int8_t type;    
    u_int8_t length[3];
    u_int8_t major;
    u_int8_t minor;
} SSL_handshake_hello_t;

typedef struct _SSLv2_record 
{
    u_int16_t length;
    u_int8_t type;
} SSLv2_record_t;

typedef struct _SSLv2_chello
{
    u_int16_t length;
    u_int8_t type;
    u_int8_t minor;
    u_int8_t major;
} SSLv2_chello_t;

typedef struct _SSLv2_shello
{
    u_int16_t length;
    u_int8_t type;
    u_int8_t ssnid;
    u_int8_t certtype;
    u_int8_t minor;
    u_int8_t major;
} SSLv2_shello_t;

#define SSL_V2_MIN_LEN 5

#ifdef WIN32
#pragma pack(pop,ssl_hdrs)
#else
#pragma pack()
#endif

#define SSL_HS_PAYLOAD_OFFSET (sizeof(u_int8_t) * 4) /* Type and length fields */

#define SSL_BAD_HS(x) (x & SSL_BOGUS_HS_DIR_FLAG)
#define SSL_IS_HANDSHAKE(x) (x & (SSL_CLIENT_HELLO_FLAG | SSL_SERVER_HELLO_FLAG\
                                  | SSL_CERTIFICATE_FLAG | SSL_SERVER_KEYX_FLAG\
                                  | SSL_CLIENT_KEYX_FLAG | SSL_CIPHER_SPEC_FLAG))
#define SSL_IS_CHELLO(x) (x & SSL_CLIENT_HELLO_FLAG)
#define SSL_IS_SHELLO(x) (x & SSL_SERVER_HELLO_FLAG)
#define SSL_IS_CKEYX(x) (x & SSL_CLIENT_KEYX_FLAG)
#define SSL_IS_APP(x) ((x & SSL_SAPP_FLAG) || (x & SSL_CAPP_FLAG))
#define SSL_IS_ALERT(x) (x & SSL_ALERT_FLAG)
#define SSL_CLEAR_TEMPORARY_FLAGS(x) x &= ~SSL_STATEFLAGS;
/* Verifies that the error flags haven't been triggered */
#define SSL_IS_CLEAN(x) !(x & (SSL_BOGUS_HS_DIR_FLAG | SSL_TRUNCATED_FLAG | \
                               SSL_BAD_VER_FLAG | SSL_BAD_TYPE_FLAG | \
                               SSL_TRAILING_GARB_FLAG | SSL_UNKNOWN_FLAG))

u_int32_t SSL_decode(const u_int8_t *pkt, u_int32_t size, u_int32_t pktflags);

#endif
