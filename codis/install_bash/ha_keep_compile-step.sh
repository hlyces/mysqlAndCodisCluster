#!/bin/bash

DATADIR=/data
LOCALDIR=/usr/local
PROFILEDIR=/etc/profile


compile_pcre()
{
	cd $DATADIR/packages
	tar -zxf pcre-8.37.tar.gz && cd pcre-8.37
	./configure --disable-shared --with-pic
	 make && make install
}

compile_haproxy()
{
	cd $DATADIR/packages
	tar -zxf haproxy-1.4.26.tar.gz && cd haproxy-1.4.26
	make TARGET=linux26 CPU=x86_64 USE_STATIC_PCRE=1 USE_LINUX_TPROXY=1
	make install target=linux26
	mkdir -p $LOCALDIR/haproxy/sbin
	mkdir -p $DATADIR/haproxy/{conf,run,logs}
	ln -s $LOCALDIR/sbin/haproxy $LOCALDIR/haproxy/sbin

	cd $DATADIR
	cp -f ./config-file/haproxy /etc/init.d/haproxy
	echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/rsysctl.conf
	chmod 755 /etc/init.d/haproxy
	chkconfig --add haproxy
	chkconfig haproxy on

	cd $DATADIR
	cp -f ./config-file/haproxy.cfg $DATADIR/haproxy/conf/haproxy.cfg
	cp -f ./config-file/haproxy.conf /etc/rsyslog.d/haproxy.conf
}

compile_keepalived()
{
	yum install psmisc -y

	cd $DATADIR/packages
	tar zxvf keepalived-1.2.16.tar.gz
	cd keepalived-1.2.16
	yum install -y kernel-header kernel-devel
	./configure --sysconf=/etc --with-kernel-dir=/usr/src/kernels/2.6.32-504.16.2.el6.x86_64/
	make && make install
 
#	cp -f $LOCALDIR/etc/rc.d/init.d/keepalived /etc/rc.d/init.d/
#	cp -f $LOCALDIR/etc/sysconfig/keepalived /etc/sysconfig/
	mkdir -p /data/keepalived/{conf,scripts}
	cp -f $LOCALDIR/sbin/keepalived /usr/sbin/
	chkconfig --add keepalived
	chkconfig keepalived on

	cd $DATADIR
#	cp -f ./config-file/keepalived.conf /data/keepalived/conf/keepalived.conf
	cp -f ./config-file/keepalived.conf /etc/keepalived/keepalived.conf
}

print_help()
{
	echo "please input ./ha_keep_compile.sh ha_ke_server  \$1"
}

case $1 in
        ha_ke_server)
		if [ $2 -ne 1 -a $2 -ne 2 ]; then
			exit 1
		fi
#		compile_pcre
#		compile_haproxy
		compile_keepalived
                ;;
	 *)
                print_help
                ;;
esac

