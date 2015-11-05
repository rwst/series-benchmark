g++ -O3 -std=c++11 -o flint flint.cpp -lflint -lstdc++ -lpthread
g++ -O3 -std=c++11 piranha.cpp -lgmp -lmpfr -lpthread
gfortran -O3 -march=native -ffast-math -funroll-loops -o double double.f90
