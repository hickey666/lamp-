#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Php Install Script

if [ ! -d "/xj/server/apache" ]; then
    echo 'you dont install apache'
    exit 1
fi

lamp_dir=$(cd `dirname $0`; pwd)


rm -rf /xj/server/gd2/

#install gd2
    tar -zxvf $lamp_dir/tools/php/gd-2.0.35.tar.gz -C $lamp_dir/tools/php | tee /xj/server/log/install/php/gd_tar.log
    cd $lamp_dir/tools/php/gd/2.0.35/
    ./configure --prefix=/xj/server/gd2 \
    --with-jpeg=/xj/server/jpeg/ \
    --with-freetype=/xj/server/freetype/ \
    --with-png=/xj/server/libpng/ | tee /xj/server/log/install/php/gd_configure.log
    make && make install | tee /xj/server/log/install/php/gd_install.log


echo "###### php_init install completed ######"

