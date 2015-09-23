#!/bin/bash

LOCALDIR=/usr/local

cd $LOCALDIR/codis/scripts/
sh 1start_proxy.sh
sh 2start_proxy.sh
sh 3start_proxy.sh
sh 4start_proxy.sh
