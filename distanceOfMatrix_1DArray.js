let process_ = function (mod) {
    console.log('\n'+mod)

    let multiply = function (a, b,t,mod) { 
        let e=4*(t-1)
        let x1 = (a[0] + a[3]) * (b[e+0] + b[e+3])
        let x2 = (a[2] + a[3]) * b[e+0]
        let x3 = a[0] * (b[e+1] - b[e+3])
        let x4 = a[3] * (b[e+2] - b[e+0])
        let x5 = (a[0] + a[1]) * b[e+3]
        let x6 = (a[2] - a[0]) * (b[e+0] + b[e+1])
        let x7 = (a[1] - a[3]) * (b[e+2] + b[e+3])
        let c11 = x1 + x4 - x5 + x7
        let c12 = x3 + x5
        let c21 = x2 + x4
        let c22 = x1 + x3 - x2 + x6
        b[e+4]=c11%mod
        b[e+5]=c12%mod
        b[e+6]=c21%mod
        b[e+7]=c22%mod
    }

    let wlength = 0
    while (1) {
        ++wlength

        let x = new Array({length:wlength}).map(v=>0)
        // let ce = new Array(wlength)
        let ce = Array.from({length:wlength*4}).map(v=>0)
        let mt = [1, 1, 0, 1]
        let mts = [1, 0, 1, 1]
        let m = [mt, mts]
        let results = [false]
        function backtrack(t,x,ce,m,mod,wlength,results) {
            if (results[0]) return;
            if (t >= wlength) {
                let e = 4*(t - 1)
                if (ce[e+0] == 1 && ce[e+1] == 0 && ce[e+2] == 0 && ce[e+3] == 1 || ce[e+0] == mod - 1 && ce[e+1] == 0 && ce[e+2] == 0 && ce[e+3] == mod - 1) {
                    results[0] = { x: Array.from(x), m: Array.from(ce) }
                }
            } else {
                for (let i = 0; i <= 1; i++) {
                    x[t] = i;
                    if (t==0) {
                        ce[0]=m[i][0]
                        ce[1]=m[i][1]
                        ce[2]=m[i][2]
                        ce[3]=m[i][3]
                    } else {
                        multiply(m[i], ce,t,mod)
                    }
                    backtrack(t + 1,x,ce,m,mod,wlength,results);
                    if (results[0]) return;
                }
            }
        }
        backtrack(0,x,ce,m,mod,wlength,results)
        if (results[0]) {
            if (wlength < mod) {
                console.log('length: ' + wlength)
                console.log(results[0].x)
                console.log(JSON.stringify(
                    results[0].m
                    .map((v,i,a)=>[[v,a[i+1]],[a[i+2],a[i+3]]])
                    .filter((v,i)=>i%4==0)
                ).replace(/\]\],\[\[/g,']],\n[['))
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
