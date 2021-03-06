/*
** Copyright (C) 2007-2008 Sourcefire, Inc.
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License Version 2 as
** published by the Free Software Foundation.  You may not use, modify or
** distribute this program under any other version of the GNU General
** Public License.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

/*
 * Adam Keeton
 * SSLPP Preprocessor
 * 10/10/07
 *
*/

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif  /* HAVE_CONFIG_H */

#include "sf_snort_packet.h"
#include "sf_dynamic_preprocessor.h"
#include "sf_snort_plugin_api.h"
#include "debug.h"

#include "preprocids.h"
#include "spp_ssl.h"

#include <stdio.h>
#include <syslog.h>
#include <string.h>
#ifndef WIN32
#include <strings.h>
#include <sys/time.h>
#endif
#include <stdlib.h>
#include <ctype.h>

#include "profiler.h"

#ifdef PERF_PROFILING
PreprocStats sslpp_perf_stats;
#endif

#define GENERATOR_SPP_SSLPP	133

/* Ultimately calls SnortEventqAdd */
/* Arguments are: gid, sid, rev, classification, priority, message, rule_info */
#define ALERT(x,y) { _dpd.alertAdd(GENERATOR_SPP_SSLPP, x, 1, 0, 3, y, 0 ); }

/* Wraps disabling detect with incrementing the counter */
#define DISABLE_DETECT() { _dpd.disableDetect(packet); counts.disabled++; }

extern DynamicPreprocessorData _dpd;

static SSLPP_config_t config;
static SSLPP_counters_t counts;

static INLINE int SSLPP_is_encrypted(u_int32_t ssl_flags, SFSnortPacket *packet) 
{
    if(SSL_IS_CLEAN(ssl_flags))
    {
        if((ssl_flags & SSLPP_ENCRYPTED_FLAGS) == SSLPP_ENCRYPTED_FLAGS)
        {
            counts.completed_hs++;
            return SSLPP_TRUE;
        }
        /* Check if we're either midstream or if packets were missed after the 
         * connection was established */
        else if( (_dpd.streamAPI->get_session_flags(
                    packet->stream_session_ptr) & SSNFLAG_MIDSTREAM ) ||
                  _dpd.streamAPI->missed_packets(
                    packet->stream_session_ptr, SSN_DIR_BOTH) )
        {
            /* If we're trusting the server, check if it trusts
             * the handshake */
            if( config.flags & SSLPP_TRUSTSERVER_FLAG ) 
            {
                if(ssl_flags & SSL_SAPP_FLAG) 
                    return SSLPP_TRUE;
            }
            else if( (ssl_flags & (SSL_CAPP_FLAG | SSL_SAPP_FLAG)) == 
                     (SSL_CAPP_FLAG | SSL_SAPP_FLAG) )
            {
                return SSLPP_TRUE;
            }
        }
    }
    /* Bad flags were set.  If we're trusting the server, check if it trusts
     * the handshake */
    else if( config.flags & SSLPP_TRUSTSERVER_FLAG )
    {
        if(ssl_flags & SSL_SAPP_FLAG) 
            return SSLPP_TRUE;
    }

    return SSLPP_FALSE;
}

static INLINE u_int32_t SSLPP_process_alert(
        u_int32_t ssn_flags, u_int32_t new_flags, SFSnortPacket *packet)
{
    counts.alerts++;

    ssn_flags |= new_flags;

    /* Check if we've seen a handshake, that this isn't it,
     * that the cipher flags is not set, and that we are disabling detection */
    if(SSL_IS_HANDSHAKE(ssn_flags) && 
       !SSL_IS_HANDSHAKE(new_flags) &&
        !(new_flags & SSL_CHANGE_CIPHER_FLAG) &&
         (config.flags & SSLPP_DISABLE_FLAG))
    {
        DISABLE_DETECT();
    }

    /* Need to negate the application flags from the opposing side. */

    if(packet->flags & FLAG_FROM_CLIENT)
        return ssn_flags & ~SSL_SAPP_FLAG;

    else if(packet->flags & FLAG_FROM_SERVER)
        return ssn_flags & ~SSL_CAPP_FLAG;

    return ssn_flags;
}

