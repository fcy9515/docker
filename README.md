# 使用教程

1.准备oracle11g安装包，通过CRT上传至宿主机上
2.解压oracle11g至宿主机/data目录下：	

```shell
unzip linux.x64_11gR2_database_1of2.zip -d /data
unzip linux.x64_11gR2_database_2of2.zip -d /data
```

3.安装docker，并启动服务
4.将oracle-11g安装脚本上传至/data目录下，并进入/data/oracle-11g
5.通过DockerFile编译生成oracle数据库容器	

```shell
docker build -t oracledb . 
```

6.编译成功后，运行以下命令

```
docker run --privileged --name oracle11g -dit -p 1521:1521 -v /data:/install oracledb bash
```

7.进入容器,安装oracle软件

```shell
docker exec -it oracledb bashcd /asserts./install.sh
```

8.dbca静默安装建库	

```shell
dbca -silent -responseFile /assets/dbca.rsp #建库
```

```shell
dbca -silent -deleteDatabase -sourceDB orcl -sysDBAUserName sys -sysDBAPassword oracle
#删除库
```

9.静默创建监听

```shell
netca /silent /responsefile /install/database/response/netca.rsp
```

10.hostname不正确导致监听启动失败，解决方式

```shell
var=`cat $ORACLE_HOME/network/admin/listener.ora|grep 'HOST = '|cut -d " " -f 13|cut -d ")" -f 1`
sed -i "s/$var/$HOSTNAME/g" $ORACLE_HOME/network/admin/listener.ora
```

