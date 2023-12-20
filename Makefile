all:
	g++ -Wall  distanceOfMatrix.cc -O3 -o run
	loadenv.cmd
	cl.exe distanceOfMatrix.cc /O2 /Ferun2.exe
c:
	./run 400 405
js:
	node distanceOfMatrix_1DArray.js
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
