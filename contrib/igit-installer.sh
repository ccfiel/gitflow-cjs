#!/bin/bash

# git-flow make-less installer for *nix systems, by Rick Osborne
# Based on the git-flow core Makefile:
# http://github.com/petervanderdoes/gitflow-avh/blob/master/Makefile

# Licensed under the same restrictions as git-flow:
# http://github.com/CJ-Systems/gitflow-cjs/blob/develop/LICENSE

# Updated for the fork at CJ-Systems

usage() {
	echo "Usage: [environment] igit.sh [install|uninstall]"
	echo "Environment:"
	echo "   PREFIX=$PREFIX"
	echo "   REPO_HOME=$REPO_HOME"
	echo "   REPO_NAME=$REPO_NAME"
	exit 1
}

# Does this need to be smarter for each host OS?
if [ -z "$PREFIX" ] ; then
	PREFIX="/usr/local"
fi

if [ -z "$REPO_NAME" ] ; then
	REPO_NAME="igit"
fi

if [ -z "$REPO_HOME" ] ; then
	REPO_HOME="https://github.com/ccfiel/gitflow-cjs.git"
fi

EXEC_PREFIX="$PREFIX"
BINDIR="$EXEC_PREFIX/bin"
DATAROOTDIR="$PREFIX/share"
DOCDIR="$DATAROOTDIR/doc/gitflow"

EXEC_FILES="igit"
SCRIPT_FILES="git-flow-init git-flow-feature git-flow-bugfix git-flow-hotfix git-flow-release git-flow-stage git-flow-support git-flow-version gitflow-common gitflow-shFlags git-flow-config"
HOOK_FILES="$REPO_NAME/hooks/*"


echo "### igit no-make installer ###"

case "$1" in
uninstall)
	echo "Uninstalling igit from $PREFIX"
	if [ -d "$BINDIR" ] ; then
		for script_file in $SCRIPT_FILES $EXEC_FILES ; do
			echo "rm -vf $BINDIR/$script_file"
			rm -vf "$BINDIR/$script_file"
		done
		rm -rf "$DOCDIR"
	else
		echo "The '$BINDIR' directory was not found."
	fi
	exit
	;;
help)
	usage
	exit
	;;
install)
	echo "Installing igit to $BINDIR"
	if [ -d "$REPO_NAME" -a -d "$REPO_NAME/.git" ] ; then
		echo "Using existing repo: $REPO_NAME"
	else
		echo "Cloning repo from GitHub to $REPO_NAME"
		git clone "$REPO_HOME" "$REPO_NAME"
	fi
	cd "$REPO_NAME"
	git pull
	cd "$OLDPWD"

	cd "$REPO_NAME"
	git checkout develop
	cd "$OLDPWD"
	;;

	esac

	install -v -d -m 0755 "$PREFIX/bin"
	install -v -d -m 0755 "$DOCDIR/hooks"
	for exec_file in $EXEC_FILES ; do
		install -v -m 0755 "$REPO_NAME/$exec_file" "$BINDIR"
	done
	for script_file in $SCRIPT_FILES ; do
		install -v -m 0644 "$REPO_NAME/$script_file" "$BINDIR"
	done
	for hook_file in $HOOK_FILES ; do
		install -v -m 0644 "$hook_file"  "$DOCDIR/hooks"
	done
	exit
	;;
*)
	usage
	exit
	;;
esac
