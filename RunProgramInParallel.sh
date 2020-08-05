# Sample outputs:

# https://server1.cyberciti.biz/20170406_15.jpg
# https://server1.cyberciti.biz/20170406_16.jpg
# https://server1.cyberciti.biz/20170406_17.jpg
# https://server1.cyberciti.biz/20170406_14.jpg
# https://server1.cyberciti.biz/20170406_18.jpg
# https://server1.cyberciti.biz/20170406_19.jpg
# https://server1.cyberciti.biz/20170406_20.jpg
# https://server1.cyberciti.biz/20170406_22.jpg
# https://server1.cyberciti.biz/20170406_23.jpg
# https://server1.cyberciti.biz/20170406_21.jpg
# https://server1.cyberciti.biz/20170420_15.jpg
# https://server1.cyberciti.biz/20170406_24.jpg
# To download all files in parallel using wget:

#!/bin/bash
# Our custom function
cust_func(){
  wget -q "$1"
}
 
while IFS= read -r url
do
        cust_func "$url" &
done < list.txt
 
wait
echo "All files are downloaded."


# GNU parallel examples to run command or code in parallel in bash shell
# From the GNU project site:

# GNU parallel is a shell tool for executing jobs in parallel using one or # # more computers. A job can be a single command or a small script that has # # to # be run for each of the lines in the input. The typical input is a # # # list of files, a list of hosts, a list of users, a list of URLs, or a list # of tables.

# The syntax is pretty simple:
# parallel ::: prog1 prog2

# For example, you can find all *.doc files and gzip (compress) it using the # following syntax:
$ find . -type f -name '*.doc' | parallel gzip --best
$ find . -type f -name '*.doc.gz'

# Install GNU parallel on Linux
# Use the apt command/apt-get command on a Debian or Ubuntu Linux:
$ sudo apt install parallel

# For a RHEL/CentOS Linux try, yum command:
$ sudo yum install parallel

# If you are using a Fedora Linux, try dnf command:
$ sudo dnf install parallel

# Examples
# Our above wget example can be simplified using GNU parallel as follows:
$ cat list.txt | parallel -j 4 wget -q {}

# OR
$ parallel -j 4 wget -q {} < list.txt