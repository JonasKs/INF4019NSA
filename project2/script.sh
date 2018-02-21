#!/bin/bash
echo "script starts in 10"
/home/ubuntu/httperf.sh &
while true
DATE=`date +%Y-%m-%d:%H:%M:%S`
do
  diff=$(curl -u admin:PASSWORD "http://128.39.121.129:1338/?stats;csv" 2>/dev/null | grep mysite |awk -F "," '{print $34}')
  scale=$(($diff/10+1))
  currentcontainers=$(docker service ls | grep my-web | awk '{print $4}' | grep -Po "^[^/]+(?=/?)")
  if [[ $scale -eq $currentcontainers  ]] || [[ $scale -lt 1 ]]; then
     echo "$DATE: Current active connections is $diff, and we have $currentcontainers containers running."
  else
     echo "$DATE: Current active connections is $diff, and we have $currentcontainers containers running. Scaling to $scale"
     docker service scale my-web=$scale
  fi
  sleep 5
done
