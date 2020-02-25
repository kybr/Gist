.SUFFIXES:

CXX=
CXX += c++
CXX += -std=c++11
CXX += -Wall
CXX += -DUSE_KISS_FFT
//CXX += -DUSE_ACCELERATE_FFT 
//CXX += -DUSE_FFTW

SRC=
SRC += src/pitch/Yin.cpp
SRC += src/mfcc/MFCC.cpp
SRC += src/core/CoreFrequencyDomainFeatures.cpp
SRC += src/core/CoreTimeDomainFeatures.cpp
SRC += src/onset-detection-functions/OnsetDetectionFunction.cpp
SRC += src/Gist.cpp
SRC += src/fft/WindowFunctions.cpp
//SRC += src/fft/AccelerateFFT.cpp

INC=
INC += -Isrc/
INC += -Isrc/core/
INC += -Isrc/fft/
INC += -Isrc/mfcc/
INC += -Isrc/onset-detection-functions/
INC += -Isrc/pitch/
INC += -Ilibs/kiss_fft130/ # if you want to use KissFFT

LIB=
//LIB += -framework Accelerate
//LIB += -lfftw3

OBJ = $(patsubst %.cpp,%.o,$(SRC))
OBJ += libs/kiss_fft130/kiss_fft.o # if you want to use KissFFT

# find all the .cpp files and make a list of those, but with the .exe extension
CPP = $(wildcard *.cpp)
EXE = $(patsubst %.cpp,%.exe,$(CPP))

# build all the .cpp into .exe
_: $(EXE)

%.exe: %.o libgist.a
	$(CXX) $(INC) -o $@ $^

%.o: %.cpp
	$(CXX) $(INC) -c -o $@ $^

%.o: %.c
	$(CXX) $(INC) -c -o $@ $^

libgist.a: $(OBJ)
	ar -rc $@ $^

clean:
	rm -f $(OBJ) *.exe libgist.a
