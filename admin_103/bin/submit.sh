#!/bin/bash

WORK_FLOW=$1

hadoop fs -rm -r -skipTrash admin-103-workflows/$WORKFLOW
# Ensure Parent Workflow Directory
hadoop fs -mkdir -p admin-103-workflows/$WORKFLOW

# Copy the workflow to hdfs.
hadoop fs -put ../workflows/$WORK_FLOW admin-103-workflows
#hadoop fs -put /etc/hive/conf/hive-site.xml admin-103-workflows/$WORK_FLOW/hive

# List the contents
hadoop fs -ls admin-103-workflows