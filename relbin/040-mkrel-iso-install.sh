#!/bin/sh -x
#------------------------------------------------------------------------------
#
# Copyright (c) 2017 Dinesh Thirumurthy <dinesh.thirumurthy@gmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#------------------------------------------------------------------------------
RELPART=/rel
mount -u -o noperm $RELPART

RELDIR=$RELPART/r1
SRCPATH=/usr/src
ISOFILE=install62.iso
ISOPATH=$RELDIR/$ISOFILE

if [ ! -d $RELDIR ];
then
	echo mkrel error: missing $RELDIR
	exit 1
fi

if [ ! -d $SRCPATH ];
then
	echo mkrel error: missing $SRCPATH
	exit 1
fi

if [ ! -f $ISOPATH ];
then
	echo mkrel error: missing $ISOPATH
	exit 1
fi

# get back to build ownership of source
chown -R build:wsrc $SRCPATH

# copy new iso from release path to source
cp -f $ISOPATH $SRCPATH/$ISOFILE

# make it readable
chmod +r $SRCPATH/$ISOFILE 

# get back to build ownership of new iso
chown build:wsrc $SRCPATH/$ISOFILE 

exit 0
