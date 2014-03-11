export JAVA6=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export JAVA7=/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home

export GRADLE_HOME=~/3rdparty/gradle
export PATH=${PATH}:${GRADLE_HOME}/bin

export PATH=${PATH}:~/3rdparty/apache-cassandra-1.2.9/bin
export PATH=${PATH}:~/3rdparty/grails/bin
export PATH=${PATH}:~/3rdparty/groovy-2.1.6/bin

alias pcli=". ~/3rdparty/python-cli-env/bin/activate"

push_dashboard () {
    curl http://${1}:9090/watch?rows=$(tput lines)
}

post_contact () {
    curl -i -H "Content-type: application/json" -d @${1} \
        "https://api.fullcontact.com/v2/contactLists/${2}/?accessToken=${3}"
}

force_push () {
    curl -i -H "Content-type: application/json" -d @${1} \
        "https://api.fullcontact.com/v2/contactLists/${2}/_forcePushNewContacts?accessToken=${3}"
}

clean_sync () {
    curl -i -XPOST "https://switchboard.fullcontact.com/sb/resync/${1}?clean=true"
}
