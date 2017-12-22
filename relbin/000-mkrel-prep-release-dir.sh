#!/bin/sh -x
SRCDIR=/usr/src
RELPART=/rel
mount -u -o noperm $RELPART

chown build $RELPART
chmod 700   $RELPART

RELEASEDIR=$RELPART/r1
DESTDIR=$RELPART/d1

export RELEASEDIR
export DESTDIR

rm -rf $RELEASEDIR
rm -rf $DESTDIR

unset RELEASEDIR
unset DESTDIR
unset SRCDIR

exit 0
