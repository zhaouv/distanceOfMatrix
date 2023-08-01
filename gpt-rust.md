```
root@iZuf60or18nx3ag81phap8Z:~/home/rustd# ./c 400 401

400
length: 28
[0,0,0,0,1,0,1,0,1,1,0,1,0,0,1,1,1,1,0,1,0,1,0,0,1,0,1,1]
[[[1,1],[0,1]],
[[1,2],[0,1]],
[[1,3],[0,1]],
[[1,4],[0,1]],
[[1,4],[1,5]],
[[2,9],[1,5]],
[[2,9],[3,14]],
[[5,23],[3,14]],
[[5,23],[8,37]],
[[5,23],[13,60]],
[[18,83],[13,60]],
[[18,83],[31,143]],
[[49,226],[31,143]],
[[80,369],[31,143]],
[[80,369],[111,112]],
[[80,369],[191,81]],
[[80,369],[271,50]],
[[80,369],[351,19]],
[[31,388],[351,19]],
[[31,388],[382,7]],
[[13,395],[382,7]],
[[13,395],[395,2]],
[[8,397],[395,2]],
[[3,399],[395,2]],
[[3,399],[398,1]],
[[1,0],[398,1]],
[[1,0],[399,1]],
[[1,0],[0,1]]]
root@iZuf60or18nx3ag81phap8Z:~/home/rustd# ./d 400 401

400
length: 28
[0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1]
[1, 1, 0, 1]
[1, 2, 0, 1]
[1, 3, 0, 1]
[1, 4, 0, 1]
[1, 4, 1, 5]
[2, 9, 1, 5]
[2, 9, 3, 14]
[5, 23, 3, 14]
[5, 23, 8, 37]
[5, 23, 13, 60]
[18, 83, 13, 60]
[18, 83, 31, 143]
[49, 226, 31, 143]
[80, 369, 31, 143]
[80, 369, 111, 112]
[80, 369, 191, 81]
[80, 369, 271, 50]
[80, 369, 351, 19]
[31, 388, 351, 19]
[31, 388, 382, 7]
[13, 395, 382, 7]
[13, 395, 395, 2]
[8, 397, 395, 2]
[3, 399, 395, 2]
[3, 399, 398, 1]
[1, 0, 398, 1]
[1, 0, 399, 1]
[1, 0, 0, 1]
root@iZuf60or18nx3ag81phap8Z:~/home/rustd#
```


  13.542 ms (44 allocations: 1.86 KiB)
Process(`./d 20 21`, ProcessExited(0))
  2.411 ms (44 allocations: 1.86 KiB)
Process(`./c 20 21`, ProcessExited(0))
  49.228 ms (44 allocations: 1.86 KiB)
Process(`./d 30 31`, ProcessExited(0))
  5.497 ms (44 allocations: 1.86 KiB)
Process(`./c 30 31`, ProcessExited(0))
  360.886 ms (44 allocations: 1.86 KiB)
Process(`./d 35 36`, ProcessExited(0))
  26.543 ms (44 allocations: 1.86 KiB)
Process(`./c 35 36`, ProcessExited(0))

rustc -C opt-level=3 -C target-cpu=native -C lto -C codegen-units=1 d.rs

  68.467 ms (44 allocations: 1.86 KiB)
Process(`./d 35 36`, ProcessExited(0))

  17.498 ms (44 allocations: 1.86 KiB)
Process(`./c 40 41`, ProcessExited(0))
  44.468 ms (44 allocations: 1.86 KiB)
Process(`./d 40 41`, ProcessExited(0))
  10.813 ms (44 allocations: 1.86 KiB)
Process(`./e 40 41`, ProcessExited(0))

  10.724 s (44 allocations: 1.86 KiB)
Process(`./e 400 401`, ProcessExited(0))
  36.920 s (44 allocations: 1.86 KiB)
Process(`./d 400 401`, ProcessExited(0))
  12.674 s (44 allocations: 1.86 KiB)
Process(`./c 400 401`, ProcessExited(0))

clang++  -Wall  c.cc -O3 -o cl
  11.647 s (44 allocations: 1.86 KiB)
Process(`./cl 400 401`, ProcessExited(0))
