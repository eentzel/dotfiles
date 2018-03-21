#!/bin/sh

set -eu

usage () {
    echo "Usage: in-repo.sh <repo> <refspec> <cmd> [<args>...]"
    echo "  Executes <cmd> in the context of a git checkout of <repo> at <refspec>"
    exit 64
}

clone_cd () {
    local REPONAME=${REPO##*/}
    local DIR=${REPONAME%.git}
    if [ -d "$DIR/.git" ]; then
        cd "$DIR"
        git fetch "$REPO"
    else
        git clone "$REPO"
        cd "$DIR"
    fi
}

main () {
    [ "$#" -ge 3 ] || usage
    local REPO=$1
    local REF=$2
    local CMD=$3
    shift; shift; shift
    clone_cd
    git checkout "$REF"
    exec "$CMD" "$@"
}

main "$@"
