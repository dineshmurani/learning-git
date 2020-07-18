#!/bin/bash 

BACKDIR=3D/backup 
WINCMD=3D/usr/bin/smbclient 

function CopyWinHost(){ 
# tars and gzips "windows shares" to a local directory using samba's 
# smbclient 
# argument 1 is the remote host window's host name 
# argument 2 is the share name to be backed up 

   echo $1,$2,$3 
   REMOTE=3D$1 
   SHARE=3D$2 
   DEST=3D$3 

# create a tarred gzip file using samba to copy direct from a 
# windows pc 
# 12345 is a password.  Needs some password even if not defined on 
# remote system 

   $WINCMD \\\\$REMOTE\\$SHARE 12345 -Tc -|gzip > $DEST 
   echo `date`": Done backing up "$REMOTE" to "$DEST 
   echo 
} 

function CopyUnixHost(){ 

# tars and gzips a directory using rsh 
# argument 1 is the name of the remote source host 
# argument 2 is the full path to the remote source directory 
# argument 3 is the name of the local tar-gzip file.  day of week 
#  plus .tgz will be appended to argument 3 

   REMOTE=3D$1 
   SRC=3D$2 
   DEST=3D$3 

   if rsh $REMOTE tar -cf - $SRC |gzip > $DEST; then 
      echo `date`": Done backing up "$REMOTE":"$SRC" to "$DEST 
   else 
     echo `date`": Error backing up "$REMOTE":"$SRC" to "$DEST 
   fi 
} 

# $1: win=3Dbackup windows machine, unix=3Dbackup unix machine 
case $1 in 
   win) 
      # $2=3D remote windows name, $3=3Dremote share name, 
      # $4=3Dlocal destination directory 
      CopyWinHost $2 $3 $4;; 

   unix) 
      # $2 =3D remote host, $3 =3D remote directory, 
      # $4 =3D destination name 
      CopyUnixHost $2 $3 $4;; 
esac 