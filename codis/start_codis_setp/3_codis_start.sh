#!/bin/bash

LOCALDIR=/usr/local
DATADIR=/data

$LOCALDIR/codis/bin/codis-server $DATADIR/codis_server/conf/6379.conf
$LOCALDIR/codis/bin/codis-server $DATADIR/codis_server/conf/6380.conf

