#!/bin/bash

while read -r ip name; do
    
    [[ "$ip" =~ ^# ]] || [[ -z "$ip" ]] && continue

   
    real_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / {print $2; exit}')

   
    if [[ "$real_ip" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
done </etc/hosts
