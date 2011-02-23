# Other env vars needed by GUI apps are set in ~/.MacOSX/environment.plist

if [ -f ~/.bashrc_local ]; then
   source ~/.bashrc_local
fi

export PATH=/opt/local/bin:/opt/local/sbin:~/bin:$PATH
export PATH=~/bin/SmallerMaker:$PATH
export PATH=$PATH:/opt/local/lib/postgresql83/bin
export MANPATH=$MANPATH:/opt/local/share/man
export PS1="\[\033]0;\w\007\]\h:\W \u\$ "
export LC_CTYPE=en_US.UTF-8
export EDITOR="emacsclient -n"
export SVN_EDITOR=emacsclient

# Setting PATH for MacPython 2.6
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
export PATH
source ~/.git-completion.bash

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
  cd "$(python -c "import os.path as _, ${1}; \
    print _.dirname(_.realpath(${1}.__file__[:-1]))"
  )"
}

