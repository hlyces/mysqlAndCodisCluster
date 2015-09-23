#!/bin/bash

LOCALDIR=/usr/local

iptables -I INPUT -p tcp --dport 2181 -j ACCEPT
iptables -I INPUT -p tcp --dport 2888 -j ACCEPT
iptables -I INPUT -p tcp --dport 3888 -j ACCEPT
iptables -I INPUT -p tcp --dport 18087 -j ACCEPT
iptables -I INPUT -p tcp --dport 6379 -j ACCEPT
iptables -I INPUT -p tcp --dport 6380 -j ACCEPT
iptables -I INPUT -p tcp --dport 19000 -j ACCEPT

#systemctl stop firewalld.service
$LOCALDIR/zookeeper/bin/zkServer.sh stop
$LOCALDIR/zookeeper/bin/zkServer.sh start
$LOCALDIR/zookeeper/bin/zkServer.sh status 
$LOCALDIR/zookeeper/bin/zkCli.sh


