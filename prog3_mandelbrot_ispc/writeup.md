## Part 1

### 1.

I would expect a maximum speedup of 8x, given that ideally we process 8 pixels concurrently in an 8-wide vector instruction. 
Observed speedups:
   - on view 1: ~5.02x
   - on view 2: ~4.32x

We know that pixels have variable iteration counts - since some quickly converge into or out of the set, while others (the fractal boundaries) require many iterations to determine their set membership. Mixed regions where some pixels are clearly in the set and others are right at the boundary is really bad for SIMD divergence.

This may explain why view 2 has slightly lower speedup; the boundaries tend to run vertically through the image, and since the vector instructions are running with 8 horizontal pixels at a time, the SIMD divergence may be higher.

## Part 2

### 1. 

Speedups:
   - with `--tasks` on view 1: 9.94x
     - speedup: ~1.98x over no tasks
   - with `--tasks` on view 2: 7.23x
     - speedup: ~1.67x over no tasks

### 2.

By setting the rowsPerTask to 1 and launching `height` tasks, we achieve a 33.44x speedup on view 1. While our CPU is capable of 8 threads, we can go beyond this to distribute the workload most evenly with a row-level granularity, since tasks are dynamically picked up by threads by availability. Tasks are lightweight compared to creating std::thread so the overhead does not yet harm the speedup at a height of 800 pixels.

### 3. 

Each std::thread will need its own TCB with stack space, registers, PC, etc., and switching amongst these requires saving and loading these states. That means that 10,000 threads require lots of memory space, and the time spent context switching to make progress on all 10,000 threads may outweigh the time spent making progress on any one thread.

In contrast ISPC tasks are just asynchronous units of work that will be picked up and run by hardware threads to completion as they become available; thus there isn't a significant memory overhead with each task, and there isn't context switching mid-task. There is some small overhead for the control unit to know about an idle thread and assign it a task but it is much smaller than a std::thread.
