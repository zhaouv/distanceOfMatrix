type Matrix = [i32; 4];

const MT: [i32; 4] = [1, 1, 0, 1];
const MTS: [i32; 4] = [1, 0, 1, 1];
const M: [[i32; 4]; 2] = [MT, MTS];
const IDENTITY: [i32; 4] = [1, 0, 0, 1];

fn multiply(a: &Matrix, b: &Matrix, mod_: i32) -> Matrix {
    let x1 = (a[0] + a[3]) * (b[0] + b[3]);
    let x2 = (a[2] + a[3]) * b[0];
    let x3 = a[0] * (b[1] - b[3]);
    let x4 = a[3] * (b[2] - b[0]);
    let x5 = (a[0] + a[1]) * b[3];
    let x6 = (a[2] - a[0]) * (b[0] + b[1]);
    let x7 = (a[1] - a[3]) * (b[2] + b[3]);
    let c11 = x1 + x4 - x5 + x7;
    let c12 = x3 + x5;
    let c21 = x2 + x4;
    let c22 = x1 + x3 - x2 + x6;
    [c11 % mod_, c12 % mod_, c21 % mod_, c22 % mod_]
}

fn backtrack(
    t: usize,
    mod_: i32,
    wlength: usize,
    ce: &mut [Matrix],
    x: &mut Vec<i32>,
) -> bool {
    if t >= wlength {
        let e = &ce[t - 1];
        if *e == IDENTITY || *e == [mod_ - 1, 0, 0, mod_ - 1] {
            return true;
        }
    } else {
        for i in 0..=1usize {
            x[t] = i as i32;
            if t == 0 {
                ce[t] = M[i];
            } else {
                ce[t] = multiply(&M[i], &ce[t - 1], mod_);
            }
            if backtrack(t + 1, mod_, wlength, ce, x) {
                return true
            }
        }
    }
    false
}

fn process(mod_: i32) {
    println!("\n{}", mod_);

    let mut wlength = 0;
    loop {
        wlength += 1;

        let mut x = vec![0i32; wlength];
        let mut ce = vec![[0i32; 4]; wlength];

        let result = backtrack(0, mod_, wlength, &mut ce, &mut x);

        if result {
            if (wlength as i32) < mod_ {
                println!("length: {}", wlength);
                println!("{:?}", x);
                println!("{:?}", ce);
            }
            break;
        }
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let (start, end) = if args.len() >= 3 {
        (args[1].parse().expect("Failed to parse start"), args[2].parse().expect("Failed to parse end"))
    } else {
        (400, 405)
    };
    for i in start..end {
        process(i);
    }
}