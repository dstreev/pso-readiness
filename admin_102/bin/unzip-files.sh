#!/bin/bash

CUR_DIR=`pwd`

# Switch to script directory.
pushd `dirname $0`

if [ $# != 1 ]; then
    echo "Need to specify <3g|4g>"
    exit -1
fi

NETWORK=$1

#Run the staging_env script to setup export variables
#and setup the directories where files deposited
#in the staging dir will be copied to
. ./staging-env.sh $NETWORK

WORKINGDIR=$STAGING_DIR
BASEDIR=$FLUME_SPOOL_BASE
NODIRS=$FLUME_NO_DIRS

#change to the staging dir
pushd $WORKINGDIR

#Check to see if .gz files exist, if they exist
#unzip them one file at a time
count=`ls -1 *.gz 2>/dev/null | wc -l`
if [ ${count} -gt 0 ];then
for file in *.gz; do
gunzip $file
done;
fi

#Check to see if .dat files exist, if they exist
#rotate them through one directory at a time.

datCount=`ls -1 *.dat 2>/dev/null | wc -l`
if [ ${datCount} -gt 0 ];then
i=1
for file in *.dat; do
mv ${file} "${BASEDIR}/${i}/"
i=$((((i+1)%NODIRS)+1))
done;
fi

popd
popd
