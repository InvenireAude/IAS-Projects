#!/bin/bash

_SCRIPT_DIR=$(readlink -f ${1?})
_VERSION=$(basename $(readlink -f ${1?}))

shift

_MODE=$1
shift

_LOGS_DIR=/tmp

mkdir -p ${_LOGS_DIR}

echo ===========================================================
date
echo Working directory set to: $_LOGS_DIR
echo Reading from: ${_SCRIPT_DIR}/files.txt
#ls -l ${_SCRIPT_DIR}/files.txt
echo Database Version: $_VERSION
echo
echo ===========================================================

cd ${_SCRIPT_DIR}

for mode in revert install
do

echo
echo Mode: $mode
echo


if [[ $mode == install ]]
then
FILES=$(grep FILE= ${_SCRIPT_DIR}/files.txt |cut -f2- -d= | tr \\n ' ')
else
FILES=$(grep FILE= ${_SCRIPT_DIR}/files.txt |cut -f2- -d= | tac | tr \\n ' ')
fi

rm -f ${_LOGS_DIR}/script.$$.sql

for f in $FILES
do
echo Preparing: ${f}.${mode}.sql
cat ${f}.${mode}.sql >> ${_LOGS_DIR}/script.$$.sql
done

echo $*
cat ${_LOGS_DIR}/script.$$.sql
psql $* < ${_LOGS_DIR}/script.$$.sql

done


rm -f ${_LOGS_DIR}/script.$$.sql

