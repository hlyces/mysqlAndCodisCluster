#!/bin/sh
CODIS_HOME=/usr/local/codis 
nohup $CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/2config.ini -L $CODIS_HOME/logs/dashboard.log dashboard --addr=:18087 --http-log=$CODIS_HOME/logs/requests.log &>/dev/null &
