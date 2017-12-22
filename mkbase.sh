#!/bin/sh
PROGRAM="mkbase.sh"
SKIP=echo
SKIP=
MARK="##HAKR##"
P=$PROGRAM
ID=`id -u`
if [ "${SKIP}" == "" ]; then
if [ $ID -ne 0 ]; then
	echo "$P: error: run as root"
	exit 1
fi
fi
SRCROOT=/usr/src
OBJROOT=/usr/obj

echo   "\n$P: chown -R build $OBJROOT #$MARK" 	&& ${SKIP} chown -R build ${OBJROOT} && \
  echo "\n$P: chgrp -R wobj  $OBJROOT #$MARK" 	&& ${SKIP} chgrp -R wobj  ${OBJROOT} && \
  echo "\n$P: chmod 770 /usr/obj #$MARK" 	&& ${SKIP} chmod 770 /usr/obj && \
  echo "\n$P: cd $SRCROOT #$MARK"		&& ${SKIP} cd ${SRCROOT} && \
  echo "\n$P: make obj #$MARK"			&& ${SKIP} make obj && \
  echo "\n$P: make build #$MARK"		&& ${SKIP} make build && \
  echo "\n$P: sysmerge #$MARK"			&& ${SKIP} sysmerge && \
  echo "\n$P: cd /dev && ./MAKEDEV all #$MARK"	&& ${SKIP} cd /dev && ${SKIP} /dev/MAKEDEV all
exit 0

