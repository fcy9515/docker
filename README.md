# ʹ�ý̳�

1.׼��oracle11g��װ����ͨ��CRT�ϴ�����������
2.��ѹoracle11g��������/dataĿ¼�£�	

```shell
unzip linux.x64_11gR2_database_1of2.zip -d /data
unzip linux.x64_11gR2_database_2of2.zip -d /data
```

3.��װdocker������������
4.��oracle-11g��װ�ű��ϴ���/dataĿ¼�£�������/data/oracle-11g
5.ͨ��DockerFile��������oracle���ݿ�����	

```shell
docker build -t oracledb . 
```

6.����ɹ���������������

```
docker run --privileged --name oracle11g -dit -p 1521:1521 -v /data:/install oracledb bash
```

7.��������,��װoracle���

```shell
docker exec -it oracledb bashcd /asserts./install.sh
```

8.dbca��Ĭ��װ����	

```shell
dbca -silent -responseFile /assets/dbca.rsp #����
```

```shell
dbca -silent -deleteDatabase -sourceDB orcl -sysDBAUserName sys -sysDBAPassword oracle
#ɾ����
```

9.��Ĭ��������

```shell
netca /silent /responsefile /install/database/response/netca.rsp
```

10.hostname����ȷ���¼�������ʧ�ܣ������ʽ

```shell
var=`cat $ORACLE_HOME/network/admin/listener.ora|grep 'HOST = '|cut -d " " -f 13|cut -d ")" -f 1`
sed -i "s/$var/$HOSTNAME/g" $ORACLE_HOME/network/admin/listener.ora
```

