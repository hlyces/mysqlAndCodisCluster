#!/bin/sh
CODIS_HOME=/usr/local/codis
echo "slots initializing..."
$CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/2config.ini slot init -f
echo "done"
