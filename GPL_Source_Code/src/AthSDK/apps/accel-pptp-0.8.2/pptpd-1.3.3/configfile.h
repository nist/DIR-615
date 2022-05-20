/*
 * configfile.h
 *
 * Function to read pptpd config file.
 *
 * $Id: configfile.h,v 1.1 2009/03/19 11:45:10 Eric_Kuo Exp $
 */

#ifndef _PPTPD_CONFIGFILE_H
#define _PPTPD_CONFIGFILE_H

int read_config_file(char *filename, char *keyword, char *value);

#endif	/* !_PPTPD_CONFIGFILE_H */
