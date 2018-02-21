#!/bin/bash
#Just a simple script smacked together to simulate load. 
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: Starting httperf now" >> httperf.txt
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 0 requests / second" >> httperf.txt
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 11 requests / second" >> httperf.txt
httperf --server 128.39.121.129 --port 80 --num-conns 770 --rate 11 --hog &>/dev/null & #11*70
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 22 requests / second" >> httperf.txt
httperf --server 128.39.121.129 --port 80 --num-conns 550 --rate 11 --hog &>/dev/null & #11*50
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 33 requests / second" >> httperf.txt
httperf --server 128.39.121.129 --port 80 --num-conns 330 --rate 11 --hog &>/dev/null & #11*30
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 44 requests / second" >> httperf.txt
httperf --server 128.39.121.129 --port 80 --num-conns 110 --rate 11 --hog &>/dev/null & #11*10
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 33 requests / second" >> httperf.txt
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 22 requests / second" >> httperf.txt
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 11 requests / second" >> httperf.txt
sleep 10
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: 0 requests / second" >> httperf.txt
wait
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "$DATE: HTTPerf script finished." >> httperf.txt
