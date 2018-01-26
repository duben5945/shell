#!/bin/bash
#filename:check_http_log.sh
#用途:检查http服务码查看服务状态

#check_http_status 服务状态
#http_code 服务码
#check_http_code 状态码统计
#http_status_code 状态码
#关键利用awk统计code数据

#正常屏幕
resetsem=$(tput sgr0)
#日志路径
log_path=/var/log/apache2/access.log

#自定义函数，用数组表示状态码
check_http_status() {
	http_status_code=($(cat $log_path |awk '{print $7}'|awk '{ 
					if ($1 <100) { a++ }
					else if ($1>=100 && $1<200) { b++ }
					else if ($1>=100 && $1<300) { c++ }
					else if ($1>=300 && $1<400) { d++ }
					else if ($1>=400 && $1<500) { e++ }
					else if ($1>=500) { f++ }
					} END	{
						print a?a:0,b?b:0,c?c:0,d?d:0,e?e:0,f?f:0,a+b+c+d+e+f 
						}'))

echo -e '\E[33m' "The number of http status code[100-]:" ${resetsem} ${http_status_code[0]}
echo -e '\E[33m' "The number of http status code[100+]:" ${resetsem} ${http_status_code[1]}
echo -e '\E[33m' "The number of http status code[200+]:" ${resetsem} ${http_status_code[2]}
echo -e '\E[33m' "The number of http status code[300+]:" ${resetsem} ${http_status_code[3]}
echo -e '\E[33m' "The number of http status code[400+]:" ${resetsem} ${http_status_code[4]}
echo -e '\E[33m' "The number of http status code[500+]:" ${resetsem} ${http_status_code[5]}
echo -e '\E[33m' "All the request:" ${resetsem} ${http_status_code[6]}
}

check_http_status

