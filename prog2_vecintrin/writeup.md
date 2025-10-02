### 1.

Done.

### 2. 

There is an inverse relationship between the vector utilization and the vector width, starting at 76.9% with width=2 and decreasing to 64.2% with width=16.

This is because vector utilization measures the percentage of lanes that actually did work across all vector operations. The greater the vector width, the more that data irregularity (for instance, a few exponents being much larger than others) will skew the utilization downwards due to wasted cycles in the other lanes. 
Additionally, larger width makes divergent branches more likely: uniform execution is p^vector_width, with p being the probability of any element taking the majority path, which decreases exponentially.

### 3.

Done.
