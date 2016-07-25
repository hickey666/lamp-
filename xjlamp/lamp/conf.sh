#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Init Install Script



lamp_dir=$(cd `dirname $0`; pwd)


#php config

sed -i "s/;date.timezone =/date.timezone = PRC/" /xj/server/php/etc/php.ini
sed -i "s/disable_functions =/disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,escapeshellcmd,escapeshellarg,shell_exec,proc_get_status,ini_alter,ini_alter,ini_restore,dl,pfsockopen,openlog,syslog,readlink,symlink,leak,popepassthru,stream_socket_server,popen/" /xj/server/php/etc/php.ini



#httpd config

groupadd www
useradd -g www www
mkdir -p /xj/wwwroot/xj
chmod +w /xj/wwwroot
chown www:www /xj/wwwroot -R
sed -i "s/User daemon/User www/" /xj/server/apache/conf/httpd.conf 
sed -i "s/Group daemon/Group www/" /xj/server/apache/conf/httpd.conf 
sed -i '/#ServerName www.example.com:80/a ServerName localhost:80' /xj/server/apache/conf/httpd.conf
sed -i "s/DirectoryIndex index.html/DirectoryIndex index.php index.html index.htm/" /xj/server/apache/conf/httpd.conf 
sed -i '/AddType application\/x-gzip .gz .tgz/a AddType application\/x-httpd-php .php' /xj/server/apache/conf/httpd.conf

mkdir -p /xj/server/apache/conf.d/
echo "Include conf.d/*.conf" >> /xj/server/apache/conf/httpd.conf 
\cp -f $lamp_dir/tools/xj-vhosts.conf /xj/server/apache/conf.d/

sed -i "s/Deny from all/Allow from all/" /xj/server/apache/conf/httpd.conf 
sed -i "s/AllowOverride None/AllowOverride All/" /xj/server/apache/conf/httpd.conf 


touch /xj/wwwroot/xj/index.php
echo "<?php phpinfo();" >> /xj/wwwroot/xj/index.php

touch /xj/wwwroot/xj/.htaccess
echo "RewriteEngine On" >> /xj/wwwroot/xj/.htaccess
sed '/RewriteEngine On/a ErrorDocument 404 /404.html' -i /xj/wwwroot/xj/.htaccess
sed '/ErrorDocument 404 \/404.html/a ErrorDocument 403 /403.html' -i /xj/wwwroot/xj/.htaccess

echo "<html><head><title>403</title></head><body>403</body></html>" >> /xj/wwwroot/xj/403.html
echo "<html><head><title>404</title></head><body>404</body></html>" >> /xj/wwwroot/xj/404.html

service httpd start

clear
echo "------ lamp install completed ------"
