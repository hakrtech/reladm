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
P="mkports.sh"

ID=`/usr/bin/id -u`
if [ $ID -ne 0 ]; then
	echo "$P: error: run as root"
	exit 1
fi

if [ -f /usr/bin/dosa ]; then
	( grep -v SUDO= /etc/mk.conf; echo "SUDO=/usr/bin/dosa" ) | tee /etc/mk.conf
else
	( grep -v SUDO= /etc/mk.conf; echo "SUDO=/usr/bin/doas" ) | tee /etc/mk.conf
fi
echo /etc/mk.conf
cat -n /etc/mk.conf
echo ---

user mod -G wsrc $USER 
if [ $? -ne 0 ]; then
	echo "$P: user mod error for $USER"
	exit 1
fi

chgrp -R wsrc /usr/ports
if [ $? -ne 0 ]; then
	echo "$P: chgrp wsrc error"
	exit 1
fi

find /usr/ports -type d -print0 | xargs -0r chmod g+w
if [ $? -ne 0 ]; then
	echo "$P: recursive chmod g+w error"
	exit 1
fi

exit 0
