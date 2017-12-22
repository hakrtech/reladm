#!/bin/sh -x
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
