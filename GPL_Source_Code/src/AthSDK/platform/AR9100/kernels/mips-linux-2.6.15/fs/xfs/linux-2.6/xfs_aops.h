/*
 * Copyright (c) 2005 Silicon Graphics, Inc.
 * All Rights Reserved.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it would be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write the Free Software Foundation,
 * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
#ifndef __XFS_AOPS_H__
#define __XFS_AOPS_H__

extern struct workqueue_struct *xfsdatad_workqueue;
extern mempool_t *xfs_ioend_pool;

typedef void (*xfs_ioend_func_t)(void *);

typedef struct xfs_ioend {
	unsigned int		io_uptodate;	/* I/O status register */
	atomic_t		io_remaining;	/* hold count */
	struct vnode		*io_vnode;	/* file being written to */
	struct buffer_head	*io_buffer_head;/* buffer linked list head */
	size_t			io_size;	/* size of the extent */
	xfs_off_t		io_offset;	/* offset in the file */
	struct work_struct	io_work;	/* xfsdatad work queue */
} xfs_ioend_t;

#endif /* __XFS_IOPS_H__ */