static INLINE u_int32_t SSLPP_process_hs(u_int32_t ssl_flags, u_int32_t new_flags)
{
    counts.handshakes++;

    if(!SSL_BAD_HS(new_flags))
        ssl_flags |= new_flags & (SSL_CLIENT_HELLO_FLAG | 
                                 SSL_SERVER_HELLO_FLAG |
                                 SSL_CLIENT_KEYX_FLAG |
                                 SSL_SFINISHED_FLAG);
    else
        counts.bad_handshakes++;

    return ssl_flags;
}

static INLINE u_int32_t SSLPP_process_app(
        u_int32_t ssn_flags, u_int32_t new_flags, SFSnortPacket *packet) 
{
    if(!(config.flags & SSLPP_DISABLE_FLAG))
        return ssn_flags | new_flags;

    if(SSLPP_is_encrypted(ssn_flags | new_flags, packet) ) 
    {
        ssn_flags |= SSL_ENCRYPTED_FLAG;

        _dpd.streamAPI->stop_inspection(packet->stream_session_ptr,
                           packet, SSN_DIR_BOTH, -1, 0);

        counts.stopped++;
    }
    else if(SSL_IS_HANDSHAKE(ssn_flags) && (new_flags & SSL_CHANGE_CIPHER_FLAG))
    {
        DISABLE_DETECT();
    }

    return ssn_flags | new_flags;
}

static INLINE void SSLPP_process_other(
        u_int32_t ssn_flags, u_int32_t new_flags, SFSnortPacket *packet) 
{
    if(new_flags & SSL_CHANGE_CIPHER_FLAG) 
    {
        counts.cipher_change++;
    }
    /* Encrypted SSLv2 will appear unrecognizable.  Check if the handshake was
     * seen and stop inspecting if so. */
    else if((ssn_flags & SSL_VER_SSLV2_FLAG) && 
            /* Check for an existing handshake from both sides */
             SSL_IS_CHELLO(ssn_flags) && SSL_IS_SHELLO(ssn_flags) &&
            (config.flags & SSLPP_DISABLE_FLAG))
    {
        ssn_flags |= SSL_ENCRYPTED_FLAG | new_flags;

        _dpd.streamAPI->stop_inspection(packet->stream_session_ptr,
                           packet, SSN_DIR_BOTH, -1, 0);
    }
    else
    {
        counts.unrecognized++;

        /* Special handling for SSLv2 */
        if(new_flags & SSL_VER_SSLV2_FLAG) 
            ssn_flags |= new_flags;

        if(new_flags & SSL_UNKNOWN_FLAG)
            ssn_flags |= new_flags;

/* The following block is intentionally disabled. */
/* If we were unable to decode the packet, and previous packets had been 
 * missed,  we will not assume it is encrypted SSLv2. */
#if 0
        /* More special handling for SSLv2.
         * If both server-side and client-side data was missed, and it has not
         * been identified it as TLS, it is possibly encrypted SSLv2. */
        if( !(ssn_flags & ( SSL_VER_SSLV3_FLAG | SSL_VER_TLS10_FLAG |
                            SSL_VER_TLS11_FLAG | SSL_VER_TLS12_FLAG)) )
        {
            if(packet->stream_session_ptr && 
                _dpd.streamAPI->missed_packets(
                    packet->stream_session_ptr, SSN_DIR_SERVER) && 
                _dpd.streamAPI->missed_packets( 
                    packet->stream_session_ptr, SSN_DIR_CLIENT) )

                ssn_flags |= SSL_VER_SSLV2_FLAG;
        }
#endif
    }

     /* Still need to set application data here because some of the ssn_flags
     * flags were cleared in SSL_CLEAR_TEMPORARY_FLAGS */
    _dpd.streamAPI->set_application_data(
            packet->stream_session_ptr, PP_SSL,
            (void*)(uintptr_t)ssn_flags, NULL);
}

