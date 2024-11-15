#!/bin/bash

while read -r ip name; do
    # Ignoră liniile comentate sau goale
    [[ "$ip" =~ ^# ]] || [[ -z "$ip" ]] && continue

    # Obține IP-ul real pentru nume
    real_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / {print $2; exit}')

    # Verifică dacă IP-urile diferă
    if [[ "$real_ip" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
done </etc/hosts
