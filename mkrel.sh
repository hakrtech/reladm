#!/bin/sh -x
SRCROOT=/usr/src
RELBINROOT=/usr/reladm/relbin
LOGROOT="/tmp/rellog"
TMPFILEPATH="${LOGROOT}/tmpfile.txt"
mkdir -p ${LOGROOT}

runlog() { 
	STEP=$1
	CMD=$2
	PREFIX=`date "+%Y%m%d-%H%M%S"`
	SUFFIX="mkrel-${STEP}.txt"
	LOGFILE="${PREFIX}.${SUFFIX}"
	LOGFILEPATH="${LOGROOT}/${LOGFILE}"
	SHELL="${CMD}" /bin/sh -c "script -a ${LOGFILEPATH}"
	/bin/rm -f "${TMPFILEPATH}"
	mv -f "${LOGFILEPATH}" "${TMPFILEPATH}"
	col -b < "${TMPFILEPATH}" > "${LOGFILEPATH}"
	/bin/rm -f "${TMPFILEPATH}"
	cp -f "${LOGFILEPATH}" "${LOGROOT}/${STEP}.txt"
}

runlog_000() {
	STEP=000; CMD="${RELBINROOT}/${STEP}-mkrel-prep-release-dir.sh"
	runlog $STEP $CMD
}

runlog_010() {
	STEP=010; CMD="${RELBINROOT}/${STEP}-mkrel-base-build.sh"
	runlog $STEP $CMD
}

runlog_020() { 
	STEP=020; CMD="${RELBINROOT}/${STEP}-mkrel-xenocara-build.sh"
	runlog $STEP $CMD
}

runlog_030() {
	STEP=030; CMD="${RELBINROOT}/${STEP}-mkrel-iso-build.sh"
	runlog $STEP $CMD
}

runlog_040() {
	STEP=040; CMD="${RELBINROOT}/${STEP}-mkrel-iso-install.sh"
	runlog $STEP $CMD
}

runlog_000
runlog_010
runlog_020
runlog_030
runlog_040
