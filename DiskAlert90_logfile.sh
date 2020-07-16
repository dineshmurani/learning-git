#!/bin/bash

SENT_TO=”dba-support@marlabs.com”
LOGFILE=/home/oracle/dba/scripts/log/disk_alert.log
ALERT=10
EXCLUDE_LIST=”/dbbackup”
if [ -f ${LOGFILE} ]; then
rm $LOGFILE
fi

df -HP | grep -vE ‘^Filesystem|tmpfs|cdrom|product|mapper’ | awk ‘{ print $5 ” ” $6 }’ | while read output;
do
usep=$(echo $output | awk ‘{ print $1}’ | cut -d’%’ -f1 )
partition=$(echo $output | awk ‘{ print $2 }’ )
if [ $usep -ge $ALERT ]; then
if [ ! -f ${LOGFILE} ]; then
touch $LOGFILE
fi
echo “Running out of space on $partition ($usep%) on $(hostname) as on $(date)” >> ${LOGFILE}
echo “” >> ${LOGFILE}
fi
done

if [ -f ${LOGFILE} ]; then
/bin/mail -s “space_alert.sh – $(hostname) – Almost out of disk space” $SENT_TO < ${LOGFILE}
fi

#rm $LOGFILE
