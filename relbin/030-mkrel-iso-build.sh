#!/bin/sh -x
RELPART=/rel
mount -u -o noperm $RELPART

RELDIR=$RELPART/r1
export RELDIR

if [ ! -d $RELDIR ];
then
	echo error: missing $RELDIR
fi
chown build $RELDIR

RELXDIR=/rel/r1
export RELXDIR

if [ ! -d $RELXDIR ];
then
	echo error: missing $RELXDIR
fi
chown build $RELXDIR

cd /usr/src/distrib/amd64/iso && make && make install

unset RELDIR
unset RELXDIR

exit 0
