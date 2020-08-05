#!/bin/bash
# Shell program to display numbers from 1 to 10
# -----------------------------------------------
# Copyright (c) 2005 nixCraft project <http://cyberciti.biz/fb/>
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------
# Shell program to display numbers from 1 to 10
# in CategoriesAcademic last updated April 8, 2008
 
# using for loop
echo "Using for loop method # 1... "
for i in 1 2 3 4 5 6 7 8 9 10
do
  echo -n "$i " 
done
echo ""
 
# this is much better as compare to above for loop
echo "Using for loop method # 2... "
for (( i=1; i<=10; i++ ))
do
   echo -n "$i "
done
echo ""
 
# use of while loop
echo "Using while loop..."
j=1
while [ $j -le 10 ]
do
   echo -n "$j "
   j=$(( j + 1 )) # increase number by 1 
done
echo ""