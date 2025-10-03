### 1.

Initial results:
```text
Running K-means with: M=1000000, N=100, K=3, epsilon=0.100000
[Total Time]: 8999.488 ms
```

### 2.

Getting the total cycles spent in each method, we see:
```text
total computeAssignments: 6157.116 ms
total computeCentroids: 988.063 ms
total computeCost: 1839.598 ms
[Total Time]: 8984.846 ms
```

The first think we can do is parallelize computeAssignments; noting that M >> N >> k, we want to parallelize across rows so that each thread computes the assignments for a chunk of rows.

After parallelizing like so:
```cpp
void computeAssignmentsThread(WorkerArgs *const args, int tid, int num_threads, double* minDist) {
  int chunk_size = args->M / num_threads;
  int start_row = tid * chunk_size;
  // last row takes remainder
  if (tid == num_threads-1) {
    chunk_size += args->M % num_threads;
  }
  int end_row = start_row + chunk_size;
  
  for (int k = args->start; k < args->end; ++k) {
    for (int m = start_row; m < end_row; ++m) {
      double d = dist(&args->data[m * args->N],
                      &args->clusterCentroids[k * args->N], args->N);
      if (d < minDist[m]) {
        minDist[m] = d;
        args->clusterAssignments[m] = k;
      }
    }
  }
}

/**
 * Assigns each data point to its "closest" cluster centroid.
 */
void computeAssignments(WorkerArgs *const args) {

  static constexpr int NUM_THREADS = 8;

  double *minDist = new double[args->M];
  
  // Initialize arrays
  for (int m =0; m < args->M; m++) {
    minDist[m] = 1e30;
    args->clusterAssignments[m] = -1;
  }

  // launch NUM_THREADS - 1 workers
  std::thread workers[NUM_THREADS];
  for (int i = 1; i < NUM_THREADS; ++i) {
    workers[i] = std::thread(computeAssignmentsThread, args, i, NUM_THREADS, minDist);
  }

  computeAssignmentsThread(args, 0, NUM_THREADS, minDist);

  for (int i = 1; i < NUM_THREADS; ++i) {
    workers[i].join();
  }

  free(minDist);
}
```

We get a ~1.8x speedup:
```text
total computeAssignments: 2051.356 ms
total computeCentroids: 1000.126 ms
total computeCost: 1850.304 ms
[Total Time]: 4901.976 ms
```
with a roughly ~3x speedup to the computeAssignments part. But 3x isn't great given that we're running 8 threads. So the other thing to note is that the outer loop strides over k while the inner loop strides over m; with m >> k, this means that we're making k passes through all m data points, i.e., we're streaming m through the cache three separate times. We can avoid 3x the memory accesses by simply switching the order of the loops, such that the cache line for m remains in cache for all 3 iterations of k. 

With this code, improving the cache locality:
```cpp
void computeAssignmentsThread(WorkerArgs *const args, int tid, int num_threads, double* minDist) {
  int chunk_size = args->M / num_threads;
  int start_row = tid * chunk_size;
  // last row takes remainder
  if (tid == num_threads-1) {
    chunk_size += args->M % num_threads;
  }
  int end_row = start_row + chunk_size;
  
  for (int m = start_row; m < end_row; ++m) {
    for (int k = args->start; k < args->end; ++k) {
      double d = dist(&args->data[m * args->N],
                      &args->clusterCentroids[k * args->N], args->N);
      if (d < minDist[m]) {
        minDist[m] = d;
        args->clusterAssignments[m] = k;
      }
    }
  }
}
```

We get another 2x speedup on top of computeAssignments, and an overall ~2.35x speedup:
```text
total computeAssignments: 959.077 ms
total computeCentroids: 997.582 ms
total computeCost: 1852.750 ms
[Total Time]: 3809.482 ms
```
