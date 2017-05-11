#!/bin/sh

set -euo pipefail

# https://github.com/matryer/bitbar#writing-plugins

conflicts=$(find ~/Dropbox -iname '*conflicted*')
count=$(echo "$conflicts" | wc -l)

if [ "$count" -gt "0" ]; then
    echo "${count}|color=red"
    echo "---"
    echo "${conflicts//$HOME/~}"
else
    echo "${count}"
fi
