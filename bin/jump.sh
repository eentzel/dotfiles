#!/bin/sh

wmctrl -a emacs &&
emacsclient --eval "(switch-to-buffer \"$1\")"
