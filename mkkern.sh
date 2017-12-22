#!/bin/sh
PROGRAM="mkkern.sh"
P=$PROGRAM
SKIP=
MACHINE=`machine`
KERNELS="GENERIC"
NCPU=`/sbin/sysctl -n hw.ncpufound`
if [ $NCPU -eq 1 ]; then
	echo "$P: only $NCPU cpu, so no mp kernel"
fi
if [ $NCPU -gt 1 ]; then
	echo "$P: $NCPU cpus, so need mp kernel"
	KERNELS="${KERNELS} GENERIC.MP"
fi
echo "$P: kernels needed are ${KERNELS}"
for KERNEL in $KERNELS
do
	echo "$P: will build kernel $KERNEL"
	DIR=/sys/arch/${MACHINE}/compile/$KERNEL

	if [ "$SKIP" != "echo" ]; then
		ID=`/usr/bin/id -u`
		if [ $ID -ne 0 ]; then
			echo "$P: error: run as root"
			exit 1
		fi
	fi

	echo "Build Kernel ${KERNEL} ##HAKR##"
	echo "\ncd $DIR ##HAKR##"		&& ${SKIP} cd $DIR && \
	  echo "\n$P: ${KERNEL}: make obj ##HAKR##"	&& ${SKIP} make obj && \
	  echo "\n$P: ${KERNEL}: make config ##HAKR##"	&& ${SKIP} make config && \
	  echo "\n$P: ${KERNEL}: make ##HAKR##"		&& ${SKIP} make && \
	  echo "\n$P: ${KERNEL}: make install ##HAKR##"	&& ${SKIP} make install 

done
exit 0
