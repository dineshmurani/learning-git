#!/bin/bash 
# 
# Copyright 2017 Cohesity Inc. 
# 
# Author: Patrick Lundquist 
# 
# DESCRIPTION: A script to stop all services on a node, including nexus. 
# 
# Example: 
# $ node_stop.sh 
#   Stopping node services... 
#   Stopping service nexus 
#   Stopped service nexus 
#   Stopping service bridge_proxy 
#   Stopped service bridge_proxy 
#   Stopping service magneto 
#   Stopped service magneto 
#   ... 
#   Stopping service gandalf 
#   Stopped service gandalf 
#   Stopping service statscollector 
#   Stopped service statscollector 
#   Stopping service logwatcher 
#   Stopped service logwatcher 
#   Stopping service nexus 
#   Stopped service nexus 
#   Done stopping node services. 

current_dir=$(dirname `readlink -f $0`) 

set -o nounset 
set -o errexit 
set -o pipefail 
set +o noclobber

echo "Stopping node services..." 

# First stop nexus so that it does not race to start services again. 
echo "Stopping service nexus" 
sudo systemctl stop nexus 
echo "Stopped service nexus" 

# Call service helper to stop node services. 

$current_dir/service_helper stop 

echo "Done stopping node services."