#!/bin/sh
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }


REPOSITORY=$(whiptail --title "Choose repository" --inputbox "From where should java should be downloaded ?" 10 60 http://example.com/yum/ 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    printf "REPOSITORY is : $REPOSITORY\n"
else
    die "aborting to user choice"
fi

ARCHIVE=$(whiptail --title "Choose Java version" --inputbox "What java archive should be downloaded ?" 10 60 jre-8u161-linux-x64.tar.gz 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    printf "ARCHIVE is : $ARCHIVE\n"
else
    die "aborting to user choice"
fi

sh download_java.sh ${REPOSITORY} ${ARCHIVE}
