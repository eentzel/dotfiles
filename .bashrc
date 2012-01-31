# Other env vars needed by GUI apps are set in ~/.MacOSX/environment.plist

if [ -f ~/.bashrc_local ]; then
   source ~/.bashrc_local
fi

function parse_git_branch {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo "("${ref#refs/heads/}")"
}

source ~/.colors.sh

export PATH=~/bin:$PATH
export PATH=~/bin/SmallerMaker:$PATH
export PATH=/Applications/Emacs.app/Contents/MacOS/bin:$PATH
export PATH=$PATH:/usr/local/mysql/bin/
export PS1="\[\033]0;\w\007\]\u@\h:\[$txtylw\]\w \[$txtcyn\]\$(parse_git_branch)\[$txtrst\]\$ "

export EDITOR="emacsclient -n"
export SVN_EDITOR=emacsclient

# Setting PATH for MacPython 2.6
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
export PATH
source ~/.git-completion.bash

# TODO: CDPATH (http://caliban.org/bash/)

shopt -s histappend

if [ -z `which wget` ]; then
    wget () {
        echo "wget is not intalled - faking it with 'curl -o'..."
        filename=`echo $1 | awk -F / '{print $NF}'`
        curl $1 -o $filename
    }
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
    addr=`ifconfig $1 inet | grep inet | awk '{print $2}'`
    echo -n $addr | pbcopy
}

# start a basic webserver in the current directory
server() {
  open "http://localhost:${1}" && python -m SimpleHTTPServer $1
}

alias json_pretty="python -mjson.tool"
