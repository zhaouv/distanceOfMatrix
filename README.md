# distance of matrix

个人用来衡量语言硬跑回溯能力的例子

背景是矩阵  
T=[1 1;0 1]  
Ts=[1 0;1 1]  

在 Mod n 的含义下找到最短的T和Ts构成的序列, 使得  
T * T * Ts ... = [1 0;0 1] 或 [n-1 0;0 n-1]  
左侧每个矩阵都是T或Ts, 每次乘积后把四个数取mod到0~n-1

# usage

msvc 需要修改 loadenv.cmd, 改为相应环境的vcvars批处理  
```shell
make
make time
```

# 大概耗时

在个人电脑上(只看400的时间)

c 10.089 s (57 allocations: 2.14 KiB)   
gcc version 6.3.0 (MinGW.org GCC-6.3.0-1)  
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.16.27042 版
Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64\cl.exe

julia 14.002 s (968 allocations: 57.98 KiB)  
julia version 1.4.1

js 21.895 s (62 allocations: 2.69 KiB)  
node v10.15.3

python 搞笑的 numpy也不适合这个场景 还是要靠c来拯救python  
Python 3.6.10 :: Anaconda, Inc.

- - -

新增  
rust 略快于c++  
godot 显著慢于python  
csharp 比c++慢10倍大概  
