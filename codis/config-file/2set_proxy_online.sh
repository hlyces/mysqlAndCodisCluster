#!/bin/sh

CODIS_HOME=/usr/local/codis
echo "set codis_proxy_2 online"
$CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/2config.ini proxy online codis_proxy_2
echo "done"
