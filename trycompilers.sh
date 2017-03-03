for c in "cc" "gcc" "clang" "gcc-4.8" "icc"; do
for f in "-Wall -Wextra -Werror" "-O3 -march=native -DNDEBUG"; do
	make CC="$c" CFLAGS="$f" clean default
done
done
