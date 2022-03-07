gw () {
    git lol -${1:-8}; git number
}

alias ee='emacsclient -n'
alias et='emacsclient -t'
alias gn='git number'
alias gne="git number -c 'emacsclient -n'"
alias nonascii='grep --color="auto" -P -n "[\x80-\xFF]"'
alias pcli=". ~/3rdparty/pcli/bin/activate"

passphrase () {
    < /usr/share/dict/words awk 'BEGIN {srand()} !/^$/ { if (rand() <= .00005) print $0}' | sort --random-sort
}
