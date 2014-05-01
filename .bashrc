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
export PATH=/usr/local/mysql/bin:$PATH

export EDITOR="emacsclient -t"
export SVN_EDITOR=emacsclient

# for node.js
export PATH=$PATH:/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

# for golang
export GOPATH=$HOME/mygo
export PATH=$PATH:$HOME/mygo/bin

if [ $EMACS ]; then
    # when running a shell inside emacs, pager just gets in the way
    export PAGER=cat

    # as do colored prompts
    export PS1="\u@\h:\w\$(__git_ps1)\$ "
else
    export PS1="\[\033]0;\w\007\]\u@\h:\[$txtylw\]\w\[$txtcyn\]\$(__git_ps1)\[$txtrst\]\$ "
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
if which -s aws_completer && which -s aws; then
    complete -C aws_completer aws
fi

# TODO: CDPATH (http://caliban.org/bash/)

shopt -s histappend
export HISTTIMEFORMAT='%F %T '

# rbenv
if [ -f HOME/.rbenv/bin ]; then
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

alias ll='ls -lhF'
alias ee='emacsclient -n'
alias be='bundle exec'
alias json_pretty="python -mjson.tool"
alias nonascii='grep --color="auto" -P -n "[\x80-\xFF]"'
