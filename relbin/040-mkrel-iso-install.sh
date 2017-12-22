#!/bin/sh -x
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
