#!/bin/sh
PROGRAM="mkxeno.sh"
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
SRCROOT=/usr/xenocara

# chown -R build /usr/xobj
# chown -R wobj  /usr/xobj
# cd /usr/xenocara
# make bootstrap
# make obj
# make build

# define FAST to invoke -j4 for realbuild target in /usr/xenocara/Makefile
FAST=1
export FAST
echo    "\n$P: chown -R build /usr/xobj #$MARK"	\
    && ${SKIP} chown -R build /usr/xobj \
    && echo "\n$P: chgrp -R wobj  /usr/xobj #$MARK" \
    && ${SKIP}     chgrp -R wobj /usr/xobj 

echo 	"\n$P: cd $SRCROOT #$MARK"		&& ${SKIP} cd ${SRCROOT} && \
   echo "\n$P: make bootstrap #$MARK"		&& ${SKIP} make bootstrap && \
   echo "\n$P: make obj #$MARK"			&& ${SKIP} make obj && \
   echo "\n$P: make build #$MARK"		&& ${SKIP} make build
exit 0
