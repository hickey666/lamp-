#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Php Install Script


if [ -d "/xj/server/php" ]; then
    echo 'lamp has been installed'
    exit 1
fi

lamp_dir=$(cd `dirname $0`; pwd)


#install libpng
    tar -zxvf $lamp_dir/tools/php/libpng-1.2.31.tar.gz -C $lamp_dir/tools/php | tee /xj/server/log/install/php/libpng_tar.log
    cd $lamp_dir/tools/php/libpng-1.2.31/
    ./configure --prefix=/xj/server/libpng | tee /xj/server/log/install/php/libpng_configure.log
    make && make install | tee /xj/server/log/install/php/libpng_install.log


#install jpeg6
    mkdir -p /xj/server/jpeg/bin
    mkdir -p /xj/server/jpeg/lib
    mkdir -p /xj/server/jpeg/include
    mkdir -p /xj/server/jpeg/man/man1

    tar -zxvf $lamp_dir/tools/php/jpegsrc.v6b.tar.gz -C $lamp_dir/tools/php | tee /xj/server/log/install/php/jpeg6_tar.log
    cd $lamp_dir/tools/php/jpeg-6b/
    \cp -f /usr/share/libtool/config/config.sub .
    \cp -f /usr/share/libtool/config/config.guess .
    ./configure --prefix=/xj/server/jpeg \
    --enable-shared \
    --enable-static | tee /xj/server/log/install/php/jpeg6_configure.log
    make && make install | tee /xj/server/log/install/php/jpeg6_install.log


#install freetype
    tar -zxvf $lamp_dir/tools/php/freetype-2.4.6.tar.gz -C $lamp_dir/tools/php | tee /xj/server/log/install/php/freetype_tar.log
    cd $lamp_dir/tools/php/freetype-2.4.6/
    ./configure --prefix=/xj/server/freetype | tee /xj/server/log/install/php/freetype_configure.log
    make && make install | tee /xj/server/log/install/php/freetype_install.log


if [ ! -f "/usr/include/pngconf.h" ]; then
    ln -s /xj/server/libpng/include/pngconf.h /usr/include
fi
if [ ! -f "/usr/include/png.h" ]; then
    ln -s /xj/server/libpng/include/png.h /usr/include
fi





