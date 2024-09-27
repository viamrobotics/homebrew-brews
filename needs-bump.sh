#!/bin/bash
# `needs-bump.sh formula` outputs 'true' if `formula` needs updating, otherwise 'false'

set -eu

FORMULA=${1-}

if [ -z $FORMULA ]
then
	echo "Formula name missing or invalid"
	exit 1
fi

CHECK=$(brew bump --no-fork --no-pull-requests $FORMULA)
CUR_VERSION=$(echo "$CHECK" | grep Current | awk '{print $4}')
NEW_VERSION=$(echo "$CHECK" | grep livecheck | awk '{print $4}')

if [ $CUR_VERSION = $NEW_VERSION ]
then
	echo "false"
else
	echo "true"
fi
