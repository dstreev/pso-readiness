#!/bin/bash

CUR_DIR=`pwd`

# Switch to script directory.
pushd `dirname $0`

. ./staging-env.sh 4g
rm $FLUME_SPOOL_BASE/1/*.COMPLETED

cp $GZ_TEST_DIR/*.gz $STAGING_DIR

. ./unzip-files.sh 4g