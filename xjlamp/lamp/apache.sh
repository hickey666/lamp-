#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Apache Install Script


if [ -d "/xj/server/apache" ]; then
    echo 'lamp has been installed'
    exit 1
fi

lamp_dir=$(cd `dirname $0`; pwd)
apache_dir=/xj/server/apache

tar -xzvf $lamp_dir/tools/apache/httpd-2.2.22.tar.gz  -C $lamp_dir/tools/apache | tee /xj/server/log/install/apache/apache_tar.log
cd $lamp_dir/tools/apache/httpd-2.2.22/
./configure --prefix=$apache_dir \
--enable-so \
--enable-expires=shared \
--enable-deflate=shared \
--enable-rewrite=shared \
--enable-static-support \
--enable-module=so \
--enable-cache \
--enable-file-cache \
--enable-mem-cache \
--enable-dixj-cache \
--enable-static-ab \
--disable-cgi \
--disable-cgid \
--disable-userdir  \
--with-mpm=worker | tee /xj/server/log/install/apache/apache_configure.log
make && make install | tee /xj/server/log/install/apache/apache_install.log

\cp -f $apache_dir/bin/apachectl /etc/init.d/httpd
sed -i "2s/#/#chkconfig: 2345 10 90/" /etc/init.d/httpd
sed '/#chkconfig: 2345 10 90/a #description: Activates/Deactivates Apache Web Server' -i /etc/init.d/httpd
chmod 755 /etc/init.d/httpd
chkconfig --add httpd
chkconfig --level 345 httpd on

echo "###### apache install completed ######"
sleep 3


