#!/bin/bash
# xset.sh

ROOT_UID=0

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be root to execute this Script. Aborting."
	exit
else
	xset +fp /usr/share/fonts
	xset +fp /usr/share/fonts/local
fi

echo "FontsPaths are set."
