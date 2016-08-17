export JAVA6=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export JAVA7=/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home
export JAVA8=/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home

export GRADLE_HOME=~/3rdparty/gradle
export PATH=${PATH}:${GRADLE_HOME}/bin

export PATH=${PATH}:~/3rdparty/apache-cassandra-1.2.9/bin
export PATH=${PATH}:~/3rdparty/grails/bin
export PATH=${PATH}:~/3rdparty/groovy-2.1.6/bin

alias pcli=". ~/3rdparty/python-cli-env/bin/activate"

#AWS
export AWS_CREDENTIAL_FILE=~/.aws-creds-old-style
export AWS_AUTO_SCALING_HOME=~/3rdparty/AutoScaling-1.0.61.5
export AWS_ELB_HOME=~/3rdparty/ElasticLoadBalancing-1.0.34.0
export PATH=${PATH}:${AWS_AUTO_SCALING_HOME}/bin:${AWS_ELB_HOME}/bin

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

tail_pull () {
    nc sb-kibana.fullcontact.com 16384 \
        | jq -r 'select(.facility == "switchboard-pull") | "\(.["@timestamp"]) \(.["pullRequest.source"]) \(.message)"'
}

alias webapp="cd ~/Projects/addressbook-webapp"
alias legacy="cd ~/Projects/fullcontact-api"

alias coffee_time="rm -rf ~/.grails/.slcache && grails clean && grails -noreloading run-app"
