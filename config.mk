# this file contains some necessary configuration hacks for the main makefile

# The following conditional statement appends "-std=gnu99" to CFLAGS when the
# compiler does not define __STDC_VERSION__.  The idea is that many older
# compilers are able to compile standard C when given that option.
# This hack seems to work for all versions of gcc, clang and icc.
CVERSION := $(shell $(CC) $(CFLAGS) -dM -E - < /dev/null | grep __STDC_VERSION)
ifeq ($(CVERSION),)
CFLAGS := $(CFLAGS) -std=gnu99
endif

# use OpenMP only if not clang
ifeq ($(shell $(CC) $(CFLAGS) -v 2>&1 | grep -c "clang"), 0)
CFLAGS := $(CFLAGS) -fopenmp
endif
