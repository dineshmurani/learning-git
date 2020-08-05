#!/bin/ksh
# Ksh For Loop 1 to 100 Numbers
# Tested with ksh version JM 93t+ 2010-03-05
for i in {1..100}
do
 # your-unix-command-here
 echo $i
done


#!/bin/bash
# Bash For Loop 1 to 100 Numbers
# Tested using bash version 4.1.5
for ((i=1;i<=100;i++)); 
do 
   # your-unix-command-here
   echo $i
done

#Dealing With Older KSH88 or Bash shell
#The above KSH and Bash syntax will not work on older ksh version running on #HP-UX or AIX. Use the following portable syntax:

#!/usr/bin/ksh
c=1
while [[ $c -le 100 ]]
do 
  # your-unix-command-here
   echo "$c"
   let c=c+1
done