#!/bin/bash

if [ $# < 2 ]; then
  echo "Need to specify a Workflow and an email address for notifications"
  exit -1;
fi

APP_PATH=`dirname $0`
echo $APP_PATH

cd $APP_PATH

. $APP_PATH/submit.sh $1

USER=`whoami`

# Submit and Start the job with one call.  To split it out, use submit then start.
oozie job -oozie http://localhost:11000/oozie -config ../control.properties/workflows/$1/job.properties -run -verbose -Demailto=$2 -Duser=$USER -DWORKFLOW=$1