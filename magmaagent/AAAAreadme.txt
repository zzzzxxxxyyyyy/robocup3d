run_opt.sh：启动optimization训练
Train-mode.sh: 切换至训练模式，java需要更改才能使用，修改方法见csdn
opt_output：输出的参数，如果中途出于各种原因临时停止了训练，可在此找到训练过程所有参数以及评分
origin_params: 初始参数
running_params：正在测试的参数
outx,y,z等：由Traindecision输出的阶段性测试评分，用于与脚本沟通
