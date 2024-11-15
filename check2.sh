#!/bin/bash

check_ip() {
    local host=$1
    local ip=$2
    local dns_server=$3

    
    result=$(nslookup $host $dns_server)

    
    if [[ ! $result =~ $ip ]]; then
        echo "Bogus IP for $host in /etc/hosts!"
    fi
}


while read -r line; do
  
    if [[ ! $line =~ ^# ]] && [[ ! -z $line ]]; then
        
        ip=$(echo $line | awk '{print $1}')
        host=$(echo $line | awk '{print $2}')

       
        check_ip $host $ip "8.8.8.8"
    fi
done </etc/hosts
