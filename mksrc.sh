#!/bin/sh
#------------------------------------------------------------------------------
#
# Copyright (c) 2017 Dinesh Thirumurthy <dinesh.thirumurthy@gmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#------------------------------------------------------------------------------
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
