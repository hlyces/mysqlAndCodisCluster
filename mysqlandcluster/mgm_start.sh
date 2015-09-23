#!/bin/bash

cd  /usr/local/mysql/bin
/usr/local/mysql/bin/ndb_mgmd -f /usr/local/mysql/etc/config.ini --initial

