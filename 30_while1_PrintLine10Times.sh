#!/bin/bash
n=1
while [ $n -le 10 ]
do
    echo "Running $n time"
    (( n++ ))
done
