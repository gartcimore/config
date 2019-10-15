#!/bin/sh
REMOTE_HOST=$1
REMOTE_USER=$2
REMOTE_PASS=$3

: ${REMOTE_HOST:="example.org"}
: ${REMOTE_USER:="me"}


if [ -z ${REMOTE_HOST+x} ]; then echo "REMOTE_HOST is unset"; exit 1
else printf "REMOTE_HOST is set to '$REMOTE_HOST'\n";
fi

printf "REMOTE USER: ${REMOTE_USER}\n"
printf "REMOTE HOST: ${REMOTE_HOST}\n"
printf "REMOTE PASS: ${REMOTE_PASS}\n"

echo "sshpass -p ${REMOTE_PASS} ssh ${REMOTE_USER}@${REMOTE_HOST} \"mkdir ~/${REMOTE_USER}\""
if ! sshpass -p ${REMOTE_PASS} ssh ${REMOTE_USER}@${REMOTE_HOST} "mkdir ~/${REMOTE_USER}"; then printf "could not create dir for user ${REMOTE_USER}\n"; exit; fi
printf "return code $?\n"

echo "sshpass -p ${REMOTE_PASS} ssh ${REMOTE_USER}@${REMOTE_HOST} \"rmdir ~/${REMOTE_USER}\""
if ! sshpass -p ${REMOTE_PASS} ssh ${REMOTE_USER}@${REMOTE_HOST} "rmdir ~/${REMOTE_USER}"; then printf "could not remove dir for user ${REMOTE_USER}\n"; exit; fi
printf "return code $?\n"

echo "sshpass -p ${REMOTE_PASS} ssh -t -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \"echo ${REMOTE_PASS}| sudo -S mkdir /mnt/temp_${REMOTE_USER}\""
if ! sshpass -p ${REMOTE_PASS} ssh -t -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "echo ${REMOTE_PASS}| sudo -S mkdir /mnt/temp_${REMOTE_USER}" ; then printf "could not create dir for using sudo for user ${REMOTE_USER}\n"; exit; fi

printf "return code $?\n"

echo "sshpass -p ${REMOTE_PASS} ssh -t -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \"echo ${REMOTE_PASS}| sudo -S rmdir /mnt/temp_${REMOTE_USER}\""
if ! sshpass -p ${REMOTE_PASS} ssh -t -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "echo ${REMOTE_PASS}| sudo -S rmdir /mnt/temp_${REMOTE_USER}";  then printf "could not delete dir for using sudo for user ${REMOTE_USER}\n"; exit; fi

printf "return code $?\n"
