all:
	g++ -Wall  distanceOfMatrix.cc -O3 -o run
c:
	run 400 405
js:
	node distanceOfMatrix.js
python:
	python distanceOfMatrix.py
clean:
	@echo nothing to clean
