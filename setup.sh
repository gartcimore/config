#!/bin/bash

export BUILD_PATH=/tmp/build
export RESULT_PATH=/tmp/build
export ANT_HOME=${UCS8}/tools/ant/

export PATH=${ANT_HOME}/bin:$PATH

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
: ${UCS8:="${DIR}]"}

# https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
case "$OSTYPE" in
  linux*)   echo "Linux / WSL" ;;
  darwin*)  export JAVA_HOME="$(/usr/libexec/java_home)" ;;
  #win*)     echo "Windows" ;;
  #msys*)    echo "MSYS / MinGW / Git Bash" ;;
  #cygwin*)  echo "Cygwin" ;;
  #bsd*)     echo "BSD" ;;
  #solaris*) echo "Solaris" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac


ucs8 () {
  cd ${UCS8}
}

build8 () {
  ${UCS8}/gradlew build --info
}

test8 () {
  ${UCS8}/gradlew test --info
}

build8notest () {
  ${UCS8}/gradlew build -x test --info
}

rundb () {
  pushd .
  cd ${UCS8}/devops/docker_env/ucs-db
  sudo sh -c 'echo "127.0.0.1  database.docker database" >> /etc/hosts'
  docker-compose up -d
  sleep 5
  docker-compose exec ucsdb runuser -l postgres -c psql
  popd
}

stopdb () {

  pushd .
  cd ${UCS8}/devops/docker_env/ucs-db
  sudo sed -i".bak" "/database.docker/d" /etc/hosts
  docker-compose down
  sleep 5
  popd
}
# EXPORT CLASSPATH=%ICCVIEW%\tools\junit\junit.jar;%ICCVIEW%\tools\antlr\antlr-compile.jar

#export ANT_ARGS="-logger org.apache.tools.ant.NoBannerLogger"
#export ANT_OPTS="${ANT_OPTS} -Dresult.path=${BUILD_PATH} -Droot.path=${UCS8}"
${UCS8}/gradlew tasks
