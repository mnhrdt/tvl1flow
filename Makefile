# default CFLAGS to use when none is given
CFLAGS ?= -march=native -O3

# -- end of user-editable part


# required libraries
LDLIBS = -lpng -ljpeg -ltiff -lm


# The following conditional statement appends "-std=gnu99" to CFLAGS when the
# compiler does not define __STDC_VERSION__.  The idea is that many older
# compilers are able to compile standard C when given that option.
# This hack seems to work for all versions of gcc, clang and icc.
CVERSION := $(shell $(CC) -dM -E - < /dev/null | grep __STDC_VERSION__)
ifeq ($(CVERSION),)
CFLAGS := $(CFLAGS) -std=gnu99
endif

# use OpenMP only if not clang
ifeq ($(shell $(CC) $(CFLAGS) -v 2>&1 | grep -c "clang"), 0)
CFLAGS := $(CFLAGS) -fopenmp
endif


default: tvl1flow backflow

tvl1flow: main.c tvl1flow_lib.c bicubic_interpolation.c mask.c zoom.c iio.o
	$(CC) $(CFLAGS) -o $@ main.c iio.o $(LDLIBS)

backflow: backflow.c iio.o

clean:
	$(RM) iio.o tvl1flow backflow
