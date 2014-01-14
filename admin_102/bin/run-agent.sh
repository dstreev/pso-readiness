#!/bin/bash

APP_PATH=`dirname @0`

cd $APP_PATH

if [ $# != 3 ]; then
   echo "Missing parameters: <3g|4g> <dir_num> <namenode>"
   exit -1
fi

. ./staging-env.sh $1

# Landing Zone
#SPOOL_BASE=$HOME/mars/lz/fdr-$1/
FLUME_SPOOL_DIR_NUM=$2
FLUME_SPOOL_DIR=$FLUME_SPOOL_BASE/$FLUME_SPOOL_DIR_NUM
NAMENODE=$3


# Using the ../conf/agent.conf as a template, replace the following:
# ${spooldir}=$SPOOL_DIR
# ${namenode}=$NAMENODE
cp ../conf/agent.conf ../conf/agent.conf.$FLUME_SPOOL_DIR_NUM

sed -i.bak "s|\${namenode}|$NAMENODE|g" ../conf/agent.conf.$FLUME_SPOOL_DIR_NUM
sed -i.bak "s|\${spooldir}|$FLUME_SPOOL_DIR|g" ../conf/agent.conf.$FLUME_SPOOL_DIR_NUM

# Clean up
rm ../conf/agent.conf.$FLUME_SPOOL_DIR_NUM.bak

# Start Flume agent with adjusted Flume Configuration File.
flume-ng agent --conf-file ../conf/agent.conf.$FLUME_SPOOL_DIR_NUM --name a1 --conf .