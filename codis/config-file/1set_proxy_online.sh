#!/bin/sh

CODIS_HOME=/usr/local/codis
echo "set codis_proxy_1 online"
$CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/1config.ini proxy online codis_proxy_1
echo "done"
