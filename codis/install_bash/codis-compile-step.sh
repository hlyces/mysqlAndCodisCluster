#!/bin/bash

DATADIR=/data
LOCALDIR=/usr/local
PROFILEDIR=/etc/profile

echo_codis()
{
	echo " ">>$PROFILEDIR
	echo " ">>$PROFILEDIR
	echo "GOROOT=/usr/local/go">>$PROFILEDIR
	echo "GOPATH=/usr/local/codis">>$PROFILEDIR
	echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin:\$ZOOKEEPER_HOME/bin:\$GOROOT/bin">>$PROFILEDIR
	echo "export JAVA_HOME PATH CLASSPATH JRE_HOME ZOOKEEPER_HOME GOROOT GOPATH">>$PROFILEDIR

}

compile_codis()
{
	cd $DATADIR/packages
	tar zxvf go1.4.2.linux-amd64.tar.gz -C $LOCALDIR 
	cd $LOCALDIR

	echo_codis
	source $PROFILEDIR

	yum -y groupinstall "Development Tools"
	yum install -y git

	cd $DATADIR
	cp -rf  ./packages/codis /usr/local/

	cd $GOPATH/src/github.com/wandoulabs/codis
	mkdir -p $LOCALDIR/codis/{logs,conf,scripts}
	mkdir -p $DATADIR/codis_server/{logs,conf,data}
	cp -rf bin $LOCALDIR/codis/
	
	if [ "$1" ==  1 ]; then
		cp -f $DATADIR/config-file/1config.ini $LOCALDIR/codis/conf/
		cp -f $DATADIR/config-file/3config.ini $LOCALDIR/codis/conf/
	fi
	if [ "$1" ==  2 ]; then
		cp -f $DATADIR/config-file/2config.ini $LOCALDIR/codis/conf/
		cp -f $DATADIR/config-file/4config.ini $LOCALDIR/codis/conf/
	fi

	cp -f $DATADIR/config-file/6379.conf /data/codis_server/conf/
	cp -f $DATADIR/config-file/6380.conf /data/codis_server/conf/
	cp -rf $LOCALDIR/codis/src/github.com/wandoulabs/codis/sample/usage.md $LOCALDIR/codis/scripts/  
	
	if [ "$1" ==  1 ]; then
echo "1111"
		cp -f $DATADIR/config-file/1start_proxy.sh $LOCALDIR/codis/scripts/1start_proxy.sh
		cp -f $DATADIR/config-file/1set_proxy_online.sh $LOCALDIR/codis/scripts/1set_proxy_online.sh
		cp -f $DATADIR/config-file/3start_proxy.sh $LOCALDIR/codis/scripts/3start_proxy.sh
		cp -f $DATADIR/config-file/3set_proxy_online.sh $LOCALDIR/codis/scripts/3set_proxy_online.sh
	fi
	if [ "$1" ==  2 ]; then
echo "2222"
		cp -f $DATADIR/config-file/2start_proxy.sh $LOCALDIR/codis/scripts/2start_proxy.sh
		cp -f $DATADIR/config-file/2set_proxy_online.sh $LOCALDIR/codis/scripts/2set_proxy_online.sh
		cp -f $DATADIR/config-file/4start_proxy.sh $LOCALDIR/codis/scripts/4start_proxy.sh
		cp -f $DATADIR/config-file/4set_proxy_online.sh $LOCALDIR/codis/scripts/4set_proxy_online.sh
	fi



	if [ "$1" ==  1 ]; then
                go get github.com/ngaut/codis-ha
                cd $LOCALDIR/codis/src/github.com/ngaut
                cp -rf codis-ha $LOCALDIR
                cd $LOCALDIR/codis-ha
                go build
                cp -f $DATADIR/config-file/start_codis_ha.sh  $LOCALDIR/codis-ha/start_codis_ha.sh
                mkdir $LOCALDIR/codis-ha/logs
                cd $LOCALDIR/codis-ha/
        fi

	if [ "$1" ==  2 ]; then
                echo "222222222222222222"
                cp -f $DATADIR/config-file/start_dashboard.sh $LOCALDIR/codis/scripts/start_dashboard.sh
                cp -f $DATADIR/config-file/initslot.sh $LOCALDIR/codis/scripts/initslot.sh
        fi

	 chmod 777 /usr/local/codis/bin/ -R
	 chmod 777 /usr/local/codis/scripts/ -R
	chmod 777 /data/start_codis_setp -R
}

print_help()
{
	echo "please input ./codis-compile-step.sh codis_server \$1"
}

case $1 in
        codis_server)
		compile_codis $2
                ;;
	 *)
                print_help
                ;;
esac

