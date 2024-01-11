all:
	g++ -Wall  distanceOfMatrix.cc -O3 -o run
	loadenv.cmd
	cl.exe distanceOfMatrix.cc /O2 /Ferun2.exe
c:
	./run 400 405
js:
	node distanceOfMatrix_1DArray.js 400 401
python:
	python distanceOfMatrix.py
julia:
	julia distanceOfMatrix.jl
test:
	julia distanceOfMatrix.jl test
time:
	julia distanceOfMatrix.jl time
clean:
	del *.obj
rust:
	rustc -C opt-level=3 -C target-cpu=native -C lto -C codegen-units=1 distanceOfMatrix_f.rs
csharp:
	sudo docker run --rm -it -v `pwd`:/w mono:6.12.0.182 bash -c 'cd /w&&csc -out:cs1.exe distanceOfMatrix_f.cs'
bun:
	sudo docker run --rm -it --init --ulimit memlock=-1:-1 -v `pwd`:/home/bun/app oven/bun:1.0.18 run distanceOfMatrix_1DArray.js 400 401
wasm:
	rustc -C opt-level=3 -C target-cpu=native -C lto -C codegen-units=1 distanceOfMatrix_f.rs --target wasm32-wasi
	time wasmedge distanceOfMatrix_f.wasm 80 81
	time wasmtime distanceOfMatrix_f.wasm 400 401
wasm_py:
	rustc -C opt-level=3 -C target-cpu=native -C lto -C codegen-units=1 distanceOfMatrix_f_export.rs --target wasm32-wasi
	python3 distanceOfMatrix_f_export_call.py