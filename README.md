# ʹ�ý̳�

1.׼��oracle11g��װ����ͨ��CRT�ϴ�����������
2.��ѹoracle11g��������/dataĿ¼�£�
	`unzip linux.x64_11gR2_database_1of2.zip -d /data`
	`unzip linux.x64_11gR2_database_2of2.zip -d /data`
3.��װdocker������������
4.��oracle-11g��װ�ű��ϴ���/dataĿ¼�£�������/data/oracle-11g
5.ͨ��DockerFile��������oracle���ݿ�����
	`docker build -t oracledb . `
6.����ɹ���������������
	`docker run --privileged --name oracle11g -dit -p 1521:1521 -v /data:/install oracledb bash`
7.��������,��װoracle���
	`docker exec -it oracledb bash`
	`cd /asserts`
	`./install.sh`
8.dbca��Ĭ��װ����
		*����*
	`dbca -silent -responseFile /assets/dbca.rsp`

?             *ɾ����*

?	`dbca -silent -deleteDatabase -sourceDB orcl -sysDBAUserName sys -sysDBAPassword oracle`
9.��Ĭ��������
	`netca /silent /responsefile /install/database/response/netca.rsp`