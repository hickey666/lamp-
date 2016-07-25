# xjlamp

xjlanmp一键安装包、是基于xjLNAMP（托管于Github）修改、为xjPHP v2.0诞生的一行代码搞定LAMP环境安装包、新增PHP多版本任意切换功能，适用于主流的Linux发行版CentOS（已测）




#安装
```
xj xj.sh
```

#多站点配置：
```
复制： /xj/server/apache/conf.d/【唯一标识】-vhosts.conf   
配置：【唯一标识】-vhosts.conf      
生效：service httpd restart                               
```

#xjlamp结构
```
     mysql目录： /xj/server/mysql（默认密码：xj888）
mysql data目录： /xj/server/data
       php目录： /xj/server/php
    apache目录： /xj/server/apache                           
```

#命令一览：
```
 mysql命令： service mysql (start|stop|restart|reload|status)
apache命令： service httpd (start|stop|restart|reload|status)
```

#网站根目录：
```
默认web根目录： /xj/wwwroot
```
	