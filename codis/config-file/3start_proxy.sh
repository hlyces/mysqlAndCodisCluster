#!/bin/sh
CODIS_HOME=/usr/local/codis
echo "shut down codis_proxy_3..."
$CODIS_HOME/bin/codis-config -c $CODIS_HOME/conf/3config.ini proxy offline codis_proxy_3
echo "done"
echo "start new codis_proxy_3..."
nohup $CODIS_HOME/bin/codis-proxy --log-level error -c $CODIS_HOME/conf/3config.ini -L $CODIS_HOME/logs/codis_proxy_3.log  --cpu=8 --addr=0.0.0.0:19001 --http-addr=0.0.0.0:11001 &
echo "done"
echo "sleep 3s"
sleep 3
tail -n 30 $CODIS_HOME/logs/codis_proxy_3.log
