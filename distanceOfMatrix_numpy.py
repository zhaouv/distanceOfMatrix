import numpy as np

def process(mod):
    print('\n'+str(mod))

    def multiply(a, b):
        return a.dot(b) % mod

    wlength = 0
    
    mt = np.array([[1, 1], [0, 1]],dtype='int32')
    mts = np.array([[1, 0], [1, 1]],dtype='int32')
    m = [mt, mts]

    M_I=np.array([[1, 0], [0, 1]],dtype='int32')
    M_minusI=np.array([[mod-1, 0], [0, mod-1]],dtype='int32')
    while 1:
        wlength+=1
        result = [False]

        x = [0]*wlength
        ce = [[]]*wlength
        ce[-1] = np.array([[1, 0], [0, 1]],dtype='int32')
        
        def backtrack(t,result):
            if result[0]:return
            if t >= wlength :
                e = ce[t - 1]
                if (e==M_I).all() or (e==M_minusI).all() :
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

for i in range(80,81):
    process(i)



