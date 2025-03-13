#!/bin/bash

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

cd optimization/
python3 optimization.py --roboType $roboType --run_times $run_times --popsize $popsize