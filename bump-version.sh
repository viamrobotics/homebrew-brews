#!/bin/bash

FORMULA=$1

if [ -z "$FORMULA" ]
then
	echo "Formula name missing or invalid"
	exit 1
fi

CHECK=$(brew bump $FORMULA)
CUR_VERSION=$(echo "$CHECK" | grep "Current formula version" | awk '{print $4}')
NEW_VERSION=$(echo "$CHECK" | grep "livecheck version" | awk '{print $4}')

echo -e "$CHECK"

if [ "$CUR_VERSION" = "$NEW_VERSION" ]
then
	exit 0
fi

# note: --write-only flag here means that it doesn't open a PR
# --no-audit: skip brew audit (rubocop) which fails on the pinned container;
# formulas are validated during the bottle step anyway
brew bump-formula-pr --write-only --no-audit --version "$NEW_VERSION" "$FORMULA"
