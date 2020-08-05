#!/bin/bash

LOGFILE=/tmp/hostips.log

hostname -I| cut -d " " -f1 | while read output;

do
    echo "$output" >> $LOGFILE
    output >> hostips
    echo "hostip added to the file 'hostips'"
done
