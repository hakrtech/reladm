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
SRCDIR=/usr/src
RELPART=/rel

# /rel should be mounted with noperm option 
mount -u -o noperm $RELPART

RELEASEDIR=$RELPART/r1
DESTDIR=$RELPART/d1
export RELEASEDIR
export DESTDIR

if [ ! -d $RELEASEDIR ]; 
then
	mkdir -p $RELEASEDIR
	chown -R build $RELEASEDIR
fi

if [ ! -d DESTDIR ];
then
	mkdir -p $DESTDIR
	chown -R build $DESTDIR
fi

chown -R build $SRCDIR
cd $SRCDIR/etc && make release
echo status $?

cd $SRCDIR/distrib/sets && sh checkflist
echo status $?

unset RELEASEDIR
unset DESTDIR

exit 0
