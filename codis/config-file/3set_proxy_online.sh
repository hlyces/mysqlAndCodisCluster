#!/bin/sh

CODIS_HOME=/usr/local/codis
echo "set codis_proxy_3 online"
$CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/3config.ini proxy online codis_proxy_3
echo "done"
