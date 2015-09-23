#!/bin/bash

DATADIR=/data
LOCALDIR=/usr/local
PROFILEDIR=/etc/profile

echo_zookeeper()
{
	echo " ">>$PROFILEDIR
	echo " ">>$PROFILEDIR
	echo "JAVA_HOME=/usr/local/java">>$PROFILEDIR
	echo "JRE_HOME=\$JAVA_HOME/jre">>$PROFILEDIR 
	echo "ZOOKEEPER_HOME=/usr/local/zookeeper">>$PROFILEDIR
	echo "JAVA_FONTS=/usr/local/java/jre/lib/fonts">>$PROFILEDIR  
	echo "CLASSPATH=\$JAVA_HOME/lib:\$JAVA_HOME/lib/tools.jar">>$PROFILEDIR 
	echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin:\$ZOOKEEPER_HOME/bin">>$PROFILEDIR  
	echo "export JAVA_HOME PATH CLASSPATH JRE_HOME ZOOKEEPER_HOM">>$PROFILEDIR
	
}

compile_zookeeper()
{
	
	echo "============install java environment================="
	cd	$DATADIR/packages
	tar zxvf jdk-8u51-linux-x64.gz -C $LOCALDIR
	cd $LOCALDIR
	ln -s jdk1.8.0_51 java
	
	echo "============install zookeeper================="
	cd	$DATADIR/packages
	tar zxvf zookeeper-3.4.6.tar.gz -C $LOCALDIR
	cd $LOCALDIR
	ln -s  zookeeper-3.4.6  zookeeper
	cd $LOCALDIR/zookeeper/
	
	echo_zookeeper
	source $PROFILEDIR
	source /etc/profile

	cd	$DATADIR/config-file
	cp -f zoo.cfg $LOCALDIR/zookeeper/conf/zoo.cfg
	
	mkdir -p $DATADIR/zookeeper/data
	mkdir -p $DATADIR/zookeeper/logs
	
	if [ $1 == 1 ]; then
		echo "1" > $DATADIR/zookeeper/data/myid
	elif [ $1 == 2 ]; then
		echo "2" > $DATADIR/zookeeper/data/myid
	elif [ $1 == 3 ]; then
		echo "3" > $DATADIR/zookeeper/data/myid
	fi

}

print_help()
{
	echo "please input./zookkeeper-compile-step.sh zkServer \$"
}

case $1 in
        zkServer)
		compile_zookeeper $2
                ;;
	 *)
                print_help
                ;;
esac

