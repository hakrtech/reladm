#!/bin/sh
PROGRAM="mksrc.sh"
P=$PROGRAM
UPSTREAM=`git remote -v|grep upstream|grep fetch|awk '{ print $2; }'`
if [ "$UPSTREAM" == "" ]; then
	echo "$P: error unable to handle empty upstream ($UPSTREAM)"
	echo "$P: correction adding upstream"
	git remote add upstream https://github.com/openbsd/src.git
	UPSTREAM=`git remote -v|grep upstream|grep fetch|awk '{ print $2; }'`
	echo "$P: new upstream is ($UPSTREAM)"
	exit 1
fi
if [ "$UPSTREAM" != "https://github.com/openbsd/src.git" ]; then
	echo "$P: error unable to handle upstream ($UPSTREAM)"
	exit 1
fi
echo "$P: upstream is $UPSTREAM"
echo $USER
echo doas chown -R $USER /usr/src
echo git stash
echo git fetch upstream
echo git merge upstream/master
exit 0
