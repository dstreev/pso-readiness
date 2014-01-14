# The Mars Staging Environment setup is composed of the following steps. 
1. Monitor a staging directory for .gz files that will be deposited by Verizon, Unzip the .Gz files as they are deposited and move the .dat files into a configurable number of directories. 
2. Flume Agents listen in on these directories and move them into HDFS. The above sequence of steps needs to repeated on about 10 (or as many as needed to meet new data requirements).

## Step 1 - Monitor and move uncompressed files to spooling directories monitored by Flume:[To be done on every staging server]

1. Please open the provided .sh files(`unzip-files.sh` and `staging-env.sh`). `unzip-files.sh` is responsible for monitoring the staging directory for .gz files, uncompressing them and uniformly distributing them into a series of directories that are watched by flume agents.  `staging-env.sh` is a shell script that configures the directory to listen to, the full path to the rootDir that will be listened to by the flume agents and the number of flume agents on this particular server.
2. Please open the `staging-env.sh` file and configure the following 3 variables.
   a. Please set the variable STAGING_DIR to the full path of the directory where the compressed files will be automatically downloaded.
   b. Please set the variable `FLUME_NO_DIRS` to the number of flume agents on this server.
   c. Please set the `FLUME_SPOOL_BASE` variable to the full base path of the directory that will be monitored by the flume agent. Please note that if you set this variable to `/home/flume/dir`, and the number of flume agents to 5, this script will automatically check and create the following directories - i) /home/flume/dir1 ii) /home/flume/dir2 iii) /home/flume/dir3 iv) /home/flume/dir4 v) /home/flume/dir5. You would need to configure the flume agents (see STEP 2) to monitor these newly created directories.
3. Please open the `unzip-files.sh` and change the sixth line to update the location of the downloaded `staging-env.sh`.
4. This process is controlled by a cron job that runs the shell script(`unzip-files.sh`) every 'n' minutes. To setup the cron job, type `crontab -e` from the terminal. Please type the following lines once the crontab editor opens:
```
SHELL=/bin/bash
* * * * * FULL PATH TO unzip-files.sh
```
The above configuration (5 stars) ensures that the file will be run every minute.

1. Please repeat the above process on every staging server.

## STEP 2a - FLUME AGENT CONFIGURATION

This process is dependent on some of the actions from the previous step and requires manual editing of the provided configuration file (agent.conf). The provided file is setup to work with 2 agents. Add more agents to this file as determined and configured in the previous step. For each agent (a1, a2 etc), please change the names of the sinks (k1, k2 etc), source (r1, r2 etc) and the channel (c1, c2) etc.

The following process needs to repeated on every staging server.

1. Create a "run-agents.sh" script that will call the "run-agent.sh" script $FLUME_NO_DIRS (staging-env.sh) times with the following parameters:
  a. 3g|4g
  b. directory number
  c. namenode base IE: http://localhost:8020
2. The "run-agent.sh" script will create an "agent.conf.'dir_num' file (derived from loop on FLUME_NO_DIRS in staging-env.sh) from the agent.conf template.  This file will contain the settings for the agent and will be use to configure the agent launched.

3. Please save the built "fdr.flume.interceptor.xxx.jar" file to the flume configuration directory.

4. Please open the `flume-env.sh` file in the flume configuration directory and add the following line `FLUME_CLASSPATH=` full path to the fdr.flume.interceptor.xxx.jar" file


## Step 2b - Starting the Flume Agent

Two options:

1. Starting all agents.  `run-agents.sh <3g|4g> <namenode>`
2. Starting one agent: `run-agent.sh <3g|4g> <dir-num> <namenode>`