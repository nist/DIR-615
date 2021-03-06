/*
 * ipaddress data access header
 *
 * $Id: ipaddress.h,v 1.1.1.1 2007/08/30 10:28:11 roy Exp $
 */
/**---------------------------------------------------------------------*/
/*
 * configure required files
 *
 * Notes:
 *
 * 1) prefer functionality over platform, where possible. If a method
 *    is available for multiple platforms, test that first. That way
 *    when a new platform is ported, it won't need a new test here.
 *
 * 2) don't do detail requirements here. If, for example,
 *    HPUX11 had different reuirements than other HPUX, that should
 *    be handled in the *_hpux.h header file.
 */
config_require(ip-mib/data_access/ipaddress_common)
#if defined( linux )
config_require(ip-mib/data_access/ipaddress_linux)
#else
/*
 * couldn't determine the correct file!
 * require a bogus file to generate an error.
 */
config_require(ip-mib/data_access/ipaddress-unknown-arch)
#endif

