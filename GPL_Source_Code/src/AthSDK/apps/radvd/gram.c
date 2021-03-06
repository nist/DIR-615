/* A Bison parser, made by GNU Bison 1.875c.  */

/* Skeleton parser for Yacc-like parsing with Bison,
   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* Written by Richard Stallman by simplifying the original so called
   ``semantic'' parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_INTERFACE = 258,
     T_PREFIX = 259,
     T_ROUTE = 260,
     T_RDNSS = 261,
     STRING = 262,
     NUMBER = 263,
     SIGNEDNUMBER = 264,
     DECIMAL = 265,
     SWITCH = 266,
     IPV6ADDR = 267,
     INFINITY = 268,
     T_IgnoreIfMissing = 269,
     T_AdvSendAdvert = 270,
     T_MaxRtrAdvInterval = 271,
     T_MinRtrAdvInterval = 272,
     T_MinDelayBetweenRAs = 273,
     T_AdvManagedFlag = 274,
     T_AdvOtherConfigFlag = 275,
     T_AdvLinkMTU = 276,
     T_AdvReachableTime = 277,
     T_AdvRetransTimer = 278,
     T_AdvCurHopLimit = 279,
     T_AdvDefaultLifetime = 280,
     T_AdvDefaultPreference = 281,
     T_AdvSourceLLAddress = 282,
     T_AdvOnLink = 283,
     T_AdvAutonomous = 284,
     T_AdvValidLifetime = 285,
     T_AdvPreferredLifetime = 286,
     T_AdvRouterAddr = 287,
     T_AdvHomeAgentFlag = 288,
     T_AdvIntervalOpt = 289,
     T_AdvHomeAgentInfo = 290,
     T_Base6to4Interface = 291,
     T_UnicastOnly = 292,
     T_HomeAgentPreference = 293,
     T_HomeAgentLifetime = 294,
     T_AdvRoutePreference = 295,
     T_AdvRouteLifetime = 296,
     T_AdvRDNSSPreference = 297,
     T_AdvRDNSSOpenFlag = 298,
     T_AdvRDNSSLifetime = 299,
     T_AdvMobRtrSupportFlag = 300,
     T_BAD_TOKEN = 301
   };
#endif
#define T_INTERFACE 258
#define T_PREFIX 259
#define T_ROUTE 260
#define T_RDNSS 261
#define STRING 262
#define NUMBER 263
#define SIGNEDNUMBER 264
#define DECIMAL 265
#define SWITCH 266
#define IPV6ADDR 267
#define INFINITY 268
#define T_IgnoreIfMissing 269
#define T_AdvSendAdvert 270
#define T_MaxRtrAdvInterval 271
#define T_MinRtrAdvInterval 272
#define T_MinDelayBetweenRAs 273
#define T_AdvManagedFlag 274
#define T_AdvOtherConfigFlag 275
#define T_AdvLinkMTU 276
#define T_AdvReachableTime 277
#define T_AdvRetransTimer 278
#define T_AdvCurHopLimit 279
#define T_AdvDefaultLifetime 280
#define T_AdvDefaultPreference 281
#define T_AdvSourceLLAddress 282
#define T_AdvOnLink 283
#define T_AdvAutonomous 284
#define T_AdvValidLifetime 285
#define T_AdvPreferredLifetime 286
#define T_AdvRouterAddr 287
#define T_AdvHomeAgentFlag 288
#define T_AdvIntervalOpt 289
#define T_AdvHomeAgentInfo 290
#define T_Base6to4Interface 291
#define T_UnicastOnly 292
#define T_HomeAgentPreference 293
#define T_HomeAgentLifetime 294
#define T_AdvRoutePreference 295
#define T_AdvRouteLifetime 296
#define T_AdvRDNSSPreference 297
#define T_AdvRDNSSOpenFlag 298
#define T_AdvRDNSSLifetime 299
#define T_AdvMobRtrSupportFlag 300
#define T_BAD_TOKEN 301




/* Copy the first part of user declarations.  */
#line 16 "gram.y"

#include <config.h>
#include <includes.h>
#include <radvd.h>
#include <defaults.h>

extern struct Interface *IfaceList;
struct Interface *iface = NULL;
struct AdvPrefix *prefix = NULL;
struct AdvRoute *route = NULL;
struct AdvRDNSS *rdnss = NULL;

extern char *conf_file;
extern int num_lines;
extern char *yytext;
extern int sock;

static void cleanup(void);
static void yyerror(char *msg);

#if 0 /* no longer necessary? */
#ifndef HAVE_IN6_ADDR_S6_ADDR
# ifdef __FreeBSD__
#  define s6_addr32 __u6_addr.__u6_addr32
#  define s6_addr16 __u6_addr.__u6_addr16
# endif
#endif
#endif

#define ABORT	do { cleanup(); YYABORT; } while (0);



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 110 "gram.y"
typedef union YYSTYPE {
	unsigned int		num;
	int			snum;
	double			dec;
	int			bool;
	struct in6_addr		*addr;
	char			*str;
	struct AdvPrefix	*pinfo;
	struct AdvRoute		*rinfo;
	struct AdvRDNSS		*rdnssinfo;
} YYSTYPE;
/* Line 191 of yacc.c.  */
#line 213 "y.tab.c"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 214 of yacc.c.  */
#line 225 "y.tab.c"

