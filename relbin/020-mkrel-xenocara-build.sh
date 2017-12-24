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

RELEASEDIR=$RELPART/r1
export RELEASEDIR

if [ ! -d $RELEASEDIR ];
then
	mkdir -p $RELEASEDIR
	chown build $RELEASEDIR
fi

DESTDIR=/rel/dx
export DESTDIR

if [ ! -d $DESTDIR ];
then
	mkdir -p $DESTDIR
	chown build $DESTDIR
fi

cd /usr/xenocara && make release
echo mkrel: release status $?

cd /usr/xenocara && make checkdist
echo mkrel: checkdist status $?
	   
unset DESTDIR
unset RELEASEDIR 

exit 0
