/*
 * configfile.h
 *
 * Function to read pptpd config file.
 *
 * $Id: configfile.h,v 1.1 2008/11/13 03:13:07 peter_pan Exp $
 */

#ifndef _PPTPD_CONFIGFILE_H
#define _PPTPD_CONFIGFILE_H

int read_config_file(char *filename, char *keyword, char *value);

#endif	/* !_PPTPD_CONFIGFILE_H */
