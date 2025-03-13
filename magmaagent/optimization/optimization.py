# -*- coding: utf-8 -*-
"""
@Time ： 2022/08/23
@Auth ： 蒋旭 Apollo3D
@File ：optimization.py
"""

# include some packages
import sys
import argparse
import cma
import os
import time

param_names = []
param_nums = []
roboType = 0
running_params_path = './running_params'

run_times = 1000
run_time_now = 0

debug = False


# 从origin_params读取参数
def load_params(origin_params_path):
    global param_names, param_nums

    with open(origin_params_path, 'r') as file1:
        for param in file1:
            if param != '\n':
                param_list = param.split(" ")
                param_num = param_list[0]
                param_name = param_list[1][:-1]
                print(param_name)
                print(param_num)
                if 'E' in param_num:
                    param_num = '0'

                if eval(param_num) == 0:
                    param_num = '0.001'

                param_names.append(param_name)
                param_nums.append(eval(param_num))
    file1.close()
    return


def writeToFile(new_param_list):
    running_param_dic = dict(zip(param_names, new_param_list))

    out_file = open(running_params_path, 'w')
    for param_name, param_num in running_param_dic.items():
        out_file.write("{} {}\n".format(param_num, param_name))
    out_file.close()


def run(new_param_list):
    writeToFile(new_param_list)
    command1 = './sample_start-optimization.sh {0} {1} ./out'.format(roboType, running_params_path)
    os.system(command1)

    if os.path.isfile("out.txt"):
        file = open('./out.txt')
        lines = file.readlines()
        file.close()
        os.remove('out.txt')
        rst = lines[0]
        print("rst: ", rst)
        return float(rst)
    else:
        return -99999


def eva(ind):
    # 程序执行到指定迭代次数后退出
    global run_time_now
    run_time_now += 1
    if run_time_now > run_times:
        sys.exit()

    # 创造新的参数
    global param_names, param_nums
    new_param_list = []
    for x in range(0, len(ind)):
        new_param_list.append(ind[x] * param_nums[x])
    # 执行程序
    if debug:
        score = 20
    else:
        score = run(new_param_list)

    # 将执行结果追加写入到文件
    file = open('./opt_output', 'a')
    newLines = []
    for i in range(len(new_param_list)):
        newLines.append(str(new_param_list[i]) + ' ')
    newLines.append(str(score) + '\n')
    file.writelines(newLines)
    file.close()

    # 返回Fitness
    return 40 - score


def main():
    global roboType, run_times
    parser = argparse.ArgumentParser(description="Input the roboType and the cma options")
    parser.add_argument("--roboType", type=str, default='0')
    parser.add_argument("--run_times", type=int, default=1000)
    parser.add_argument("--popsize", type=str, default="50")
    args = parser.parse_args()
    roboType = args.roboType
    run_times = args.run_times
    popsize = args.popsize

    # 清空之前的优化结果
    if os.path.exists("opt_output"):
        os.remove("opt_output")

    load_params('origin_params')
    cma.fmin(eva, len(param_names) * [1.1], 0.2, options={'popsize': popsize})


if __name__ == "__main__":
    main()
