#!/bin/sh

wmctrl -a emacs &&
emacsclient --eval "(org-capture nil \"t\")"
