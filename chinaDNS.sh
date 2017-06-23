#!/bin/sh

ttl=359
ip0=192.168.1.95
ip1=192.168.1.96
ip2=192.168.1.97

servers=114.114.114.114:53,223.5.5.5:53,208.67.222.222:443,208.67.222.222:5353

docker rm -f chinadns0 chinadns1 chinadns2
docker run -d -e "SERVERS=$servers" -e "TTL=$ttl" -p $ip0:53:53/udp --name chinadns0  --log-opt max-size=10m  --restart=always ruijzhan/chinadns
docker run -d -e "SERVERS=$servers" -e "TTL=$ttl" -p $ip1:53:53/udp --name chinadns1  --log-opt max-size=10m  --restart=always ruijzhan/chinadns
docker run -d -e "SERVERS=$servers" -e "TTL=$ttl" -p $ip2:53:53/udp --name chinadns2  --log-opt max-size=10m  --restart=always ruijzhan/chinadns
