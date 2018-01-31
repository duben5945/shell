#!/bin/bash
reset_terminal=$(tput sgr0)
www_server="http://mrwjzs.com"
check_server() {
	status_code=$(curl -o /dev/null -m 5 -s -w %{http_code} ${www_server})
	if [ ${status_code} -eq 000 -o ${status_code} -ge 500 ];then
		echo -e '\E[1;32m' "check http server error! Response status code is: " ${reset_terminal} ${status_code}
	else
		echo -e '\E[1;32m' "check http server ok! Response status code is: " ${reset_terminal} ${status_code}
	fi


}
check_server

mysql_slave_server='192.168.1.105'
mysql_user='mysql105'
mysql_pass='mysql105'

check_mysql_server() {
	port_status=$(nmap -p 3306 ${mysql_slave_server}|grep '3306'|awk'{print $2}')
	if [ "${port_status}" = "open" ];
	then
		echo -e '\E[1;32m' "Connect ${mysql_slave_server} OK." ${reset_terminal}
	io_status=$(mysql -u${mysql_user} -p${mysql_pass} -h${mysql_slave_server} -e "show slave status\G"|grep -iw 'slave_io_running'|awk '{print $2}')
		if [ "${io_status}" = "NO" -o "${io_status}" = "No" ]
		then
			echo -e '\E[1;32m' "Slave thread is not running." ${reset_terminal}
		else
			seconds_behind_master=$(mysql -u${mysql_user} -p${mysql_pass} -h${mysql_slave_server} -e "show slave status\G"|grep -iw "seconds_behind_master" |sed '/ //g')
		echo -e '\E[1;32m' "${$seconds_behind_master}" ${reset_terminal}
		fi
	else
		echo -e '\E[1;32m' "Connect ${mysql_slave_server} Failed" ${reset_terminal}
	fi




}
check_mysql_server
