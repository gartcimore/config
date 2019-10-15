#!/bin/sh
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
REPOSITORY=$1
ARCHIVE=$2

DESTINATION=/usr/lib/jvm/
: ${REPOSITORY:="http://myrepository.com/yum/"}
: ${ARCHIVE:="jre-8u161-linux-x64.tar.gz"}

printf "downloading java ${ARCHIVE} from ${REPOSITORY} to /tmp/ \n"
try wget ${REPOSITORY}${ARCHIVE} -P /tmp/

if [ ! -d "$DESTINATION" ]; then
  mkdir -pv $DESTINATION
fi

printf "unpacking to $DESTINATION \n"
try tar xzvf /tmp/${ARCHIVE} -C $DESTINATION

printf "deleting downloaded archive \n"
try rm /tmp/${ARCHIVE}

