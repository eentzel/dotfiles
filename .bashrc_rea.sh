# Gradle
export GRADLE_HOME=~/3rdparty/gradle
export GRADLE_OPTS='-Dorg.gradle.daemon=true -Xmx512M -XX:MaxPermSize=256M'
export PATH=${GRADLE_HOME}/bin:${PATH}

# Tomcat
export CATALINA_HOME=~/3rdparty/apache-tomcat-6.0.32

# Tomcat aliases
alias tc='cd ${CATALINA_HOME}'
alias tcc='rm -rf ${CATALINA_HOME}/webapps/*DS*'
alias tcl='cd ${CATALINA_HOME}/logs'
alias tcs='rm -rf $CATALINA_HOME/work; $CATALINA_HOME/bin/startup.sh'
alias tcx='$CATALINA_HOME/bin/shutdown.sh'
alias tct='tail -f ${CATALINA_HOME}/logs/catalina.out'
alias tcw='cd ${CATALINA_HOME}/webapps'

# Cucmber
export TEST_ENV=dev
alias bec='bundle exec cucumber'

# JSHint
alias jshint=/Users/eric_entzel/3rdparty/jshint/env/jsc.sh

# RVM
[[ -s "/Users/eric_entzel/.rvm/scripts/rvm" ]] && source "/Users/eric_entzel/.rvm/scripts/rvm"

# Print the N highest (default 20) listing ids from test fixtures in ascending order
nextid () {
    limit=${1:-30}
    grep -r listing_id: fixtures/test-data/ | awk "{print \$3}" | sort -n | tail -n $limit
}
