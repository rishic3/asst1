#!/bin/bash

view="${1:-1}"
results_file="results_view_${view}_$(date +%Y%m%d_%H%M%S).txt"
echo "num threads: speedup" > $results_file

for i in {2..8}
do
    echo "running with $i threads"

    output=$(./mandelbrot -t $i -v $view 2>&1)
    speedup=$(echo "$output" | grep "speedup from" | sed -n 's/.*(\([0-9.]*\)x speedup.*/\1/p')
    
    if [ ! -z "$speedup" ]; then
        echo "  $speedup x speedup"
        echo "$i: $speedup" >> $results_file
    else
        echo "  couldn't get speedup"
        echo "$i: oops" >> $results_file
    fi
    
    echo ""
done
