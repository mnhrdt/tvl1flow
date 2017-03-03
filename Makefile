OMPFLAGS=-fopenmp

# use OpenMP only if not clang
ifeq ($(shell $(CC) $(CFLAGS) -v 2>&1 | grep -c "clang"), 0)
CFLAGS := $(CFLAGS) -fopenmp
endif

tvl1flow: main.c tvl1flow_lib.c bicubic_interpolation.c mask.c zoom.c iio.o backflow.c
	$(CC) $(CFLAGS) $(OMPFLAGS) -o tvl1flow main.c iio.o -lpng -ljpeg -ltiff -lm
	$(CC) $(CFLAGS) $(OMPFLAGS) -o backflow backflow.c iio.o -lpng -ljpeg -ltiff -lm

iio.o: iio.c
	$(CC) $(CFLAGS) -DNDEBUG -D_GNU_SOURCE -c iio.c

clean:
	rm -f iio.o main.o tvl1flow
