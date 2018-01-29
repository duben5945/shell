##################################################################
# File Name: system_monitor.sh
# Author: duben
# Mail : duben5945@163.com
# Time: 2018年01月28日 星期日 19时45分33秒
#################################################################
#!/bin/bash


#
#Internet
#Hostname
#Operation System Type
#Architecture
#Kernel Release 
#Kernel Version
#Internal IP
#External IP
#Server Name
#Logged In Users
#Ram Usages
#Swap Usages
#Disk Usages
#Load Average
#System Uptime
#echo -e '\E[1;32m'   ${reset_terminal}
##################################################################
clear
reset_terminal=$(tput sgr0)
#网络连接情况
echo -ne '\E[1;32m' "Internet: "  ${reset_terminal}
ping -c 2 www.baidu.com &>/dev/null && echo "Connected" || echo "Not Connected" 
#主机名
echo -e '\E[1;32m' "Hostname: "  ${reset_terminal} $HOSTNAME
#系统类型
system_type=$(uname -o)
echo -e '\E[1;32m'  "Operation System Type" ${reset_terminal} ${system_type}
#架构
architecture=$(uname -m)
echo -e '\E[1;32m'  "Architecture: " ${reset_terminal} ${architecture}
#内核发行号
kernel_release=$(uname -r)
echo -e '\E[1;32m'  "Kernel Release: " ${reset_terminal} ${kernel_release}
#内核版本
kernel_version=$(uname -v)
echo -e '\E[1;32m'  "Kernel Version: " ${reset_terminal} ${kernel_version}
#内网IP
internet_ip=$(hostname -I)
echo -e '\E[1;32m'  "Internet IP: " ${reset_terminal} ${internet_ip}
#外网IP
external_ip=$(curl ifconfig.me 2>/dev/null)
echo -e '\E[1;32m'  "Externet IP: " ${reset_terminal} ${external_ip}
#DNS服务器
server_name=$(cat /etc/resolv.conf|awk '/nameserver/ {print $2}')
echo -e '\E[1;32m'  "Server Name: " ${reset_terminal} ${server_name}
#登录账号
who >/tmp/who
echo -e '\E[1;32m'  "Logged In Users: " ${reset_terminal} 
cat /tmp/who
#内存使用
free -h >/tmp/ramcache
echo -e '\E[1;32m'  "Ram Usages: " ${reset_terminal} 
cat /tmp/ramcache|grep -iv "swap"
#交换分区使用
echo -e '\E[1;32m'  "Swap Usages: " ${reset_terminal} 
cat /tmp/ramcache|grep -iv "mem"
#硬盘使用
df -Ph |grep -iv "tmpfs" |awk '{print $1 "\t" $5}'>>/tmp/diskusages
echo -e '\E[1;32m'  "Disk Usages: " ${reset_terminal} 
cat /tmp/diskusages
#系统CPU使用率
cpu_usages=$(uptime |awk '{print $8 $9 $10}')
echo -e '\E[1;32m'  "Load Average: " ${reset_terminal} ${cpu_usages}
#系统开机时间
cputime=$(uptime |awk '{print $3}'|tr -d "," )
echo -e '\E[1;32m'  "System Uptime: " ${reset_terminal} ${cputime}

rm  /tmp/who /tmp/ramcache /tmp/diskusages
