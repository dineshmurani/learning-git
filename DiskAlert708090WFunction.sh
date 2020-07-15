#!/bin/sh
ADMIN="usuario@domain.com"
ALERT1=95
ALERT2=80
ALERT3=70
# Exemplu: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="/dev/sr0"
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
function main_prog() {
while read output;
do
echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
  partition=$(echo $output | awk '{print $2}')
    if [ $usep -ge $ALERT1 ] ; then
     echo "Queda menos de  `expr 100 - $usep` % en la particion: $partition del servidor ServerName, 
$(date +%d-%b-%Y)" | 
     mail -s "Alerta alta prioridad: Informacion tamaÃ±o disco: $usep %" $ADMIN
   fi
   if [ $usep -ge $ALERT2 ] ; then
     echo "Queda menos de  `expr 100 - $usep` % en la particion: $partition del servidor ServerName, 
$(date +%d-%b-%Y)" | 
     mail -s "Alerta media prioridad: Informacion tamaÃ±o disco: $usep %" $ADMIN
  fi
    if [ $usep -ge $ALERT3 ] ; then
#     espacio= expr 100 - $ALERT3"
     echo "Queda menos de  `expr 100 - $usep` % en la particion: $partition del servidor ServerName, 
$(date +%d-%b-%Y)" | 
     mail -s "Alerta baja priridad: Informacion tamaÃ±o disco: $usep %" $ADMIN
  fi
done
}
 
if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi
