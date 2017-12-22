#!/bin/sh -x
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
