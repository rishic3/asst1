### 1.

Speedup results:
- serial: 660.379 ms
- ispc: 151.265 ms (4.37x speedup)
- task ispc: 20.852 ms (31.67x speedup)

### 2.

To maximize speedup, we want two things:
- Make the values uniform to maximize SIMD coherence
- Maximize the required iterations to make compute time dominate memory access time, thus maximizing the benefit of parallelism 

By setting 
```cpp
values[i] = 2.999999f;
```
we see the following speedups:
- serial: 3283.538 ms
- ispc: 475.734 ms (6.92x speedup)
- task ispc: 69.015 ms (47.64x speedup)

The maximum theoretical speedup for plain ISPC without tasks is 8x given the SIMD width, and this approach nears this. The task approach can further improve the SIMD approach by another 8x given the 8 cores, and this approach (8 * 6.92 = ~55x) nears this number as well, while experiencing some overhead of task scheduling.

### 3.

To minimize speedup, we do the opposite of (2):
- Maximize SIMD divergence (e.g., introduce a very skewed workload to one lane)
- Minimize the required iterations to lower compute time to memory access time ratio

By setting
```cpp
values[i] = (i % 8 == 0) ? 2.999999f : 1.0f;
```
i.e. one in every 8 lanes to ~2.99 (~35 iterations) and and all other lines to 1 (no iterations), we see these numbers:
- serial: 434.961 ms
- ispc: 475.436 ms (0.91x speedup)
- task ispc: 69.001 ms (6.30x speedup)

In the ISPC case, given that the other 7 lanes need to wait for the slowest lane to complete, and the 7 lanes finish instantaneously, the 8-wide SIMD operations are basically running 20,000,000 / 8 = 2,500,000 calculations of sqrt(2.999999f) serially. This is basically what the serial implementation is doing, but with the additional overhead of SIMD masking operations, hence the slightly lower runtime.

In the task ISPC case, we still get roughly 8x speedup over the ISPC case, since we are now running the same workload as the ISPC case (still suffering from SIMD divergence) but split in parallel amongst potentially 8 cores.

### 4.
Done. Results:
- serial: 654.863 ms
- ispc: 153.029 ms (4.28x speedup)
- task ispc: 21.164 ms (30.94x speedup)
- AVX2: 134.976 ms (4.85x speedup)
