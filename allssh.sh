# Author: Patrick Lundquist 
# 
# DESCRIPTION: A simple script to run an ssh command on all nodes. 
# 
# Disable bash expansion. 
set -f                  ##Disable file name generation (globbing) 

if [[ "$#" -lt "1" ]]        ## check if number of argument is LessThan 1 
    then 
    echo "Usage: Must specify command to run" 
    exit 1 
fi 

ips=$(hostips)                   ##  
user="cohesity" 

# ConnectTimeout=5 to handle unresponsive/down hosts. Within a cluster, we 
# do not expect latencies that high during normal operation. 

ssh_cmd="ssh -o PreferredAuthentications=publickey,password  \ 
             -o StrictHostKeyChecking=no \ 
             -o UserKnownHostsFile=/dev/null \ 
             -o ConnectTimeout=5 \ 
             -o LogLevel=ERROR -l $user" 
cmd=$@ 

for ip in $ips; do 
  echo "=========== $ip ===========" 
  ${ssh_cmd} ${ip} /usr/bin/bash -l << EOF

$cmd 
EOF 
done 