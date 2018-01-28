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
#
