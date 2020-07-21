#!/bin/bash
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo ""
echo "Comersus free antibot started $dt"
sudo tail -n 10000 /opt/bitnami/apache2/logs/access_log | awk '{print $1}'| sort| uniq -c| sort -nr| head -n 10 > /home/bitnami/abuseip.txt
input="/home/bitnami/abuseip.txt"
limit=300
while IFS= read -r line
do
  stringarray=($line)
  if [ "${stringarray[0]}" -gt "$limit" ];
  then
	if [ "${stringarray[1]}" = "127.0.0.1" ] || [[ "${stringarray[1]}" == "54."* ]]  ;
	then
		echo ${stringarray[1]} "-> Whitelisted "
	else
		echo ${stringarray[1]} "-> Blocked "
		# delete first to avoid duplicates
		sudo iptables -D INPUT -s ${stringarray[1]}  -j DROP
		sudo iptables -A INPUT -s ${stringarray[1]}  -j DROP
	fi
  fi
done < "$input"
# save for reboot
sudo iptables-save > /opt/bitnami/iptables-rules
echo ""
echo "Get paid version with attack signature detection at comersus.com"
