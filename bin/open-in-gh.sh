#!/bin/sh

set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $(basename "$0") filePath lineNumber"
    echo "Opens the given file in GitHub's web UI"
    exit 64;
fi

find_git_root () {
    DIR=$1
    while [ "$DIR" != "" ]; do
        DIR=${DIR%/*}
        [ -d "${DIR}/.git" ] && break
    done
    echo "$DIR"
}

die () {
    echo "$2"; exit $1
}

main () {
    FILEPATH=$1
    LN=$2
    DIR="$(find_git_root $FILEPATH)"
    [ "$DIR" == "" ] && die 65 "$FILEPATH does not appear to be in a git repository"

    cd $DIR
    ORIGIN="$(git config --get remote.origin.url)"
    [ "${ORIGIN#*github}" == "$ORIGIN" ] && die 65 "Git URL for 'origin' ($ORIGIN) does not appear to be GitHub"
    PROJ_URL="$(echo $ORIGIN | sed 's,^git@github.com:,https://github.com/,' | sed 's,^git@github.mlbam.net:,https://github.mlbam.net/,' | sed 's,.git$,,')"
    URL="${PROJ_URL}/blob/$(git rev-parse HEAD)${FILEPATH##$DIR}#L${LN}"
    open "$URL"
}

main "$@"
