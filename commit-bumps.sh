#!/bin/bash
# `commit-bumps.sh formula...` commits version bumps. A named formula's bump goes to branch
# auto-bump/$GITHUB_RUN_ID/<formula>, which upload.yml lands with its bottle; others go to HEAD.

set -eu

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

HELD=$(mktemp -d)
STAGED=""
for formula in "$@"
do
	if ! git diff --quiet -- "Formula/$formula.rb"
	then
		cp "Formula/$formula.rb" "$HELD/"
		git checkout -- "Formula/$formula.rb"
		STAGED="$STAGED $formula"
	fi
done

if ! git diff --quiet -- Formula
then
	git commit --quiet -m "Auto-update of package versions" -- Formula
	git push --quiet origin HEAD
fi

BASE=$(git rev-parse HEAD)
for formula in $STAGED
do
	# a new staged bump supersedes the branches earlier failed runs left for this formula
	git ls-remote --heads origin "auto-bump/*/$formula" | while read -r _ ref
	do
		git push --quiet origin --delete "$ref" || true
	done

	branch="auto-bump/$GITHUB_RUN_ID/$formula"
	git checkout --quiet -B "$branch" "$BASE"
	cp "$HELD/$formula.rb" Formula/
	git commit --quiet -m "Auto-update of $formula" -- "Formula/$formula.rb"
	git push --quiet origin "HEAD:refs/heads/$branch"
done
