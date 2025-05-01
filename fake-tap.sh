#!/usr/bin/env bash
# fake-tap.sh -- this symlinks the checkout directory to a tap in a fresh homebrew/brew docker image,
# and does other setup.

set -eux

CHECKOUT_DIR=${CHECKOUT_DIR:-$PWD}
# not sure homebrew specifies this in docs; I got by doing:
# `find $(brew --prefix) | grep viam-server.rb`
TAP_DIR=$(brew --prefix)/Homebrew/Library/Taps/viamrobotics

mkdir $TAP_DIR
ln -s $CHECKOUT_DIR $TAP_DIR/homebrew-brews
git config --global --add safe.directory '*'
git config --global url."https://github.com/".insteadOf git@github.com:
brew developer on
