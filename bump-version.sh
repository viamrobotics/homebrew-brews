#!/bin/bash -x

FORMULA=$1

if [ -z $FORMULA ]
then
	echo "Formula name missing or invalid"
	exit 1
fi

CHECK=$(brew bump $FORMULA)
CUR_VERSION=$(echo "$CHECK" | grep Current | awk '{print $4}')
NEW_VERSION=$(echo "$CHECK" | grep livecheck | awk '{print $4}')

if [ $CUR_VERSION = $NEW_VERSION ]
then
	exit 0
fi

brew bump-formula-pr --write-only --version $NEW_VERSION $FORMULA