#if ! defined (yyoverflow) || YYERROR_VERBOSE

# ifndef YYFREE
#  define YYFREE free
# endif
# ifndef YYMALLOC
#  define YYMALLOC malloc
# endif

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   define YYSTACK_ALLOC alloca
#  endif
# else
#  if defined (alloca) || defined (_ALLOCA_H)
#   define YYSTACK_ALLOC alloca
#  else
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning. */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
# else
#  if defined (__STDC__) || defined (__cplusplus)
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   define YYSIZE_T size_t
#  endif
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
# endif
#endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */


#if (! defined (yyoverflow) \
     && (! defined (__cplusplus) \
	 || (defined (YYSTYPE_IS_TRIVIAL) && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE))				\
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined (__GNUC__) && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  register YYSIZE_T yyi;		\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (0)
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (0)

#endif

#if defined (__STDC__) || defined (__cplusplus)
   typedef signed char yysigned_char;
#else
   typedef short yysigned_char;
#endif

/* YYFINAL -- State number of the termination state. */
#define YYFINAL  7
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   151

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  51
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  33
/* YYNRULES -- Number of rules. */
#define YYNRULES  81
/* YYNRULES -- Number of states. */
#define YYNSTATES  170

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   301

#define YYTRANSLATE(YYX) 						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const unsigned char yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,    50,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    49,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    47,     2,    48,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned short yyprhs[] =
{
       0,     0,     3,     6,     8,    14,    17,    19,    24,    25,
      27,    28,    30,    31,    33,    34,    36,    39,    41,    45,
      49,    53,    57,    61,    65,    69,    73,    77,    81,    85,
      89,    93,    97,   101,   105,   109,   113,   117,   121,   125,
     129,   133,   137,   139,   142,   148,   153,   154,   156,   159,
     161,   165,   169,   173,   177,   181,   185,   187,   190,   196,
     201,   202,   204,   207,   209,   213,   217,   219,   222,   228,
     231,   233,   235,   238,   239,   241,   244,   246,   250,   254,
     258,   260
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      52,     0,    -1,    52,    53,    -1,    53,    -1,    54,    47,
      56,    48,    49,    -1,     3,    55,    -1,     7,    -1,    57,
      58,    59,    60,    -1,    -1,    61,    -1,    -1,    63,    -1,
      -1,    69,    -1,    -1,    75,    -1,    61,    62,    -1,    62,
      -1,    17,     8,    49,    -1,    16,     8,    49,    -1,    18,
       8,    49,    -1,    17,    10,    49,    -1,    16,    10,    49,
      -1,    18,    10,    49,    -1,    14,    11,    49,    -1,    15,
      11,    49,    -1,    19,    11,    49,    -1,    20,    11,    49,
      -1,    21,     8,    49,    -1,    22,     8,    49,    -1,    23,
       8,    49,    -1,    25,     8,    49,    -1,    26,     9,    49,
      -1,    24,     8,    49,    -1,    27,    11,    49,    -1,    34,
      11,    49,    -1,    35,    11,    49,    -1,    33,    11,    49,
      -1,    38,     8,    49,    -1,    39,     8,    49,    -1,    37,
      11,    49,    -1,    45,    11,    49,    -1,    64,    -1,    63,
      64,    -1,    65,    47,    66,    48,    49,    -1,     4,    12,
      50,     8,    -1,    -1,    67,    -1,    67,    68,    -1,    68,
      -1,    28,    11,    49,    -1,    29,    11,    49,    -1,    32,
      11,    49,    -1,    30,    83,    49,    -1,    31,    83,    49,
      -1,    36,    55,    49,    -1,    70,    -1,    69,    70,    -1,
      71,    47,    72,    48,    49,    -1,     5,    12,    50,     8,
      -1,    -1,    73,    -1,    73,    74,    -1,    74,    -1,    40,
       9,    49,    -1,    41,    83,    49,    -1,    76,    -1,    75,
      76,    -1,    79,    47,    80,    48,    49,    -1,    77,    78,
      -1,    78,    -1,    12,    -1,     6,    77,    -1,    -1,    81,
      -1,    81,    82,    -1,    82,    -1,    42,     8,    49,    -1,
      43,    11,    49,    -1,    44,    83,    49,    -1,     8,    -1,
      13,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short yyrline[] =
{
       0,   124,   124,   125,   128,   172,   187,   194,   202,   203,
     207,   210,   214,   217,   221,   224,   227,   228,   231,   235,
     239,   243,   247,   251,   255,   259,   263,   267,   271,   275,
     279,   283,   287,   291,   295,   299,   303,   307,   311,   315,
     319,   323,   329,   333,   340,   371,   394,   395,   398,   399,
     402,   406,   410,   414,   418,   422,   430,   434,   441,   449,
     473,   474,   477,   478,   482,   486,   492,   496,   503,   510,
     511,   514,   549,   558,   559,   562,   563,   567,   571,   575,
     588,   592
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_INTERFACE", "T_PREFIX", "T_ROUTE",
  "T_RDNSS", "STRING", "NUMBER", "SIGNEDNUMBER", "DECIMAL", "SWITCH",
  "IPV6ADDR", "INFINITY", "T_IgnoreIfMissing", "T_AdvSendAdvert",
  "T_MaxRtrAdvInterval", "T_MinRtrAdvInterval", "T_MinDelayBetweenRAs",
  "T_AdvManagedFlag", "T_AdvOtherConfigFlag", "T_AdvLinkMTU",
  "T_AdvReachableTime", "T_AdvRetransTimer", "T_AdvCurHopLimit",
  "T_AdvDefaultLifetime", "T_AdvDefaultPreference", "T_AdvSourceLLAddress",
  "T_AdvOnLink", "T_AdvAutonomous", "T_AdvValidLifetime",
  "T_AdvPreferredLifetime", "T_AdvRouterAddr", "T_AdvHomeAgentFlag",
  "T_AdvIntervalOpt", "T_AdvHomeAgentInfo", "T_Base6to4Interface",
  "T_UnicastOnly", "T_HomeAgentPreference", "T_HomeAgentLifetime",
  "T_AdvRoutePreference", "T_AdvRouteLifetime", "T_AdvRDNSSPreference",
  "T_AdvRDNSSOpenFlag", "T_AdvRDNSSLifetime", "T_AdvMobRtrSupportFlag",
  "T_BAD_TOKEN", "'{'", "'}'", "';'", "'/'", "$accept", "grammar",
  "ifacedef", "ifacehead", "name", "ifaceparams", "optional_ifacevlist",
  "optional_prefixlist", "optional_routelist", "optional_rdnsslist",
  "ifacevlist", "ifaceval", "prefixlist", "prefixdef", "prefixhead",
  "optional_prefixplist", "prefixplist", "prefixparms", "routelist",
  "routedef", "routehead", "optional_routeplist", "routeplist",
  "routeparms", "rdnsslist", "rdnssdef", "rdnssaddrs", "rdnssaddr",
  "rdnsshead", "optional_rdnssplist", "rdnssplist", "rdnssparms",
  "number_or_infinity", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const unsigned short yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   123,   125,    59,
      47
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    51,    52,    52,    53,    54,    55,    56,    57,    57,
      58,    58,    59,    59,    60,    60,    61,    61,    62,    62,
      62,    62,    62,    62,    62,    62,    62,    62,    62,    62,
      62,    62,    62,    62,    62,    62,    62,    62,    62,    62,
      62,    62,    63,    63,    64,    65,    66,    66,    67,    67,
      68,    68,    68,    68,    68,    68,    69,    69,    70,    71,
      72,    72,    73,    73,    74,    74,    75,    75,    76,    77,
      77,    78,    79,    80,    80,    81,    81,    82,    82,    82,
      83,    83
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     2,     1,     5,     2,     1,     4,     0,     1,
       0,     1,     0,     1,     0,     1,     2,     1,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     1,     2,     5,     4,     0,     1,     2,     1,
       3,     3,     3,     3,     3,     3,     1,     2,     5,     4,
       0,     1,     2,     1,     3,     3,     1,     2,     5,     2,
       1,     1,     2,     0,     1,     2,     1,     3,     3,     3,
       1,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       0,     0,     0,     3,     0,     6,     5,     1,     2,     8,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    10,     9,    17,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    12,    11,    42,     0,    16,    24,    25,    19,    22,
      18,    21,    20,    23,    26,    27,    28,    29,    30,    33,
      31,    32,    34,    37,    35,    36,    40,    38,    39,    41,
       4,     0,     0,    14,    13,    56,     0,    43,    46,     0,
       0,     0,     7,    15,    66,     0,    57,    60,     0,     0,
       0,     0,     0,     0,     0,    47,    49,    45,     0,    71,
      72,    70,    67,    73,     0,     0,     0,    61,    63,     0,
       0,    80,    81,     0,     0,     0,     0,     0,    48,    59,
      69,     0,     0,     0,     0,    74,    76,     0,     0,     0,
      62,    50,    51,    53,    54,    52,    55,    44,     0,     0,
       0,     0,    75,    64,    65,    58,    77,    78,    79,    68
};

/* YYDEFGOTO[NTERM-NUM]. */
static const short yydefgoto[] =
{
      -1,     2,     3,     4,     6,    31,    32,    61,    93,   102,
      33,    34,    62,    63,    64,   114,   115,   116,    94,    95,
      96,   126,   127,   128,   103,   104,   120,   121,   105,   144,
     145,   146,   133
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -112
static const yysigned_char yypact[] =
{
       5,    26,     7,  -112,   -10,  -112,  -112,  -112,  -112,     1,
      38,    39,    33,    34,    37,    40,    41,    45,    46,    47,
      48,    49,    50,    51,    52,    53,    54,    55,    59,    60,
      58,     0,    56,     1,  -112,     9,    12,    21,    22,    23,
      24,    25,    27,    28,    29,    30,    31,    32,    35,    36,
      42,    43,    44,    57,    61,    62,    63,    64,    65,    66,
      70,    78,    56,  -112,    69,  -112,  -112,  -112,  -112,  -112,
    -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,
    -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,
    -112,    67,    74,    81,    78,  -112,    71,  -112,   -27,    80,
      72,    77,  -112,    81,  -112,    73,  -112,   -28,    79,    83,
      -2,    -2,    84,    26,    75,   -27,  -112,  -112,    88,  -112,
      77,  -112,  -112,   -13,    89,    -2,    76,   -28,  -112,    82,
      85,  -112,  -112,    86,    87,    90,    91,    92,  -112,  -112,
    -112,    93,    94,    -2,    95,   -13,  -112,    96,    97,    98,
    -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,    99,   100,
     101,   102,  -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112
};

/* YYPGOTO[NTERM-NUM].  */
static const yysigned_char yypgoto[] =
{
    -112,  -112,   105,  -112,   -38,  -112,  -112,  -112,  -112,  -112,
    -112,   104,  -112,    68,  -112,  -112,  -112,   -18,  -112,     6,
    -112,  -112,  -112,   -25,  -112,    -4,  -112,   -17,  -112,  -112,
    -112,   -41,  -111
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const unsigned char yytable[] =
{
     134,   108,   109,   110,   111,   112,   131,     7,     1,   113,
       1,   132,   124,   125,   148,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,   141,
     142,   143,   160,     5,    24,    25,    26,     9,    27,    28,
      29,    37,    39,    38,    40,    41,    30,    42,    59,    35,
      36,    43,    44,    45,    46,    47,    48,    49,    66,    50,
      60,    67,    51,    52,    53,    54,    55,    56,    57,    58,
      68,    69,    70,    71,    72,   136,    73,    74,    75,    76,
      77,    78,    91,    92,    79,    80,   100,   101,   117,   119,
     129,    81,    82,    83,   130,   135,   139,   138,   147,   122,
     106,   158,   150,   140,   162,   159,    84,     8,     0,     0,
      85,    86,    87,    88,    89,    90,    98,    99,   107,     0,
     123,     0,   118,   137,   149,     0,     0,     0,     0,     0,
      97,   151,     0,     0,   152,   153,   154,    65,     0,   155,
     156,   157,     0,   161,     0,   163,   164,   165,   166,   167,
     168,   169
};

static const short yycheck[] =
{
     111,    28,    29,    30,    31,    32,     8,     0,     3,    36,
       3,    13,    40,    41,   125,    14,    15,    16,    17,    18,
      19,    20,    21,    22,    23,    24,    25,    26,    27,    42,
      43,    44,   143,     7,    33,    34,    35,    47,    37,    38,
      39,     8,     8,    10,    10,     8,    45,    10,    48,    11,
      11,    11,    11,     8,     8,     8,     8,     8,    49,     9,
       4,    49,    11,    11,    11,    11,    11,     8,     8,    11,
      49,    49,    49,    49,    49,   113,    49,    49,    49,    49,
      49,    49,    12,     5,    49,    49,    12,     6,     8,    12,
      11,    49,    49,    49,    11,    11,     8,   115,     9,   103,
      94,     8,   127,   120,   145,    11,    49,     2,    -1,    -1,
      49,    49,    49,    49,    49,    49,    47,    50,    47,    -1,
      47,    -1,    50,    48,    48,    -1,    -1,    -1,    -1,    -1,
      62,    49,    -1,    -1,    49,    49,    49,    33,    -1,    49,
      49,    49,    -1,    48,    -1,    49,    49,    49,    49,    49,
      49,    49
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,     3,    52,    53,    54,     7,    55,     0,    53,    47,
      14,    15,    16,    17,    18,    19,    20,    21,    22,    23,
      24,    25,    26,    27,    33,    34,    35,    37,    38,    39,
      45,    56,    57,    61,    62,    11,    11,     8,    10,     8,
      10,     8,    10,    11,    11,     8,     8,     8,     8,     8,
       9,    11,    11,    11,    11,    11,     8,     8,    11,    48,
       4,    58,    63,    64,    65,    62,    49,    49,    49,    49,
      49,    49,    49,    49,    49,    49,    49,    49,    49,    49,
      49,    49,    49,    49,    49,    49,    49,    49,    49,    49,
      49,    12,     5,    59,    69,    70,    71,    64,    47,    50,
      12,     6,    60,    75,    76,    79,    70,    47,    28,    29,
      30,    31,    32,    36,    66,    67,    68,     8,    50,    12,
      77,    78,    76,    47,    40,    41,    72,    73,    74,    11,
      11,     8,    13,    83,    83,    11,    55,    48,    68,     8,
      78,    42,    43,    44,    80,    81,    82,     9,    83,    48,
      74,    49,    49,    49,    49,    49,    49,    49,     8,    11,
      83,    48,    82,    49,    49,    49,    49,    49,    49,    49
};

#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
# define YYSIZE_T __SIZE_TYPE__
#endif
#if ! defined (YYSIZE_T) && defined (size_t)
# define YYSIZE_T size_t
#endif
#if ! defined (YYSIZE_T)
# if defined (__STDC__) || defined (__cplusplus)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# endif
#endif
#if ! defined (YYSIZE_T)
# define YYSIZE_T unsigned int
#endif

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { 								\
      yyerror ("syntax error: cannot back up");\
      YYERROR;							\
    }								\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

/* YYLLOC_DEFAULT -- Compute the default location (before the actions
   are run).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)		\
   ((Current).first_line   = (Rhs)[1].first_line,	\
    (Current).first_column = (Rhs)[1].first_column,	\
    (Current).last_line    = (Rhs)[N].last_line,	\
    (Current).last_column  = (Rhs)[N].last_column)
#endif

/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (0)

# define YYDSYMPRINT(Args)			\
do {						\
  if (yydebug)					\
    yysymprint Args;				\
} while (0)

# define YYDSYMPRINTF(Title, Token, Value, Location)		\
do {								\
  if (yydebug)							\
    {								\
      YYFPRINTF (stderr, "%s ", Title);				\
      yysymprint (stderr, 					\
                  Token, Value);	\
      YYFPRINTF (stderr, "\n");					\
    }								\
} while (0)

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_stack_print (short *bottom, short *top)
#else
static void
yy_stack_print (bottom, top)
    short *bottom;
    short *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (/* Nothing. */; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_reduce_print (int yyrule)
#else
static void
yy_reduce_print (yyrule)
    int yyrule;
#endif
{
  int yyi;
  unsigned int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %u), ",
             yyrule - 1, yylno);
  /* Print the symbols being reduced, and their result.  */
  for (yyi = yyprhs[yyrule]; 0 <= yyrhs[yyi]; yyi++)
    YYFPRINTF (stderr, "%s ", yytname [yyrhs[yyi]]);
  YYFPRINTF (stderr, "-> %s\n", yytname [yyr1[yyrule]]);
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (Rule);		\
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YYDSYMPRINT(Args)
# define YYDSYMPRINTF(Title, Token, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   SIZE_MAX < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#if defined (YYMAXDEPTH) && YYMAXDEPTH == 0
# undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined (__GLIBC__) && defined (_STRING_H)
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
#   if defined (__STDC__) || defined (__cplusplus)
yystrlen (const char *yystr)
#   else
yystrlen (yystr)
     const char *yystr;
#   endif
{
  register const char *yys = yystr;

  while (*yys++ != '\0')
    continue;

  return yys - yystr - 1;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined (__GLIBC__) && defined (_STRING_H) && defined (_GNU_SOURCE)
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
#   if defined (__STDC__) || defined (__cplusplus)
yystpcpy (char *yydest, const char *yysrc)
#   else
yystpcpy (yydest, yysrc)
     char *yydest;
     const char *yysrc;
#   endif
{
  register char *yyd = yydest;
  register const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

#endif /* !YYERROR_VERBOSE */



#if YYDEBUG
/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yysymprint (FILE *yyoutput, int yytype, YYSTYPE *yyvaluep)
#else
static void
yysymprint (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  if (yytype < YYNTOKENS)
    {
      YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
# ifdef YYPRINT
      YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
    }
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  switch (yytype)
    {
      default:
        break;
    }
  YYFPRINTF (yyoutput, ")");
}

#endif /* ! YYDEBUG */
/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yydestruct (int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yytype, yyvaluep)
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  switch (yytype)
    {

      default:
        break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM);
# else
int yyparse ();
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM)
# else
int yyparse (YYPARSE_PARAM)
  void *YYPARSE_PARAM;
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  register int yystate;
  register int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  short	yyssa[YYINITDEPTH];
  short *yyss = yyssa;
  register short *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  register YYSTYPE *yyvsp;



#define YYPOPSTACK   (yyvsp--, yyssp--)

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* When reducing, the number of symbols on the RHS of the reduced
     rule.  */
  int yylen;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed. so pushing a state here evens the stacks.
     */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack. Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	short *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyoverflowlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyoverflowlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	short *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyoverflowlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YYDSYMPRINTF ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */
  YYDPRINTF ((stderr, "Shifting token %s, ", yytname[yytoken]));

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;


  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  yystate = yyn;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 4:
#line 129 "gram.y"
    {
			struct Interface *iface2;

			iface2 = IfaceList;
			while (iface2)
			{
				if (!strcmp(iface2->Name, iface->Name))
				{
					flog(LOG_ERR, "duplicate interface "
						"definition for %s", iface->Name);
					ABORT;
				}
				iface2 = iface2->next;
			}			

			if (check_device(sock, iface) < 0) {
				if (iface->IgnoreIfMissing) {
					dlog(LOG_DEBUG, 4, "interface %s did not exist, ignoring the interface", iface->Name);
					goto skip_interface;
				}
				else {
					flog(LOG_ERR, "interface %s does not exist", iface->Name);
					ABORT;
				}
			}
			if (setup_deviceinfo(sock, iface) < 0)
				ABORT;
			if (check_iface(iface) < 0)
				ABORT;
			if (setup_linklocal_addr(sock, iface) < 0)
				ABORT;
			if (setup_allrouters_membership(sock, iface) < 0)
				ABORT;

			iface->next = IfaceList;
			IfaceList = iface;

			dlog(LOG_DEBUG, 4, "interface definition for %s is ok", iface->Name);

skip_interface:
			iface = NULL;
		}
    break;

  case 5:
#line 173 "gram.y"
    {
			iface = malloc(sizeof(struct Interface));

			if (iface == NULL) {
				flog(LOG_CRIT, "malloc failed: %s", strerror(errno));
				ABORT;
			}

			iface_init_defaults(iface);
			strncpy(iface->Name, yyvsp[0].str, IFNAMSIZ-1);
			iface->Name[IFNAMSIZ-1] = '\0';
		}
    break;

  case 6:
#line 188 "gram.y"
    {
			/* check vality */
			yyval.str = yyvsp[0].str;
		}
    break;

  case 7:
#line 195 "gram.y"
    {
			iface->AdvPrefixList = yyvsp[-2].pinfo;
			iface->AdvRouteList = yyvsp[-1].rinfo;
			iface->AdvRDNSSList = yyvsp[0].rdnssinfo;
		}
    break;

  case 10:
#line 207 "gram.y"
    {
			yyval.pinfo = NULL;
		}
    break;

  case 12:
#line 214 "gram.y"
    {
			yyval.rinfo = NULL;
		}
    break;

  case 14:
#line 221 "gram.y"
    {
			yyval.rdnssinfo = NULL;
		}
    break;

  case 18:
#line 232 "gram.y"
    {
			iface->MinRtrAdvInterval = yyvsp[-1].num;
		}
    break;

  case 19:
#line 236 "gram.y"
    {
			iface->MaxRtrAdvInterval = yyvsp[-1].num;
		}
    break;

  case 20:
#line 240 "gram.y"
    {
			iface->MinDelayBetweenRAs = yyvsp[-1].num;
		}
    break;

  case 21:
#line 244 "gram.y"
    {
			iface->MinRtrAdvInterval = yyvsp[-1].dec;
		}
    break;

  case 22:
#line 248 "gram.y"
    {
			iface->MaxRtrAdvInterval = yyvsp[-1].dec;
		}
    break;

  case 23:
#line 252 "gram.y"
    {
			iface->MinDelayBetweenRAs = yyvsp[-1].dec;
		}
    break;

  case 24:
#line 256 "gram.y"
    {
			iface->IgnoreIfMissing = yyvsp[-1].bool;
		}
    break;

  case 25:
#line 260 "gram.y"
    {
			iface->AdvSendAdvert = yyvsp[-1].bool;
		}
    break;

  case 26:
#line 264 "gram.y"
    {
			iface->AdvManagedFlag = yyvsp[-1].bool;
		}
    break;

  case 27:
#line 268 "gram.y"
    {
			iface->AdvOtherConfigFlag = yyvsp[-1].bool;
		}
    break;

  case 28:
#line 272 "gram.y"
    {
			iface->AdvLinkMTU = yyvsp[-1].num;
		}
    break;

  case 29:
#line 276 "gram.y"
    {
			iface->AdvReachableTime = yyvsp[-1].num;
		}
    break;

  case 30:
#line 280 "gram.y"
    {
			iface->AdvRetransTimer = yyvsp[-1].num;
		}
    break;

  case 31:
#line 284 "gram.y"
    {
			iface->AdvDefaultLifetime = yyvsp[-1].num;
		}
    break;

  case 32:
#line 288 "gram.y"
    {
			iface->AdvDefaultPreference = yyvsp[-1].snum;
		}
    break;

  case 33:
#line 292 "gram.y"
    {
			iface->AdvCurHopLimit = yyvsp[-1].num;
		}
    break;

  case 34:
#line 296 "gram.y"
    {
			iface->AdvSourceLLAddress = yyvsp[-1].bool;
		}
    break;

  case 35:
#line 300 "gram.y"
    {
			iface->AdvIntervalOpt = yyvsp[-1].bool;
		}
    break;

  case 36:
#line 304 "gram.y"
    {
			iface->AdvHomeAgentInfo = yyvsp[-1].bool;
		}
    break;

  case 37:
#line 308 "gram.y"
    {
			iface->AdvHomeAgentFlag = yyvsp[-1].bool;
		}
    break;

  case 38:
#line 312 "gram.y"
    {
			iface->HomeAgentPreference = yyvsp[-1].num;
		}
    break;

  case 39:
#line 316 "gram.y"
    {
			iface->HomeAgentLifetime = yyvsp[-1].num;
		}
    break;

  case 40:
#line 320 "gram.y"
    {
			iface->UnicastOnly = yyvsp[-1].bool;
		}
    break;

  case 41:
#line 324 "gram.y"
    {
			iface->AdvMobRtrSupportFlag = yyvsp[-1].bool;
		}
    break;

  case 42:
#line 330 "gram.y"
    {
			yyval.pinfo = yyvsp[0].pinfo;
		}
    break;

  case 43:
#line 334 "gram.y"
    {
			yyvsp[0].pinfo->next = yyvsp[-1].pinfo;
			yyval.pinfo = yyvsp[0].pinfo;
		}
    break;

  case 44:
#line 341 "gram.y"
    {
			unsigned int dst;

			if (prefix->AdvPreferredLifetime >
			    prefix->AdvValidLifetime)
			{
				flog(LOG_ERR, "AdvValidLifeTime must be "
					"greater than AdvPreferredLifetime in %s, line %d", 
					conf_file, num_lines);
				ABORT;
			}

			if( prefix->if6to4[0] )
			{
				if (get_v4addr(prefix->if6to4, &dst) < 0)
				{
					flog(LOG_ERR, "interface %s has no IPv4 addresses, disabling 6to4 prefix", prefix->if6to4 );
					prefix->enabled = 0;
				} else
				{
					*((uint16_t *)(prefix->Prefix.s6_addr)) = htons(0x2002);
					memcpy( prefix->Prefix.s6_addr + 2, &dst, sizeof( dst ) );
				}
			}

			yyval.pinfo = prefix;
			prefix = NULL;
		}
    break;

  case 45:
#line 372 "gram.y"
    {
			prefix = malloc(sizeof(struct AdvPrefix));
			
			if (prefix == NULL) {
				flog(LOG_CRIT, "malloc failed: %s", strerror(errno));
				ABORT;
			}

			prefix_init_defaults(prefix);

			if (yyvsp[0].num > MAX_PrefixLen)
			{
				flog(LOG_ERR, "invalid prefix length in %s, line %d", conf_file, num_lines);
				ABORT;
			}

			prefix->PrefixLen = yyvsp[0].num;

			memcpy(&prefix->Prefix, yyvsp[-2].addr, sizeof(struct in6_addr));
		}
    break;

  case 50:
#line 403 "gram.y"
    {
			prefix->AdvOnLinkFlag = yyvsp[-1].bool;
		}
    break;

  case 51:
#line 407 "gram.y"
    {
			prefix->AdvAutonomousFlag = yyvsp[-1].bool;
		}
    break;

  case 52:
#line 411 "gram.y"
    {
			prefix->AdvRouterAddr = yyvsp[-1].bool;
		}
    break;

  case 53:
#line 415 "gram.y"
    {
			prefix->AdvValidLifetime = yyvsp[-1].num;
		}
    break;

  case 54:
#line 419 "gram.y"
    {
			prefix->AdvPreferredLifetime = yyvsp[-1].num;
		}
    break;

  case 55:
#line 423 "gram.y"
    {
			dlog(LOG_DEBUG, 4, "using interface %s for 6to4", yyvsp[-1].str);
			strncpy(prefix->if6to4, yyvsp[-1].str, IFNAMSIZ-1);
			prefix->if6to4[IFNAMSIZ-1] = '\0';
		}
    break;

  case 56:
#line 431 "gram.y"
    {
			yyval.rinfo = yyvsp[0].rinfo;
		}
    break;

  case 57:
#line 435 "gram.y"
    {
			yyvsp[0].rinfo->next = yyvsp[-1].rinfo;
			yyval.rinfo = yyvsp[0].rinfo;
		}
    break;

  case 58:
#line 442 "gram.y"
    {
			yyval.rinfo = route;
			route = NULL;
		}
    break;

  case 59:
#line 450 "gram.y"
    {
			route = malloc(sizeof(struct AdvRoute));
			
			if (route == NULL) {
				flog(LOG_CRIT, "malloc failed: %s", strerror(errno));
				ABORT;
			}

			route_init_defaults(route, iface);

			if (yyvsp[0].num > MAX_PrefixLen)
			{
				flog(LOG_ERR, "invalid route prefix length in %s, line %d", conf_file, num_lines);
				ABORT;
			}

			route->PrefixLen = yyvsp[0].num;

			memcpy(&route->Prefix, yyvsp[-2].addr, sizeof(struct in6_addr));
		}
    break;

  case 64:
#line 483 "gram.y"
    {
			route->AdvRoutePreference = yyvsp[-1].snum;
		}
    break;

  case 65:
#line 487 "gram.y"
    {
			route->AdvRouteLifetime = yyvsp[-1].num;
		}
    break;

  case 66:
#line 493 "gram.y"
    {
			yyval.rdnssinfo = yyvsp[0].rdnssinfo;
		}
    break;

  case 67:
#line 497 "gram.y"
    {
			yyvsp[0].rdnssinfo->next = yyvsp[-1].rdnssinfo;
			yyval.rdnssinfo = yyvsp[0].rdnssinfo;
		}
    break;

  case 68:
#line 504 "gram.y"
    {
			yyval.rdnssinfo = rdnss;
			rdnss = NULL;
		}
    break;

  case 71:
#line 515 "gram.y"
    {
			if (!rdnss) {
				/* first IP found */
				rdnss = malloc(sizeof(struct AdvRDNSS));
				
				if (rdnss == NULL) {
					flog(LOG_CRIT, "malloc failed: %s", strerror(errno));
					ABORT;
				}

				rdnss_init_defaults(rdnss, iface);
			}
			
			switch (rdnss->AdvRDNSSNumber) {
				case 0:
					memcpy(&rdnss->AdvRDNSSAddr1, yyvsp[0].addr, sizeof(struct in6_addr));
					rdnss->AdvRDNSSNumber++;
					break;
				case 1:
					memcpy(&rdnss->AdvRDNSSAddr2, yyvsp[0].addr, sizeof(struct in6_addr));
					rdnss->AdvRDNSSNumber++;
					break;
				case 2:
					memcpy(&rdnss->AdvRDNSSAddr3, yyvsp[0].addr, sizeof(struct in6_addr));
					rdnss->AdvRDNSSNumber++;
					break;
				default:
					flog(LOG_CRIT, "Too many addresses in RDNSS section");
					ABORT;
			}
			
		}
    break;

  case 72:
#line 550 "gram.y"
    {
			if (!rdnss) {
				flog(LOG_CRIT, "No address specified in RDNSS section");
				ABORT;
			}
		}
    break;

  case 77:
#line 568 "gram.y"
    {
			rdnss->AdvRDNSSPreference = yyvsp[-1].num;
		}
    break;

  case 78:
#line 572 "gram.y"
    {
			rdnss->AdvRDNSSOpenFlag = yyvsp[-1].bool;
		}
    break;

  case 79:
#line 576 "gram.y"
    {
			if (yyvsp[-1].num < iface->MaxRtrAdvInterval && yyvsp[-1].num != 0) {
				flog(LOG_ERR, "AdvRDNSSLifetime must be at least MaxRtrAdvInterval");
				ABORT;
			}
			if (yyvsp[-1].num > 2*(iface->MaxRtrAdvInterval))
				flog(LOG_WARNING, "Warning: AdvRDNSSLifetime <= 2*MaxRtrAdvInterval would allow stale DNS servers to be deleted faster");

			rdnss->AdvRDNSSLifetime = yyvsp[-1].num;
		}
    break;

  case 80:
#line 589 "gram.y"
    {
                                yyval.num = yyvsp[0].num; 
                        }
    break;

  case 81:
#line 593 "gram.y"
    {
                                yyval.num = (uint32_t)~0;
                        }
    break;


    }

/* Line 1000 of yacc.c.  */
#line 1820 "y.tab.c"

  yyvsp -= yylen;
  yyssp -= yylen;


  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (YYPACT_NINF < yyn && yyn < YYLAST)
	{
	  YYSIZE_T yysize = 0;
	  int yytype = YYTRANSLATE (yychar);
	  const char* yyprefix;
	  char *yymsg;
	  int yyx;

	  /* Start YYX at -YYN if negative to avoid negative indexes in
	     YYCHECK.  */
	  int yyxbegin = yyn < 0 ? -yyn : 0;

	  /* Stay within bounds of both yycheck and yytname.  */
	  int yychecklim = YYLAST - yyn;
	  int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
	  int yycount = 0;

	  yyprefix = ", expecting ";
	  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	      {
		yysize += yystrlen (yyprefix) + yystrlen (yytname [yyx]);
		yycount += 1;
		if (yycount == 5)
		  {
		    yysize = 0;
		    break;
		  }
	      }
	  yysize += (sizeof ("syntax error, unexpected ")
		     + yystrlen (yytname[yytype]));
	  yymsg = (char *) YYSTACK_ALLOC (yysize);
	  if (yymsg != 0)
	    {
	      char *yyp = yystpcpy (yymsg, "syntax error, unexpected ");
	      yyp = yystpcpy (yyp, yytname[yytype]);

	      if (yycount < 5)
		{
		  yyprefix = ", expecting ";
		  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
		    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
		      {
			yyp = yystpcpy (yyp, yyprefix);
			yyp = yystpcpy (yyp, yytname[yyx]);
			yyprefix = " or ";
		      }
		}
	      yyerror (yymsg);
	      YYSTACK_FREE (yymsg);
	    }
	  else
	    yyerror ("syntax error; also virtual memory exhausted");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror ("syntax error");
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* If at end of input, pop the error token,
	     then the rest of the stack, then return failure.  */
	  if (yychar == YYEOF)
	     for (;;)
	       {
		 YYPOPSTACK;
		 if (yyssp == yyss)
		   YYABORT;
		 YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
		 yydestruct (yystos[*yyssp], yyvsp);
	       }
        }
      else
	{
	  YYDSYMPRINTF ("Error: discarding", yytoken, &yylval, &yylloc);
	  yydestruct (yytoken, &yylval);
	  yychar = YYEMPTY;

	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

#ifdef __GNUC__
  /* Pacify GCC when the user code never invokes YYERROR and the label
     yyerrorlab therefore never appears in user code.  */
  if (0)
     goto yyerrorlab;
#endif

  yyvsp -= yylen;
  yyssp -= yylen;
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
      yydestruct (yystos[yystate], yyvsp);
      YYPOPSTACK;
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  YYDPRINTF ((stderr, "Shifting error token, "));

  *++yyvsp = yylval;


  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*----------------------------------------------.
| yyoverflowlab -- parser overflow comes here.  |
`----------------------------------------------*/
yyoverflowlab:
  yyerror ("parser stack overflow");
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  return yyresult;
}


#line 598 "gram.y"


static
void cleanup(void)
{
	if (iface)
		free(iface);
	
	if (prefix)
		free(prefix);

	if (route)
		free(route);

	if (rdnss)
		free(rdnss);
}

static void
yyerror(char *msg)
{
	cleanup();
	flog(LOG_ERR, "%s in %s, line %d: %s", msg, conf_file, num_lines, yytext);
}