/* SSL Preprocessor process callback. */
static void SSLPP_process(void *raw_packet, void *context)
{
    SFSnortPacket *packet;
    u_int32_t ssn_flags;
    u_int32_t new_flags;
    PROFILE_VARS;
    
    PREPROC_PROFILE_START(sslpp_perf_stats);

    packet = (SFSnortPacket*)raw_packet;

    if(!packet || !packet->payload || !packet->payload_size || 
       !packet->tcp_header || !packet->stream_session_ptr)
    {
        PREPROC_PROFILE_END(sslpp_perf_stats);
        return;
    }
   
    /* Make sure the packet is on the right port */
    if(!config.ports[ PORT_INDEX(packet->src_port) ] &&
       !config.ports[ PORT_INDEX(packet->dst_port) ])
    {
        PREPROC_PROFILE_END(sslpp_perf_stats);
        return;
    }

    ssn_flags = (u_int32_t)(uintptr_t)_dpd.streamAPI->get_application_data(
                packet->stream_session_ptr, PP_SSL);

    SSL_CLEAR_TEMPORARY_FLAGS(ssn_flags);

    new_flags = SSL_decode(packet->payload, packet->payload_size, packet->flags);

    counts.decoded++;

    /* Note, there can be multiple record types in each SSL packet.
     * Processing them in this order is intentional.  If there is an
     * Alert, we don't care about the other records */

    if(SSL_IS_ALERT(new_flags))
    {
        ssn_flags =
            SSLPP_process_alert(ssn_flags, new_flags, packet);
    }

    else if(SSL_IS_HANDSHAKE(new_flags))
    {
        ssn_flags = SSLPP_process_hs(ssn_flags, new_flags);
    }
    
    else if(SSL_IS_APP(new_flags))
    {
        ssn_flags = SSLPP_process_app(ssn_flags, new_flags, packet);
    }
    /* Different record type that we don't care about.
     * Either it's a 'change cipher spec' or we failed to recognize the
     * record type.  Do not update session data */
    else 
    {
        SSLPP_process_other(ssn_flags, new_flags, packet);
        
        /* Application data is updated inside of SSLPP_process_other */

        PREPROC_PROFILE_END(sslpp_perf_stats);
        return;
    }

    ssn_flags |= new_flags;

    _dpd.streamAPI->set_application_data(
                packet->stream_session_ptr, PP_SSL,
                (void*)(uintptr_t)ssn_flags, NULL);

    PREPROC_PROFILE_END(sslpp_perf_stats);
}

/* Parsing for the ssl_state rule option */
static int SSLPP_state_init(char *name, char *params, void **data) 
{
    unsigned long flags = 0;
    char *end;
    char *tok;

    tok = strtok_r(params, ",", &end);

    if(!tok)
        DynamicPreprocessorFatalMessage("%s(%d) => missing argument to"
            "ssl_state keyword\n", *(_dpd.config_file), *(_dpd.config_line));

    do {
        if(!strcasecmp("client_hello", tok))
            flags |= SSL_CUR_CLIENT_HELLO_FLAG;
        else if(!strcasecmp("server_hello", tok))
            flags |= SSL_CUR_SERVER_HELLO_FLAG;
        else if(!strcasecmp("client_keyx", tok))
            flags |= SSL_CUR_CLIENT_KEYX_FLAG;
        else if(!strcasecmp("server_keyx", tok))
            flags |= SSL_CUR_SERVER_KEYX_FLAG;
        else if(!strcasecmp("unknown", tok))
            flags |= SSL_UNKNOWN_FLAG;
        else 
            DynamicPreprocessorFatalMessage(
                "%s(%d) => %s is not a recognized argument to %s.\n", 
                *(_dpd.config_file), _dpd.config_file, tok, name);
    } while( (tok = strtok_r(NULL, ",", &end)) != NULL );

    *(unsigned long *)data = flags;

    return 0;
}

