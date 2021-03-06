/*
*  $Id: mpse.c,v 1.1 2008/10/01 06:17:20 ken_chiang Exp $
*
*   mpse.c
*    
*   An abstracted interface to the Multi-Pattern Matching routines,
*   thats why we're passing 'void *' objects around.
*
*   Copyright (C) 2002-2008 Sourcefire, Inc.
*   Marc A Norton <mnorton@sourcefire.com>
*
*   Updates:
*   3/06 - Added AC_BNFA search
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
**
*/
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "bitop.h"
#include "bnfa_search.h"
#include "acsmx.h"
#include "acsmx2.h"
#include "sfksearch.h"
#include "mpse.h"  
#include "debug.h"  
#include "sf_types.h"
#include "util.h"


#include "profiler.h"
#ifdef PERF_PROFILING
#include "snort.h"
PreprocStats mpsePerfStats;
#endif

static UINT64 s_bcnt=0;

typedef struct _mpse_struct {

    int    method;
    void * obj;
    int    verbose;
    UINT64 bcnt;
    char   inc_global_counter;

} MPSE;

void * mpseNew( int method, int use_global_counter_flag,
                void (*userfree)(void *p)
#ifdef DETECTION_OPTION_TREE
                , void (*optiontreefree)(void **p)
#endif
                )
{
    MPSE * p;

    p = (MPSE*)calloc( 1,sizeof(MPSE) );
    if( !p ) return NULL;

    p->method = method;
    p->verbose = 0;
    p->obj = NULL;
    p->bcnt = 0;
    p->inc_global_counter = use_global_counter_flag;

    switch( method )
    {
        case MPSE_AC_BNFA:
            p->obj=bnfaNew(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)
               ((bnfa_struct_t*)(p->obj))->bnfaMethod = 1;
            break;
        case MPSE_AC_BNFA_Q:
            p->obj=bnfaNew(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)
               ((bnfa_struct_t*)(p->obj))->bnfaMethod = 0;
            break;
        case MPSE_AC:
            p->obj = acsmNew();
            break;
        case MPSE_ACF:
            p->obj = acsmNew2(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)acsmSelectFormat2((ACSM_STRUCT2*)p->obj,ACF_FULL  );
            break;
        case MPSE_ACF_Q:
            p->obj = acsmNew2(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)acsmSelectFormat2((ACSM_STRUCT2*)p->obj,ACF_FULLQ  );
            break;
        case MPSE_ACS:
            p->obj = acsmNew2(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)acsmSelectFormat2((ACSM_STRUCT2*)p->obj,ACF_SPARSE  );
            break;
        case MPSE_ACB:
            p->obj = acsmNew2(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)acsmSelectFormat2((ACSM_STRUCT2*)p->obj,ACF_BANDED  );
            break;
        case MPSE_ACSB:
            p->obj = acsmNew2(userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            if(p->obj)acsmSelectFormat2((ACSM_STRUCT2*)p->obj,ACF_SPARSEBANDS  );
            break;
        case MPSE_LOWMEM:
            p->obj = KTrieNew(0,userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            break;
        case MPSE_LOWMEM_Q:
            p->obj = KTrieNew(1,userfree
#ifdef DETECTION_OPTION_TREE
                           , optiontreefree
#endif
                          );
            break;

        default:
            free(p);
            p = NULL;
            break;
    }

    if( !p->obj )
    {
        free(p);
        p = NULL;
    }

    return (void *)p;
}

void   mpseVerbose( void * pvoid )
{
    MPSE * p = (MPSE*)pvoid;
    p->verbose = 1;
} 

void   mpseSetOpt( void * pvoid, int flag )
{
    MPSE * p = (MPSE*)pvoid;

    if (p == NULL)
        return;
    switch( p->method )
    {
        case MPSE_AC_BNFA_Q:
        case MPSE_AC_BNFA:
            if (p->obj)
                bnfaSetOpt((bnfa_struct_t*)p->obj,flag);
            break;
        default:
            break;
    }
}

void   mpseFree( void * pvoid )
{
    MPSE * p = (MPSE*)pvoid;

    if (p == NULL)
        return;

    switch( p->method )
    {
        case MPSE_AC_BNFA:
        case MPSE_AC_BNFA_Q:
            if (p->obj)
                bnfaFree((bnfa_struct_t*)p->obj);
            free(p);
            return;

        case MPSE_AC:
            if (p->obj)
                acsmFree((ACSM_STRUCT *)p->obj);
            free(p);
            return;

        case MPSE_ACF:
        case MPSE_ACF_Q:
        case MPSE_ACS:
        case MPSE_ACB:
        case MPSE_ACSB:
            if (p->obj)
                acsmFree2((ACSM_STRUCT2 *)p->obj);
            free(p);
            return;

        case MPSE_LOWMEM:
        case MPSE_LOWMEM_Q:
            if (p->obj)
                KTrieDelete((KTRIE_STRUCT *)p->obj);
            free(p);
            return;

        default:
            return;
    }
}

int  mpseAddPattern ( void * pvoid, void * P, int m, 
             unsigned noCase,unsigned offset, unsigned depth,  void* ID, int IID )
{
  MPSE * p = (MPSE*)pvoid;

  switch( p->method )
   {
     case MPSE_AC_BNFA:
     case MPSE_AC_BNFA_Q:
       return bnfaAddPattern( (bnfa_struct_t*)p->obj, (unsigned char *)P, m,
              noCase, ID );

     case MPSE_AC:
       return acsmAddPattern( (ACSM_STRUCT*)p->obj, (unsigned char *)P, m,
              noCase, offset, depth, ID, IID );

     case MPSE_ACF:
     case MPSE_ACF_Q:
     case MPSE_ACS:
     case MPSE_ACB:
     case MPSE_ACSB:
       return acsmAddPattern2( (ACSM_STRUCT2*)p->obj, (unsigned char *)P, m,
              noCase, offset, depth, ID, IID );

     case MPSE_LOWMEM:
     case MPSE_LOWMEM_Q:
       return KTrieAddPattern( (KTRIE_STRUCT *)p->obj, (unsigned char *)P, m,
                                noCase, ID );

     default:
       return -1;
   }
}

void mpseLargeShifts   ( void * pvoid, int flag )
{
  MPSE * p = (MPSE*)pvoid;
 
  switch( p->method )
   {
     default:
       return ;
   }
}

int  mpsePrepPatterns  ( void * pvoid
#ifdef DETECTION_OPTION_TREE
                         , int ( *build_tree )(void*id, void **existing_tree)
#endif
                       )
{
  int retv;
  MPSE * p = (MPSE*)pvoid;

  switch( p->method )
   {
     case MPSE_AC_BNFA:
     case MPSE_AC_BNFA_Q:
       retv = bnfaCompile( (bnfa_struct_t*) p->obj
#ifdef DETECTION_OPTION_TREE
                         , build_tree
#endif
                         );
     break;
     
     case MPSE_AC:
       retv = acsmCompile( (ACSM_STRUCT*) p->obj
#ifdef DETECTION_OPTION_TREE
                         , build_tree
#endif
                         );
     break;
     
     case MPSE_ACF:
     case MPSE_ACF_Q:
     case MPSE_ACS:
     case MPSE_ACB:
     case MPSE_ACSB:
       retv = acsmCompile2( (ACSM_STRUCT2*) p->obj
#ifdef DETECTION_OPTION_TREE
                         , build_tree
#endif
                         );
     break;
     
     case MPSE_LOWMEM:
     case MPSE_LOWMEM_Q:
       return KTrieCompile( (KTRIE_STRUCT *)p->obj
#ifdef DETECTION_OPTION_TREE
                         , build_tree
#endif
                         );

     default:
       retv = 1;
     break; 
   }
  
  return retv;
}

void mpseSetRuleMask ( void *pvoid, BITOP * rm )
{
  MPSE * p = (MPSE*)pvoid;

  switch( p->method )
   {
     default:
       return ;
   }


}
int mpsePrintInfo( void *pvoid )
{
  MPSE * p = (MPSE*)pvoid;

  fflush(stderr);
  fflush(stdout);
  switch( p->method )
   {
     case MPSE_AC_BNFA:
     case MPSE_AC_BNFA_Q:
      bnfaPrintInfo( (bnfa_struct_t*) p->obj );
     break;
     case MPSE_AC:
      return acsmPrintDetailInfo( (ACSM_STRUCT*) p->obj );
     case MPSE_ACF:
     case MPSE_ACF_Q:
     case MPSE_ACS:
     case MPSE_ACB:
     case MPSE_ACSB:
      return acsmPrintDetailInfo2( (ACSM_STRUCT2*) p->obj );
     
     default:
       return 1;
   }
   fflush(stderr);
   fflush(stdout);

 return 0;
}

int mpsePrintSummary(void )
{
   fflush(stderr);
   fflush(stdout);

   acsmPrintSummaryInfo();
   acsmPrintSummaryInfo2();
   bnfaPrintSummary();
  
   if( KTrieMemUsed() )
   {
     double x;
     x = (double) KTrieMemUsed();
     LogMessage("[ LowMem Search-Method Memory Used : %g %s ]\n",
     (x > 1.e+6) ?  x/1.e+6 : x/1.e+3,
     (x > 1.e+6) ? "MBytes" : "KBytes" );
     
   }
   fflush(stderr);
   fflush(stdout);

   return 0;
}

int mpseSearch( void *pvoid, const unsigned char * T, int n, 
#ifdef DETECTION_OPTION_TREE
     int ( *action )(void* id, void * tree, int index, void *data), 
#else
     int ( *action )(void* id, int index, void *data), 
#endif
    void * data, int* current_state ) 
{
  MPSE * p = (MPSE*)pvoid;
  int ret;
  PROFILE_VARS;

  PREPROC_PROFILE_START(mpsePerfStats);

  p->bcnt += n;

  if(p->inc_global_counter)
    s_bcnt += n;
  
  switch( p->method )
   {
     case MPSE_AC_BNFA:
     case MPSE_AC_BNFA_Q:
      /* return is actually the state */
      ret = bnfaSearch( (bnfa_struct_t*) p->obj, (unsigned char *)T, n, action, data, 0 /* start-state */, current_state );
      PREPROC_PROFILE_END(mpsePerfStats);
      return ret;

     case MPSE_AC:
      ret = acsmSearch( (ACSM_STRUCT*) p->obj, (unsigned char *)T, n, action, data,
                   current_state );
      PREPROC_PROFILE_END(mpsePerfStats);
      return ret;
     
     case MPSE_ACF:
     case MPSE_ACF_Q:
     case MPSE_ACS:
     case MPSE_ACB:
     case MPSE_ACSB:
      ret = acsmSearch2( (ACSM_STRUCT2*) p->obj, (unsigned char *)T, n, action, data,
                   current_state );
      PREPROC_PROFILE_END(mpsePerfStats);
      return ret;

     case MPSE_LOWMEM:
     case MPSE_LOWMEM_Q:
        ret = KTrieSearch( (KTRIE_STRUCT *)p->obj, (unsigned char *)T, n, action, data);
        *current_state = 0;
        PREPROC_PROFILE_END(mpsePerfStats);
        return ret;

     default:
       PREPROC_PROFILE_END(mpsePerfStats);
       return 1;
   }

}


UINT64 mpseGetPatByteCount( )
{
    return s_bcnt; 
}

void mpseResetByteCount( )
{
    s_bcnt = 0;
}

void mpse_print_qinfo()
{
    sfksearch_print_qinfo();
    bnfa_print_qinfo();
    acsmx2_print_qinfo();
}

