all:
	g++ -Wall  distanceOfMatrix.cc -O3 -o run
c:
	./run 400 405
js:
	node distanceOfMatrix.js
python:
	python distanceOfMatrix.py
numpy:
	python distanceOfMatrix_numpy.py
julia:
	julia distanceOfMatrix.jl
test:
	julia distanceOfMatrix.jl test
time:
	julia distanceOfMatrix.jl time
clean:
	@echo nothing to clean
