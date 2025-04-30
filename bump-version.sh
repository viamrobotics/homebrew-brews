#!/bin/bash

FORMULA=$1

if [ -z $FORMULA ]
then
	echo "Formula name missing or invalid"
	exit 1
fi

CHECK=$(brew bump $FORMULA)
CUR_VERSION=$(echo "$CHECK" | grep Current | awk '{print $4}')
NEW_VERSION=$(echo "$CHECK" | grep livecheck | awk '{print $4}')

echo -e "$CHECK"

if [ $CUR_VERSION = $NEW_VERSION ]
then
	exit 0
fi

# note: --write-only flag here means that it doesn't open a PR
brew bump-formula-pr --write-only --version $NEW_VERSION --no-fork --no-audit $FORMULA
