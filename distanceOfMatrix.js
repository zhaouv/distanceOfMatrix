let process_ = function (mod) {
    console.log('\n'+mod)

    let multiply = function (a, b,r) {
        let x1 = (a[0][0] + a[1][1]) * (b[0][0] + b[1][1])
        let x2 = (a[1][0] + a[1][1]) * b[0][0]
        let x3 = a[0][0] * (b[0][1] - b[1][1])
        let x4 = a[1][1] * (b[1][0] - b[0][0])
        let x5 = (a[0][0] + a[0][1]) * b[1][1]
        let x6 = (a[1][0] - a[0][0]) * (b[0][0] + b[0][1])
        let x7 = (a[0][1] - a[1][1]) * (b[1][0] + b[1][1])
        let c11 = x1 + x4 - x5 + x7
        let c12 = x3 + x5
        let c21 = x2 + x4
        let c22 = x1 + x3 - x2 + x6
        r[0][0]=c11%mod
        r[0][1]=c12%mod
        r[1][0]=c21%mod
        r[1][1]=c22%mod
        // return [[c11 % mod, c12 % mod], [c21 % mod, c22 % mod]]
    }

    let wlength = 0
    while (1) {
        ++wlength

        let x = new Array(wlength)
        // let ce = new Array(wlength)
        let ce = Array.from({length:wlength}).map(v=>[[],[]])
        let mt = [[1, 1], [0, 1]]
        let mts = [[1, 0], [1, 1]]
        let m = [mt, mts]
        ce[-1] = [[1, 0], [0, 1]]
        let result = null
        function backtrack(t) {
            if (result) return;
            if (t >= wlength) {
                let e = ce[t - 1]
                if (e[0][0] == 1 && e[0][1] == 0 && e[1][0] == 0 && e[1][1] == 1 || e[0][0] == mod - 1 && e[0][1] == 0 && e[1][0] == 0 && e[1][1] == mod - 1) {
                    result = { x: Array.from(x), m: Array.from(ce) }
                }
            } else {
                for (let i = 0; i <= 1; i++) {
                    x[t] = i;
                    multiply(m[i], ce[t - 1],ce[t])
                    backtrack(t + 1);
                }
            }
        }
        backtrack(0)
        if (result) {
            if (wlength < mod) {
                console.log('length: ' + wlength)
                console.log(result.x)
                console.log(JSON.stringify(result.m).replace(/\]\],\[\[/g,']],\n[['))
            }
            break;
        }
    }
}

if (typeof require !== 'undefined' && require.main === module) {

    if (process.argv.length>=4) {
        let start=~~process.argv[2]
        let end=~~process.argv[3]
        Array.from({ length: end-start }).forEach((e, i) => {
            let v = i + start
            process_(v)
        });
    } else
    Array.from({ length: 5 }).forEach((e, i) => {
        let v = i + 400
        process_(v)
    });
}