/* Parsing for the ssl_version rule option */
static int SSLPP_ver_init(char *name, char *params, void **data) 
{
    unsigned long flags = 0;
    char *end;
    char *tok;

    tok = strtok_r(params, ",", &end);

    if(!tok)
        DynamicPreprocessorFatalMessage("%s(%d) => missing argument to"
            "ssl_state keyword\n", *(_dpd.config_file), *(_dpd.config_line));

    do {
        if(!strcasecmp("sslv2", tok))
            flags |= SSL_VER_SSLV2_FLAG;
        else if(!strcasecmp("sslv3", tok))
            flags |= SSL_VER_SSLV3_FLAG;
        else if(!strcasecmp("tls1.0", tok))
            flags |= SSL_VER_TLS10_FLAG;
        else if(!strcasecmp("tls1.1", tok))
            flags |= SSL_VER_TLS11_FLAG;
        else if(!strcasecmp("tls1.2", tok))
            flags |= SSL_VER_TLS12_FLAG;
        else 
            DynamicPreprocessorFatalMessage(
                "%s(%d) => %s is not a recognized argument to %s.\n", 
                *(_dpd.config_file), _dpd.config_file, tok, name);
    } while( (tok = strtok_r(NULL, ",", &end)) != NULL );

    *(unsigned long *)data = flags;

    return 0;
}

/* Rule option evaluation (for both rule options) */
static int SSLPP_rule_eval(void *raw_packet, const u_int8_t **cursor, void *data)
{
    u_int32_t ssn_data; 
    unsigned long to_match = (unsigned long)data; 
    SFSnortPacket *p = (SFSnortPacket*)raw_packet; 

    if(!p || !p->tcp_header || !p->stream_session_ptr || !data) 
        return 0; 

    ssn_data = (unsigned long)_dpd.streamAPI->get_application_data( 
                p->stream_session_ptr, PP_SSL); 

    if(to_match & ssn_data)
        return 1;

    return 0;
}

/* SSL Preprocessor configuration parsing */
static void SSLPP_config(char *conf)
{
    char *saveptr;
    char *space_tok;
    char *comma_tok;
    char *portptr;
    char *search;
    SFP_errstr_t err;

    if(!conf) 
        return;
    
    search = conf;

    while( (comma_tok = strtok_r(search, ",", &saveptr)) != NULL ) 
    {
        search = NULL;

        space_tok = strtok_r(comma_tok, " ", &portptr);

        if(!space_tok)
            return;
        
        if(!strcasecmp(space_tok, "ports"))
        {
            memset(config.ports, 0, sizeof(config.ports));

            if(SFP_ports(config.ports, portptr, err) != SFP_SUCCESS)
                DynamicPreprocessorFatalMessage(
                    "%s(%d) => Failed to parse: %s\n",
                   *(_dpd.config_file), *(_dpd.config_line), SFP_GET_ERR(err));

        }
        else if(!strcasecmp(space_tok, "noinspect_encrypted")) 
        {
            char *tmpChar;
            tmpChar = strtok_r(NULL, " \t\n", &portptr);
            if(tmpChar)
            {
        	    DynamicPreprocessorFatalMessage("%s(%d) => Invalid argument to the"
        	                    " SSL preprocessor: '%s' in %s\n", 
        	                    *(_dpd.config_file), *(_dpd.config_line), space_tok, tmpChar);
            }
            config.flags |= SSLPP_DISABLE_FLAG;
        }
        else if(!strcasecmp(space_tok, "trustservers"))
        {
            char *tmpChar;
            tmpChar = strtok_r(NULL, " \t\n", &portptr);
            if(tmpChar)
            {
                DynamicPreprocessorFatalMessage("%s(%d) => Invalid argument to the"
                    " SSL preprocessor: '%s' in %s\n", 
                    *(_dpd.config_file), *(_dpd.config_line), space_tok, tmpChar);
            }
            config.flags |= SSLPP_TRUSTSERVER_FLAG;
        }
        else
        {
            DynamicPreprocessorFatalMessage("%s(%d) => Invalid argument to the"
                    " SSL preprocessor: '%s' in %s\n", 
                    *(_dpd.config_file), *(_dpd.config_line), comma_tok, conf);
        }
    } 

    /* Verify configured options make sense */
    if ((config.flags & SSLPP_TRUSTSERVER_FLAG) &&
        !(config.flags & SSLPP_DISABLE_FLAG))
    {
        DynamicPreprocessorFatalMessage("%s(%d) => SSL preprocessor: 'trustservers' requires 'noinspect_encrypted' to be useful.\n",
                    *(_dpd.config_file), *(_dpd.config_line));
    }

}

