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
export PS1="\[\033]0;\w\007\]\u@\h:\[$txtred\]\w \[$txtgrn\]\$(parse_git_branch)\[$txtrst\]\$ "

export LC_CTYPE=en_US.UTF-8
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

