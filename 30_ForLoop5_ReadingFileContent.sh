#!/bin/bash
i=1
for var in `cat weekday.txt`
do

echo "Weekday $i: $var"
((i++))
done
