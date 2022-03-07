#!/bin/sh

suffix="$(hostname | cut -d. -f1)"
sourcefile="${HOME}/bin/screen.${suffix}.sh"

[ -f "$sourcefile" ] && exec "$sourcefile"
