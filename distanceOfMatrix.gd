var M: Array = [
	PackedInt32Array([1, 1, 0, 1]),
	PackedInt32Array([1, 0, 1, 1])
]


func multiply(a: PackedInt32Array, b: PackedInt32Array, t: int, mod: int):
	var e=4*(t-1)
	var x1 = (a[0] + a[3]) * (b[e+0] + b[e+3])
	var x2 = (a[2] + a[3]) * b[e+0]
	var x3 = a[0] * (b[e+1] - b[e+3])
	var x4 = a[3] * (b[e+2] - b[e+0])
	var x5 = (a[0] + a[1]) * b[e+3]
	var x6 = (a[2] - a[0]) * (b[e+0] + b[e+1])
	var x7 = (a[1] - a[3]) * (b[e+2] + b[e+3])
	b[e+4] = (x1 + x4 - x5 + x7) % mod
	b[e+5] = (x3 + x5) % mod
	b[e+6] = (x2 + x4) % mod
	b[e+7] = (x1 + x3 - x2 + x6) % mod

func backtrack(t: int, mod: int, wlength: int, ce: PackedInt32Array, x: PackedInt32Array):
	if t >= wlength:
		var e:int = 4*(t - 1)
		if (ce[e+0] == 1 && ce[e+1] == 0 && ce[e+2] == 0 && ce[e+3] == 1) || (ce[e+0] == mod - 1 && ce[e+1] == 0 && ce[e+2] == 0 && ce[e+3] == mod - 1):
			return true
	else:
		var i=0;
		while i<2:
			x[t] = i
			if t == 0:
				ce[0]=M[i][0]
				ce[1]=M[i][1]
				ce[2]=M[i][2]
				ce[3]=M[i][3]
			else:
				multiply(M[i], ce, t, mod)
			if backtrack(t + 1, mod, wlength, ce, x):
				return true
			i+=1
	return false

func process(mod: int):
	print("\n", mod)
	var wlength: int = 0
	while true:
		wlength += 1

		var x: PackedInt32Array = PackedInt32Array()
		var ce: PackedInt32Array = PackedInt32Array()
		x.resize(wlength)
		ce.resize(wlength*4)
		x.fill(0)
		ce.fill(0)
		var result: bool = backtrack(0, mod, wlength, ce, x)
		prints(mod,wlength)
		if result:
			if wlength < mod:
				print("length: ", wlength)
				print(x)
				print(ce)
			break

func main():
	var start: int = 80
	var end: int = 81
	for i in range(start, end):
		process(i)
