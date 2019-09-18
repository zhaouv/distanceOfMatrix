def process(mod):
    print('\n'+str(mod))

    def multiply(a, b):
        x1 = (a[0][0] + a[1][1]) * (b[0][0] + b[1][1])
        x2 = (a[1][0] + a[1][1]) * b[0][0]
        x3 = a[0][0] * (b[0][1] - b[1][1])
        x4 = a[1][1] * (b[1][0] - b[0][0])
        x5 = (a[0][0] + a[0][1]) * b[1][1]
        x6 = (a[1][0] - a[0][0]) * (b[0][0] + b[0][1])
        x7 = (a[0][1] - a[1][1]) * (b[1][0] + b[1][1])
        c11 = x1 + x4 - x5 + x7
        c12 = x3 + x5
        c21 = x2 + x4
        c22 = x1 + x3 - x2 + x6
        return [[c11 % mod, c12 % mod], [c21 % mod, c22 % mod]]

    wlength = 0
    result = [False]
    while 1:
        wlength+=1

        x = [0]*wlength
        ce = [[]]*wlength
        mt = [[1, 1], [0, 1]]
        mts = [[1, 0], [1, 1]]
        m = [mt, mts]
        ce[-1] = [[1, 0], [0, 1]]
        
        def backtrack(t,result):
            if result[0]:return
            if t >= wlength :
                e = ce[t - 1]
                if (e[0][0] == 1 and e[0][1] == 0 and e[1][0] == 0 and e[1][1] == 1) or (e[0][0] == mod - 1 and e[0][1] == 0 and e[1][0] == 0 and e[1][1] == mod - 1) :
                    result[0] = True
            else:
                for i in [0,1]:
                    x[t] = i
                    ce[t] = multiply(m[i], ce[t - 1])
                    backtrack(t + 1,result)
                    if result[0]: return
        backtrack(0,result)
        if result[0]:
            if wlength < mod:
                print('length: ' + str(wlength))
                print(x)
                print(ce)
            break

for i in range(400,405):
    process(i)



