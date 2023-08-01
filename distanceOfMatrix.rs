use std::convert::TryInto;

struct Matrix {
    mat: Vec<Vec<i32>>,
}

impl Matrix {
    fn new() -> Matrix {
        Matrix {
            mat: vec![
                vec![1, 1, 0, 1],
                vec![1, 0, 1, 1],
            ]
        }
    }
}

fn multiply(a: &[i32], b: &[i32], modulus: i32, r: &mut [i32]) {
    let x1 = (a[0] + a[3]) * (b[0] + b[3]);
    let x2 = (a[2] + a[3]) * b[0];
    let x3 = a[0] * (b[1] - b[3]);
    let x4 = a[3] * (b[2] - b[0]);
    let x5 = (a[0] + a[1]) * b[3];
    let x6 = (a[2] - a[0]) * (b[0] + b[1]);
    let x7 = (a[1] - a[3]) * (b[2] + b[3]);
    r[0] = (x1 + x4 - x5 + x7)%modulus;
    r[1] = (x3 + x5)%modulus;
    r[2] = (x2 + x4)%modulus;
    r[3] = (x1 + x3 - x2 + x6)%modulus;
}

fn backtrack(t: usize, modulus: i32, wlength: usize, m: &Matrix, x: &mut [i32], ce: &mut Vec<Vec<i32>>) -> bool {
    if t >= wlength {
        let e = &ce[t - 1];
        if (e[0] == 1 && e[1] == 0 && e[2] == 0 && e[3] == 1) || (e[0] == modulus - 1 && e[1] == 0 && e[2] == 0 && e[3] == modulus - 1) {
            return true;
        }
    } else {
        for i in 0..2 {
            x[t] = i as i32;
            let mi = m.mat[i].clone();
            if t == 0 {
                ce[t] = mi.clone();
            } else {
                let temp = ce[t - 1].clone();
                multiply(&mi, &temp, modulus, &mut ce[t]);
            }
            if backtrack(t + 1, modulus, wlength, m, x, ce) {
                return true;
            }
        }
    }
    false
}

fn process(modulus: i32) {
    println!("\n{}", modulus);

    let mut wlength = 0;
    let m = Matrix::new();
    loop {
        wlength += 1;

        let mut x = vec![0; wlength];
        let mut ce = vec![vec![0; 4]; wlength];

        let result = backtrack(0, modulus, wlength, &m, &mut x, &mut ce);

        if result {
            if wlength < modulus.try_into().unwrap() {
                println!("length: {}", wlength);
                println!("{:?}", x);
                for mat in ce.iter() {
                    println!("{:?}", mat);
                }
            }
        }

        if result {
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
