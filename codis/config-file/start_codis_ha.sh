#!/bin/sh
./codis-ha --codis-config=192.168.1.250:18087 -log-level="info" --productName=vmware-Codis &> ./logs/codis-ha.log &
