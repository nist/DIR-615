/*
 * $Id: radlogin.h,v 1.1 2008/12/15 07:02:37 peter_pan Exp $
 *
 * Copyright (C) 1996 Lars Fenneberg
 *
 * See the file COPYRIGHT for the respective terms and conditions.
 * If the file is missing contact me at lf@elemental.net
 * and I'll send you a copy.
 *
 */

#ifndef RADLOGIN_H
#define RADLOGIN_H

typedef void (*LFUNC)(rc_handle *, char *);

/* radius.c */
LFUNC auth_radius(rc_handle *, uint32_t, char *, char *);
void radius_login(rc_handle *, char *);

/* local.c */
LFUNC auth_local(char *, char *);
void local_login(rc_handle *, char *);

#endif /* RADLOGIN_H */
