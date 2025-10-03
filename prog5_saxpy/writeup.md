### 1.

Speedup results:
- saxpy ispc: 11.040 ms (26.995 GB/s, 3.623 GFLOPS)
- saxpy task ispc: 10.677 ms (27.913 GB/s, 3.746 GFLOPS)
  - speedup: 1.03x from use of tasks

There isn't much we can do with the code (i.e., adding more parallelism) to linearly increase speedup, given that there is so little computation and the program is basically memory bandwidth bound. Regardless of the number of tasks we throw at it, the cores spend most of their time waiting for data.

### 2.

Given that we're looping for a 20,000,000 element array, we know that we're going to be streaming the array through the cache since it will not fit in cache. Thus the bandwidth calculation is accounting for the slowest memory access case where there is a cache miss on `result[i]`. In a write-allocate cache this means we reading the cache line into memory, modifying the float in that line, and then when the cache line is evicted we will write that cache line back to main memory; thus we have 1) read x, 2) read y, 3) read result to cache, 4) write result to main memory later. 

### 3.

My results:
- [saxpy ispc]: 11.140 ms (26.752 GB/s, 3.591 GFLOPS)
- [saxpy task ispc]: 10.832 ms (27.514 GB/s, 3.693 GFLOPS)
  - 1.03x speedup from use of tasks
- [saxpy improved]: 8.629 ms (34.539 GB/s, 4.636 GFLOPS)
  - 1.29x speedup from improved
- [saxpy improved unrolled]: 8.102 ms (36.785 GB/s, 4.937 GFLOPS)
  - 1.38x speedup from improved unrolled

My improved version was an AVX2 implementation that uses `_mm256_stream_ps`. According to the docs the "non-temporal" memory hint that this provides says that the data will not be reused soon, so there is no need to cache it (i.e., we don't need to read a cache-line and modify it, we can write `result[i]` directly to memory). This turns the 4 memory operations mentioned above into 3. (Albeit, I needed to change the result array to be 32-byte aligned via `float* resultImproved = (float*)aligned_alloc(32, N * sizeof(float))` for this to work).

The unrolled version does a 4x unroll of the loop to get another 0.1x speedup. The idea was that - according to our slides - the myth machines are capable of at least 2 vector mul or 3 vector add instructions per cycle. By unrolling we're saying that there are 4 independent vector operations that can be run concurrently via ILP if there is a memory stall on one. In the assembly:

```cpp
  // before unroll:
  // .L3:
  //     vmovups	(%rsi,%rax), %ymm1   # vectorized load x[i]
  //     vfmadd213ps	(%rdx,%rax), %ymm2, %ymm1  # fused multiply-add y[i] * scale + x[i]
  //     vmovntps	%ymm1, (%rcx,%rax)  # non-temporal move result[i]
  //     addq	$32, %rax  # i += 8
  //     cmpq	%rax, %r8  # compare i to N
  //     jne	.L3

  // after unroll:
  // .L40:
  //     vmovups	(%rax), %ymm5
  //     vmovups	32(%rax), %ymm4
  //     subq	$-128, %rax
  //     subq	$-128, %rcx
  //     vmovups	-64(%rax), %ymm3
  //     vmovups	-32(%rax), %ymm2
  //     subq	$-128, %rdx
  //     vfmadd213ps	-128(%rcx), %ymm1, %ymm5
  //     vfmadd213ps	-96(%rcx), %ymm1, %ymm4
  //     vfmadd213ps	-64(%rcx), %ymm1, %ymm3
  //     vfmadd213ps	-32(%rcx), %ymm1, %ymm2
  //     vmovntps	%ymm5, -128(%rdx)
  //     vmovntps	%ymm4, -96(%rdx)
  //     vmovntps	%ymm3, -64(%rdx)
  //     vmovntps	%ymm2, -32(%rdx)
  //     cmpq	%r10, %rax
  //     jne	.L40
```
Once unrolled the destination registers (%ymm2 - %ymm5) are independent so on a super-scalar CPU their dependency chains can be executed in parallel.
