#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# Description: Init Install Script



lamp_dir=$(cd `dirname $0`; pwd)


#php config

sed -i "s/;date.timezone =/date.timezone = PRC/" /xj/server/php/etc/php.ini
sed -i "s/disable_functions =/disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,escapeshellcmd,escapeshellarg,shell_exec,proc_get_status,ini_alter,ini_alter,ini_restore,dl,pfsockopen,openlog,syslog,readlink,symlink,leak,popepassthru,stream_socket_server,popen/" /xj/server/php/etc/php.ini



service httpd stop
service httpd start

clear
echo "------ lamp install completed ------"
