# coding=UTF-8

"""
@Time ： 2022/08/23
@Auth ： Tianjian Jiang Apollo3D
@File ：show_ans.py
"""


import numpy as np
import pylab
import math
 

param_names = []
param_nums = []

#从.txt中读取数据 的函数
 
def loadData(fileName):
    inFile = open(fileName, 'r')#以只读方式打开某filename文件
    t = []
    diff_x = []
    diff_y = []
    sum_xy = []
    Max_param_score = -999999
    Max_param_list = []
    for line in inFile:
        
        paramSet = []
        trainingSet = line.split(',')#对于上面数据每一行，按' '把数据分开，这里是分成两部分
        Cur_param_len = len(trainingSet)
        Cur_param_score = float(trainingSet[Cur_param_len - 1])
        if Cur_param_score > Max_param_score:
            Max_param_score = Cur_param_score
            Max_param_list = trainingSet
            Max_param_list.pop()
        
      
    return (Max_param_score, Max_param_list)

# 从origin_params读取参数
def load_params(origin_params_path):
    global param_names, param_nums

    with open(origin_params_path, 'r') as file1:
        for param in file1:
            if param != '\n':
                param_list = param.split("\t")
                param_name = param_list[0]
                param_num = param_list[1][:-1]
                if 'E' in param_num:
                    param_num = '0'

                param_names.append(param_name)
                param_nums.append(eval(param_num))
    file1.close()
    return


def writeToFile(new_param_list):
    running_param_dic = dict(zip(param_names, new_param_list))

    out_file = open('optimized_params', 'w')
    for param_name, param_num in running_param_dic.items():
        out_file.write("{}\t{}\n".format(param_name, param_num))
    out_file.close()

x, y = loadData('opt_output')
load_params('origin_params')
writeToFile(y)
print('Done')