static void SSLPP_print_config(void) 
{
    char buf[1024];    /* For syslog printing */
    int i;
    int newline;

    memset(buf, 0, sizeof(buf));

    _dpd.logMsg("SSLPP config:\n");
    _dpd.logMsg("    Encrypted packets: %s\n",
           config.flags & SSLPP_DISABLE_FLAG ? "not inspected" : "inspected");

    _dpd.logMsg("    Ports:\n");

    for(newline = 0, i = 0; i < MAXPORTS; i++) 
    {
        if( config.ports[ PORT_INDEX(i) ] & CONV_PORT(i) )
        {
            SFP_snprintfa(buf, sizeof(buf), "    %5d", i);
            if( !((++newline) % 5) ) 
            {
                SFP_snprintfa(buf, sizeof(buf), "\n");
                _dpd.logMsg(buf);
                memset(buf, 0, sizeof(buf));
            }
        }
    }

    if(newline % 5)
        SFP_snprintfa(buf, sizeof(buf), "\n");

    _dpd.logMsg(buf);
}

static void SSLPP_init_config(void) {
    memset(&config, 0, sizeof(config));
    memset(&counts, 0, sizeof(counts));

#define SET_PORT(x) config.ports[ PORT_INDEX(x) ] |= CONV_PORT(x);  

    /* Setup default ports */
    SET_PORT(443); /* HTTPS */
    SET_PORT(465); /* SMTPS */
    SET_PORT(563); /* NNTPS */
    SET_PORT(636); /* LDAPS */
    SET_PORT(989); /* FTPS */
    SET_PORT(992); /* TelnetS */
    SET_PORT(993); /* IMAPS */
    SET_PORT(994); /* IRCS */
    SET_PORT(995); /* POPS */
}

static void SSLPP_drop_stats(int exiting) 
{
    if(!counts.decoded)
        return;

    _dpd.logMsg("SSL Preprocessor:\n");
    _dpd.logMsg("   SSL packets decoded: " FMTu64("-10") "\n", counts.decoded);
    _dpd.logMsg("         Alert records: " FMTu64("-10") "\n", counts.alerts);
    _dpd.logMsg("   Application records: " FMTu64("-10") "\n", counts.applications);
    _dpd.logMsg(" Change cipher records: " FMTu64("-10") "\n", counts.cipher_change);
    _dpd.logMsg("  Unrecognized records: " FMTu64("-10") "\n", counts.unrecognized);
    _dpd.logMsg("     Handshake records: " FMTu64("-10") "\n", counts.handshakes);
    _dpd.logMsg("  Completed handshakes: " FMTu64("-10") "\n", counts.completed_hs);
    _dpd.logMsg("        Bad handshakes: " FMTu64("-10") "\n", counts.bad_handshakes);
    _dpd.logMsg("      Sessions ignored: " FMTu64("-10") "\n", counts.stopped);
    _dpd.logMsg("    Detection disabled: " FMTu64("-10") "\n", counts.disabled);
}

static void SSLPP_init(char *conf) 
{
    if(!_dpd.streamAPI) 
    {
        DynamicPreprocessorFatalMessage(
            "SSLPP_init(): The Stream preprocessor must be enabled.\n");
    }

    SSLPP_init_config();
	SSLPP_config(conf);
    SSLPP_print_config();

	_dpd.addPreproc( SSLPP_process, PRIORITY_TUNNEL, PP_SSL );

    _dpd.preprocOptRegister("ssl_state", SSLPP_state_init, SSLPP_rule_eval, NULL);
    _dpd.preprocOptRegister("ssl_version", SSLPP_ver_init, SSLPP_rule_eval, NULL);
    _dpd.registerPreprocStats("ssl", SSLPP_drop_stats);

#ifdef PERF_PROFILING
    _dpd.addPreprocProfileFunc("ssl", (void *)&sslpp_perf_stats, 0, _dpd.totalPerfStats);
#endif
}

void SetupSSLPP(void)
{
	_dpd.registerPreproc( "ssl", SSLPP_init);
}

