# default CFLAGS to use when none is given:
CFLAGS ?= -march=native -O3

# -- end of user-editable part

# required libraries
LDLIBS = -lpng -ljpeg -ltiff -lm

# configuration hacks for older compilers or those without openmp
include config.mk

# rules
default: tvl1flow backflow
backflow: backflow.c iio.o
tvl1flow: main.c tvl1flow_lib.c bicubic_interpolation.c mask.c zoom.c iio.o
	$(CC) $(CFLAGS) -o $@ main.c iio.o $(LDLIBS)

# bureaucracy
clean:
	$(RM) iio.o tvl1flow backflow
.PHONY: default clean
