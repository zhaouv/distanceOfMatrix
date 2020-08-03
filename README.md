# distance of matrix

个人用来衡量语言硬跑递归能力的例子

背景是矩阵  
T=[1 1;0 1]  
Ts=[1 0;1 1]  

在 Mod n 的含义下找到最短的T和Ts构成的序列, 使得  
T * T * Ts ... = [1 0;0 1] 或 [n-1 0;0 n-1]  
左侧每个矩阵都是T或Ts, 每次乘积后把四个数取mod到0~n-1

# 大概耗时

在个人电脑上(只看400的时间)

c 10s左右  
gcc version 6.3.0 (MinGW.org GCC-6.3.0-1)

js 30s左右
node v10.15.3

python 搞笑的 numpy也不适合这个场景 还是要靠c来拯救python
Python 3.6.10 :: Anaconda, Inc.

julia 60s左右
julia version 1.4.1