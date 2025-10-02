### 1.

Done.

### 2.

See graph. The speedup is not linear for view 1, but is linear for view 2.

### 3. 

When adding measurements per thread, there is apparent skew. 
Taking 3 threads for instance, thread 1 - the thread that computes the middle horizontal section of the image - is 3x slower than threads 0 and 2. This makes sense looking at view 1 - the center strip of the image contains much more of the fractal boundary of the set (the small middle circle along with its boundary), requiring much more computation. 

View 2 has less, but still some of this problem - there is a slight runtime skew with thread 0 being assigned the group of fractals at the top, but the rest of the image is more evenly distributed.

### 4.

Done. Stride by numThreads so that now, no thread is computing a dense contiguous block of fractals (which causes skew), and rather the rows are evenly split up.

### 5.

There is actually a slight slowdown with 16 threads (7.22x with 8 threads vs 7.00x with 16 threads). This makes sense as we've already maxed out the parallelism of the hardware and now we are just adding more overhead of maintaining thread context.
