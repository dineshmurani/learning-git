#!/bin/bash 
clear 
echo Initialising ... 
checkdate=`date | awk '{print $1}'` 

if [ -f "~agnea1/backup-dir/backup-data" ]; then 
        echo "ERROR: No config file for today!" 
        echo "FATAL!" 
        exit 1 
fi 

if [ -d "~agnea1/backup-dir/temp" ]; then 
        echo "ERROR: No tempoary directory found!" 
        echo 
        echo "Attempting to create" 
        cd ~agnea1 
        cd backup-dir 
        mkdir temp 
        echo "Directory Made - temp" 
fi 

if [ "$1" = "" ]; then 
        echo "ERROR: enter in a machine name (ie: cdwriter)" 
        exit 1 
fi 

if [ "$2" = "" ]; then 
        echo "ERROR: enter in a SMB (Lan Manager) Resource (ie: work)" 
        exit 1 
fi 

if [ "$3" = "" ]; then 
        echo "ERROR: enter in an IP address for $1 (ie:130.xxx.xxx.52)" 
        exit 1 
fi

############################################################################# 
# Main Section 
# 
############################################################################# 

cd ~agnea1/backup-dir/temp 
rm -r ~agnea1/backup-dir/temp/* 
cd ~agnea1/backup-dir/ 

case "$checkdate" 
in 
        Mon) 
                echo "Backuping for Monday" 
                cat backup-data | /usr/local/samba/bin/smbclient 
                \\\\$1\\$2 -I$3 -N echo "Complete" 
                        if [ -d "~agnea1/backup-dir/Monday" ]; then 
                                echo "Directory Monday Not found ...making" 
                                mkdir ~agnea1/backup-dir/Monday 
                        fi 
                echo "Archiving ..." 
                cd ~agnea1/backup-dir/temp 
                tar -cf monday.tar *                
                echo "done ..." 
                rm ~agnea1/backup-dir/Monday/monday.tar 
                mv monday.tar ~agnea1/backup-dir/Monday 
                ;; 

        Tue) 
                echo "Backuping for Tuesday" 
                cat backup-data | /usr/local/samba/bin/smbclient 
                \\\\$1\\$2 -I$3 -N echo "Complete" 
                        if [ -d "~agnea1/backup-dir/Tuesday" ]; then 
                                echo "Directory Tuesday Not found ...making" 
                                mkdir ~agnea1/backup-dir/Tuesday 
                        fi 
                echo "Archiving ..." 
                cd ~agnea1/backup-dir/temp 
                tar -cf tuesday.tar * 
                echo "done ..." 
                rm ~agnea1/backup-dir/Tuesday/tuesday.tar 
                mv tuesday.tar ~agnea1/backup-dir/Tuesday 
                ;; 

        Wed) 
                echo "Backuping for Wednesday" 
                cat backup-data | /usr/local/samba/bin/smbclient 
                \\\\$1\\$2 -I$3 -N echo "Complete" 
                        if [ -d "~agnea1/backup-dir/Wednesday" ]; then 
                                echo "Directory Wednesday Not found... making" 
                                mkdir ~agnea1/backup-dir/Wednesday 
                        fi 
                echo "Archiving ..." 
                cd ~agnea1/backup-dir/temp 
                tar -cf wednesday.tar * 
                echo "done ..." 
                rm ~agnea1/backup-dir/Wednesday/wednesday.tar 
                mv wednesday.tar ~agnea1/backup-dir/Wednesday 
                ;; 

        Thu) 
                echo "Backuping for Thrusday" 
                cat backup-data | /usr/local/samba/bin/smbclient 
                \\\\$1\\$2 -I$3 -N echo "Complete" 
                        if [ -d "~agnea1/backup-dir/Thursday" ]; then 
                                echo "Directory Thrusday Not found ...making" 
                                mkdir ~agnea1/backup-dir/Thursday 
                        fi 
                echo "Archiving ..." 
                cd ~agnea1/backup-dir/temp 
                tar -cf thursday.tar * 
                echo "done ..." 
                rm ~agnea1/backup-dir/Thursday/thursday.tar 
                mv thursday.tar ~agnea1/backup-dir/Thursday 
                ;; 

        Fri) 
                echo "Backuping for Friday" 
                cat backup-data | /usr/local/samba/bin/smbclient 
                \\\\$1\\$2 -I$3 -N echo "Complete" 
                        if [ -d "~agnea1/backup-dir/Friday" ]; then 
                                echo "Directory Friday Not found ... making" 
                                mkdir ~agnea1/backup-dir/Friday 
                        fi 
                echo "Archiving ..." 
                cd ~agnea1/backup-dir/temp 
                tar -cf friday.tar * 
                echo "done ..." 
                rm ~agnea1/backup-dir/Friday/friday.tar 
                mv friday.tar ~agnea1/backup-dir/Friday 
                ;; 

        *) 
                echo "FATAL ERROR: Unknown variable passed for day" 
                exit 1;; 
esac