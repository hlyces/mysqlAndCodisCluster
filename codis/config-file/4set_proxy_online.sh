#!/bin/sh

CODIS_HOME=/usr/local/codis
echo "set codis_proxy_4 online"
$CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/4config.ini proxy online codis_proxy_4
echo "done"
