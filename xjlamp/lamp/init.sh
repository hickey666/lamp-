#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Init Install Script


if [ -d "/xj/server/apache" ]; then
    echo 'lamp has been installed'
    exit 1
fi

sed '/22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' -i /etc/sysconfig/iptables
sed '/80/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT' -i /etc/sysconfig/iptables
service iptables restart

mkdir -p /xj/server/log/install/init
mkdir -p /xj/server/log/install/mysql
mkdir -p /xj/server/log/install/apache
mkdir -p /xj/server/log/install/php

cat /proc/version >> /xj/server/log/install/init/version.log

echo 'init remove server install lanmp tools, waiting....'
yum -y remove httpd php-* mysql-* | tee /xj/server/log/install/init/yum_remove.log


echo 'install gcc g++, compiler.  waiting....'
yum -y install gcc gcc-c++ make cmake | tee /xj/server/log/install/init/yum_compiler.log


echo 'install lamp rely on repository,  waiting....'
yum -y install zlib zlib-devel libxml2 libxml2-devel \
libmcrypt libmcrypt-devel \
openssl openssl-devel curl curl-devel \
libtool libtool-ltdl \
ncurses ncurses-devel mysql-devel | tee /xj/server/log/install/init/yum_rely_on_repository.log

