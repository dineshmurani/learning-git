1> vim ipinfo.csv 
2> chmod 755 ipinfo.csv 
3> source ipinfo.csv 
4> ipinfo 
+++++++++++++++++ 
#!/bin/bash
sshc="ssh -o PreferredAuthentications=publickey,password \ 
          -o StrictHostKeyChecking=no \ 
          -o UserKnownHostsFile=/dev/null \ 
          -o LogLevel=ERROR" 

ipinfo () 
{ 
  if [ -z "$@" ]; then 
     thehostips=`hostips` 
  else 
     thehostips="$@" 
  fi 

out=/tmp/ipinfo.$$ 
cat /dev/null > $out 
nodes=`echo $thehostips | wc -w` 
echo "Getting ipinfo for $nodes nodes.." 
for h in $thehostips 
do 
  hostname=`$sshc $h hostname` 
  product=`$sshc $h product_name.sh` 
    ifaces=`$sshc $h /usr/sbin/ifconfig | egrep 'bond0|^enp.*UP,BROADCAST,RUNNING'      |\ 
                                          grep -v avahi                                 |\ 
                                          grep -v 'bond0\.[0-9]*: '                     |\ 
                                          awk '{print $1}' | sed 's/:$//'` 

   chassis=`$sshc $h sudo ipmitool fru print               | sed '/[.][.][.]/d' | sed -n '/sis Ser/{p;q;}' | awk -F ":" '{print $2}' | tr -d ' '` 
      node=`$sshc $h sudo ipmitool fru print               | sed '/[.][.][.]/d' | sed -n '/uct Ser/{p;q;}' | awk -F ":" '{print $2}' | tr -d ' '` 
      ipmi=`$sshc $h sudo ipmitool lan print 3             | grep "IP Address  "                           | awk -F ":" '{print $2}' | tr -d ' '` 
      slot=`$sshc $h sudo ipmitool raw 0x3e 0x50           | sed -e 's/20/1/;s/22/2/;s/24/3/;s/26/4/'      | tr -d ' '` 
    nodeid=`$sshc $h cat /home/cohesity/data/node_id.json  | awk -F ":" '{print $2}'                       | tr -d '}'` 

  bondmode=`$sshc $h cat /sys/class/net/bond0/bonding/mode | awk '{print $2"-"$1}'` 

header="Node_Name,Chassis_Serial,Slot,Product,Node_Serial,Node_Id,Ipmi_Ip,If_Name,Node_Ip,Bond_Mode,Ipv6," 
echo -n "$hostname,$chassis,slot$slot,$product,$node,$nodeid,$ipmi," >> $out 

for i in $ifaces 
do 
     i_ip=`$sshc $h /usr/sbin/ifconfig $i | grep -w inet  | awk '{print $2}'` 
    i_mac=`$sshc $h /usr/sbin/ifconfig $i | grep -w ether | awk '{print $2}'` 
   i_ipv6=`$sshc $h /usr/sbin/ifconfig $i | grep -w inet6 | awk '{print $2"%bond0"}'` 
   if [ "$i" == "bond0" ] ; then 
      if [ "$i_ip" == "" ] ; then 
        i_ip=$h 
      fi 
      echo -n "$i,$i_ip,$bondmode,$i_ipv6," >> $out 
   fi 

   if [[ "$i" =~ ^enp ]] ; then 
     if [ "$i_ip" == "" ] ; then 
       i_ip="--" 
     fi 
     echo -n "$i,$i_ip," >> $out 
     header="${header}1Gifname,1G_ip," 
     echo "found 1GB configured up" 
   fi 

   if [[ "$i" =~ "bond0:" ]] ; then 
     echo -n "$i,$i_ip," >> $out 
     header="${header}vifname,vip," 
   fi 

   if [[ "$i" =~ "bond0." ]] ; then 
     echo -n "$i,$i_ip," >> $out 
     header="${header}vlan.nbr,vlan_ip," 
     echo "found vlan ip" 
   fi 
done 

echo "" >> $out 

done 

cat $out | sort -t, -k2,2 -k3,3 > $out.tmp 

echo $header  > $out 
cat $out.tmp >> $out 
rm $out.tmp 

echo "" 
cat $out | column -s, -t 
mv $out /tmp/ipinfo.csv 
echo "" 
echo "CSV file saved as /tmp/ipinfo.csv can be uploaded" 
}