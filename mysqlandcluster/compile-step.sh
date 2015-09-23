#!/bin/bash

start_compile()
{
	yum install iptables-services -y

	yum install -y perl perl-devel

	yum remove mysql

	rm -rf /var/lib/mysql

	cp -f my.cnf /etc/

	mkdir /usr/local/mysql

	tar -zxvf mysql-cluster-gpl-7.4.6-linux-glibc2.5-x86_64.tar.gz

	mv mysql-cluster-gpl-7.4.6-linux-glibc2.5-x86_64 /usr/local/mysql/mysqlc

	groupadd mysql
	useradd mysql -g mysql
	chown -R mysql:mysql /usr/local/mysql

	cd /usr/local/mysql/mysqlc
	scripts/mysql_install_db --user=mysql

	mkdir /usr/local/mysql/bin
	cp -f /usr/local/mysql/mysqlc/bin/ndbd  /usr/local/mysql/bin
	cp -f /usr/local/mysql/mysqlc/bin/ndb_mgm  /usr/local/mysql/bin
	cp -f /usr/local/mysql/mysqlc/bin/ndb_mgmd /usr/local/mysql/bin

	mkdir  /usr/local/mysql/etc
	cd  /usr/local/my_cluster_step/
	cp -f config.ini /usr/local/mysql/etc/

	cp -f /usr/local/mysql/mysqlc/support-files/mysql.server /etc/init.d/mysqld 

	
}

start_compile
