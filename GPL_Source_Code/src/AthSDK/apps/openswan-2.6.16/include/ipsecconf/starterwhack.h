/* FreeS/WAN whack functions to communicate with pluto (whack.h)
 * Copyright (C) 2001-2002 Mathieu Lafon - Arkoon Network Security
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * RCSID $Id: starterwhack.h,v 1.1 2008/10/01 02:06:37 ken_chiang Exp $
 */

#ifndef _STARTER_WHACK_H_
#define _STARTER_WHACK_H_

struct starter_conn;
struct starter_config;

int starter_whack_add_conn (struct starter_config *cfg, struct starter_conn *conn);
int starter_whack_del_conn (struct starter_config *cfg, struct starter_conn *conn);
int starter_whack_route_conn (struct starter_config *cfg, struct starter_conn *conn);
int starter_whack_initiate_conn (struct starter_config *cfg, struct starter_conn *conn);
int starter_whack_listen (struct starter_config *cfg);
int starter_whack_shutdown (struct starter_config *cfg);

extern int starter_permutate_conns(int (*operation)(struct starter_config *cfg
						    , struct starter_conn *conn)
				   , struct starter_config *cfg
				   , struct starter_conn *conn);


#endif /* _STARTER_WHACK_H_ */

