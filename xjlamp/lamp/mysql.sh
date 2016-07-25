#!/bin/bash
# Version: 1.0.0  
# Author: seven
# Date: 2015/1/5  
# sed -i "s/basedir=/basedir=\/xj\/server\/mysql/" /etc/init.d/mysqld
# sed -i "s/datadir=/datadir=\/xj\/server\/data/" /etc/init.d/mysqld
# Description: MySql Install Script


if [ -d "/xj/server/mysql" ]; then
    echo 'lamp has been installed'
    exit 1
fi

lamp_dir=$(cd `dirname $0`; pwd)
mysql_dir=/xj/server/mysql
mysql_data_dir=/xj/server/data

groupadd mysql
useradd -g mysql -s /sbin/nologin mysql

mkdir -p $mysql_data_dir

tar -xzvf $lamp_dir/tools/mysql/mysql-5.5.18.tar.gz  -C $lamp_dir/tools/mysql | tee /xj/server/log/install/mysql/mysql_tar.log
cd $lamp_dir/tools/mysql/mysql-5.5.18/
cmake -DMYSQL_USER=mysql -DCMAKE_INSTALL_PREFIX=$mysql_dir -DMYSQL_DATADIR=$mysql_data_dir -DDEFAULT_CHARSET=utf8 -DEXTRA_CHARSETS=all -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DDEFAULT_COLLATION=utf8_general_ci -DENABLED_LOCAL_INFILE=1 -DWITH-EMBEDDED_SERVER=1 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock | tee /xj/server/log/install/mysql/mysql_cmake.log
make && make install | tee /xj/server/log/install/mysql/mysql_install.log

chown -R mysql:mysql $mysql_data_dir/
chown -R mysql:mysql $mysql_dir/

\cp -f $lamp_dir/tools/mysql/mysql-5.5.18/support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig --level 345 mysqld on

\cp -f $lamp_dir/tools/mysql/mysql-5.5.18/support-files/my-medium.cnf /etc/my.cnf

$mysql_dir/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=$mysql_dir --datadir=$mysql_data_dir --user=mysql --tmpdir=/tmp

service mysqld start
$mysql_dir/bin/mysqladmin -u root password 'xj888'
$mysql_dir/bin/mysql -uroot -pxj888 <<EOF
drop database test;
delete from mysql.user where user='';
update mysql.user set password=password('xj888') where user='root';
delete from mysql.user where not (user='root') ;
flush privileges;
exit
EOF

echo "###### mysql install completed ######"
sleep 3


