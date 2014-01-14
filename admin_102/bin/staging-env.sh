#!/bin/bash
#STAGING_DIR variable should be the location of
#initial location where files are going to be transferred.
#FLUME_DIR_ROOT variable should be the  full path of
#the directories where flume agents will be listening.
#The acutal flume directories will add 1, 2,3,4 etc to
# the path specified in FLUME_DIR_ROOT
#The FLUME_NO_DIRS variable should be equal to the number
#of flume agents per server

export FLUME_SPOOL_BASE=$HOME/mars/lz/fdr-$1
export STAGING_DIR=$HOME/mars/dm-stg-$1
export GZ_TEST_DIR=$HOME/mars/dm-stg-$1-test-gz

export FLUME_NO_DIRS=1

if [ ! -d "$STAGING_DIR" ]; then
    mkdir -p $STAGING_DIR
fi

if [ ! -d "$GZ_TEST_DIR" ]; then
    mkdir -p $GZ_TEST_DIR
fi

i=1

#Check to see if the directories that flume agents
#listen exist, if not go ahead and create them.
while [ ${i} -le ${FLUME_NO_DIRS} ]; do

BASEDIR=$FLUME_SPOOL_BASE/$i

if [ ! -d "$BASEDIR" ]; then
   mkdir -p ${BASEDIR}

fi;

i=$((i+1))
done;

