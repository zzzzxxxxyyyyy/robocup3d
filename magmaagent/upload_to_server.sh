#!/bin/bash
if ! [ -x "$(command -v sshpass)" ]; then
  sudo apt-get install sshpass
fi
echo -e "\n请输入用户名！\n"
read name
echo -e "\n请输入服务器密码！\n"
read key
dir=$(cd $(dirname $0);pwd)
file_name="${dir##*/}"

echo -e "\n[开始传输文件]\n"
tar -zcvPf /tmp/$file_name.tar.gz --exclude=.git $dir .
echo -e "\n[文件打包完成]\n"
sshpass -p "$key" scp -P 填写ssh端口号 /tmp/$file_name.tar.gz 用户名@主机地址:~/new_opt/$name/$file_name.tar.gz
rm /tmp/$file_name.tar.gz
echo -e "\n[文件传输完成]\n"

echo -e "\n请输入机器人类型(按回车默认输入0)！\n"
read roboType
if test -z "$roboType"
then
    roboType="0"
fi

echo -e "\n请输入最大计算次数(按回车默认输入10000)！\n"
read run_times
if test -z "$run_times"
then
    run_times="1000"
fi

echo -e "\n请输入popsize！((按回车默认输入100))\n"
read popsize
if test -z "$popsize"
then
    popsize="100"
fi


if true
	then 
  sshpass -p "$key" ssh -tt -p 填写ssh端口号 用户名@主机地址 << remotessh
  cd ~/new_opt/$name
  if [ -d $file_name ];then
    rm -r $file_name
  fi
  mkdir $file_name
  tar -xzvf $file_name.tar.gz -C ~/new_opt/$name/$file_name
  cd ~/new_opt/'$name'/$file_name/optimization/
  python3 optimization.py --roboType $roboType --run_times $run_times --popsize $popsize
remotessh
fi