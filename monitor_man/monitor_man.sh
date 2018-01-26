#!/bin/bash
#filename:monitor_man.sh
#用途:主控脚本

#初始屏幕
resetsem=$(tput sgr0)
#定义关联数组
declare -A sh_array
i=1
numbers=''
#设置退出提示
echo -e '\E[1;35m' "The Script:" 0 '==>' ${resetsem} "quit monitor_man"
#为关联数组赋值
for script_file in $(ls ./ |grep -vE "monitor.man.sh")
do
	echo -e '\E[1;36m' "The script:" ${i} '==>' ${resetsem} ${script_file}
	sh_array[${i}]=${script_file}
	numbers="${numbers}|${i}"
	let i=${i}+1
done

#交互，选择数字执行脚本
while true
do
	read -p "Please input a number [ 0${numbers} ]:" shell_number
	case ${shell_number} in
	[1-$((i-1))])
		/bin/sh ./${sh_array[${shell_number}]};;
	0)
		echo -e '\E[1;35m' "quit monitor.man" ${resetsem}
		exit;;
	*)
		echo -e '\E[1;35m' "Wrong Number,Please Input a number again" ${resetsem};;
	esac

	
done


