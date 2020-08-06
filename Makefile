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
