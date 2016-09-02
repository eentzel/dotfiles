# Other env vars needed by GUI apps are set in ~/.MacOSX/environment.plist

# TODO: https://github.com/joelthelion/autojump/wiki

if [ -f ~/.bashrc_local ]; then
   source ~/.bashrc_local
fi

if [ -f ~/.bashrc_private ]; then
   source ~/.bashrc_private
fi

source ~/.colors.sh

export PATH=~/bin:$PATH
export PATH=~/bin/SmallerMaker:$PATH
export PATH=/Applications/Emacs.app/Contents/MacOS/bin:$PATH

export EDITOR="emacsclient -t"
export SVN_EDITOR=emacsclient

export MANPATH=$MANPATH:/usr/local/man

# for node.js
export PATH=$PATH:/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

# for mysql
if [ -d /usr/local/mysql ]; then
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib
    export PATH=/usr/local/mysql/bin:$PATH
fi

if [ -f ~/.opam/opam-init/init.sh ]; then
    . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null
fi

# for golang
export GOPATH=$HOME/mygo
export PATH=$PATH:$HOME/mygo/bin

if [ -d ~/3rdparty/packer ]; then
    export PATH=$PATH:~/3rdparty/packer
fi

if [ -d ~/3rdparty/go_appengine ]; then
    export PATH=$PATH:~/3rdparty/go_appengine
fi

 # added by Nix installer
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh;
    export NIX_PATH=~/3rdparty/nixpkgs
fi

function java_version() {
    java -version 2>&1 | grep "java version" | grep -o  "1\.[0-9]\.[0-9_]*"
}

__ecp () {
    local EXIT="$?"
    if [ $EXIT -ne 0 ]; then
        echo "($EXIT) "
    fi
}

if [ $EMACS ]; then
    # when running a shell inside emacs, pager just gets in the way
    export PAGER=cat

    # as do colored prompts
    export PS1="\u@\h:\w\$(__git_ps1)\$ "
else
    export PS1="\[\033]0;\w\007\]\[$txtred\]\$(__ecp)\[$txtrst\]\h:\[$txtylw\]\w\[$txtcyn\]\$(__git_ps1)\[$txtrst\] (\$(java_version))\$ "
fi

# Setting PATH for MacPython 2.6
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
export PATH
source ~/.git-completion.bash

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi

export AWS_CONFIG_FILE=~/.aws-creds
if which aws_completer > /dev/null && which aws > /dev/null ; then
    complete -C aws_completer aws
fi

# TODO: CDPATH (http://caliban.org/bash/)

shopt -s histappend
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=100000

# rbenv
if [ -d ~/.rbenv/bin ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

if [ -z `which wget` ]; then
    alias wget="echo \"wget is not intalled - faking it with 'curl -o'...\" && curl -LO"
fi

# locate source for a Python module
# from: http://chris-lamb.co.uk/2010/04/22/locating-source-any-python-module/
cdp () {
  pushd "$(python -c "import os.path as _, ${1}; \
    print _.dirname(_.realpath(${1}.__file__[:-1]))"
  )"
}

# Copy IP address of the specified interface to the OSX clipboard
copyip () {
    addr=`ifconfig $1 inet | awk '/inet/ {print $2}'`
    echo -n $addr | pbcopy
}

# start a basic webserver in the current directory
server() {
  open "http://localhost:${1}" && nohup python -m SimpleHTTPServer $1 &
}

gw () {
    git lol -${1:-8}; git number
}

alias ll='ls -lhF'
alias ee='emacsclient -n'
alias gn='git number'
alias gne="git number -c 'emacsclient -n'"
alias be='bundle exec'
alias nonascii='grep --color="auto" -P -n "[\x80-\xFF]"'
