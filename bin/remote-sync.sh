#!/bin/sh

# given a target host and directory,
# syncs all git modified files from the PWD
# to the specified directory

USER=$1
HOST=$2
if [[ $USER == "" || $HOST == "" ]] ; then
    echo "usage: `basename $0` user host"
    exit 1
fi
shift 2

LOCAL_DIR=`pwd`
REMOTE_DIR=$1
shift

SAFE_DIR=/Users/eentzel/Projects
if [[ $LOCAL_DIR != $SAFE_DIR/* ]] ; then
    echo "`basename $0`: not under $SAFE_DIR, won't sync"
    exit 1
fi

F=$(git status --untracked-files=no --porcelain | cut -d' ' -f3)
rsync --verbose --times --relative --exclude ".git" $F $USER@$HOST:$REMOTE_DIR
