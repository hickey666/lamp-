#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Php Install Script


lamp_dir=$(cd `dirname $0`; pwd)

rm -rf /xj/server/php/

#install php
    tar -zxvf $lamp_dir/tools/php/php-5.3.27.tar.gz -C $lamp_dir/tools/php | tee /xj/server/log/install/php/php_tar.log
    cd $lamp_dir/tools/php/php-5.3.27/
    ./configure --prefix=/xj/server/php \
    --with-config-file-path=/xj/server/php/etc/ \
    --with-apxs2=/xj/server/apache/bin/apxs \
    --with-zlib-dir \
    --with-jpeg-dir=/xj/server/jpeg/ \
    --with-gd=/xj/server/gd2/ \
    --with-png-dir=/xj/server/libpng \
    --with-freetype-dir=/xj/server/freetype/ \
    --enable-mbregex --enable-bcmath \
    --with-libxml-dir=/usr \
    --enable-mbstring=all --with-pdo-mysql \
    --with-mysqli=/xj/server/mysql/bin/mysql_config \
    --with-mysql=/xj/server/mysql/ \
    --enable-soap \
    --enable-sockets \
    --with-openssl \
    --with-curl | tee /xj/server/log/install/php/php_configure.log
    make && make install | tee /xj/server/log/install/php/php_install.log


\cp -f $lamp_dir/tools/php/php-5.3.27/php.ini-production /xj/server/php/etc/php.ini

echo "###### php install completed ######"



