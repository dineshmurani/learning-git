#!/bin/bash 
# 
# Copyright 2017 Cohesity Inc. 
# 
# Author: Patrick Lundquist 
# 
# DESCRIPTION: A script to start services on a node. If the node is running as 
# a VM, then the hypervisor may call this script during power management. 
# 
# Start nexus and it will start other services. 
# Resetting the time to match ntp on every reboot 
systemctl stop ntpd 

server_list=`cat /etc/ntp.conf | grep server | awk '{ print $2 }'` 

ntpdate -u $server_list 

sudo systemctl start nexus