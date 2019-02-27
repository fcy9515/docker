set -e

source /assets/colorecho
trap "echo_red '******* ERROR: Something went wrong.'; exit 1" SIGTERM
trap "echo_red '******* Caught SIGINT signal. Stopping...'; exit 2" SIGINT

#Install prerequisites directly without virtual package
deps () {

	echo "Installing dependencies"
	yum -y install gcc gcc-c++ make binutils compat-libstdc++-33 glibc glibc-devel libaio libaio-devel libgcc libstdc++ libstdc++-devel libXtst sysstat ksh make libXi compat-libcap1 --setopt=protected_multilib=false
	yum clean all
	rm -rf /var/lib/{cache,log} /var/log/lastlog

}

users () {

	echo "Configuring users"
	groupadd -g 500 oinstall
	groupadd -g 501 dba
	useradd -u 500 -g oinstall -G dba oracle
	echo "oracle:oracle" | chpasswd
	echo "root:123456" | chpasswd
	mkdir -p -m 755 /oracle/app/oracle
	mkdir -p -m 755 /oracle/app/oraInventory
	mkdir -p -m 755 /oracle/app/dpdump
	chown -R oracle:oinstall /oracle/app
	sed -i "s/pam_namespace.so/pam_namespace.so\nsession    required     pam_limits.so/g" /etc/pam.d/login
	cat /assets/profile >> ~oracle/.bash_profile
	cat /assets/profile >> ~oracle/.bashrc

}

sysctl_and_limits () {

	cp /assets/sysctl.conf /etc/sysctl.conf
	cat /assets/limits.conf >> /etc/security/limits.conf

}

deps
users
sysctl_and_limits
