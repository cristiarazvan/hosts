#!/bin/bash

# Funcția pentru verificarea validității IP-ului
check_ip() {
    local host=$1
    local ip=$2
    local dns_server=$3

    # Verificăm IP-ul folosind nslookup cu serverul DNS specificat
    result=$(nslookup $host $dns_server)

    # Dacă IP-ul returnat de nslookup diferă de cel din /etc/hosts, afișăm un mesaj de eroare
    if [[ ! $result =~ $ip ]]; then
        echo "Bogus IP for $host in /etc/hosts!"
    fi
}

# Citirea linilor din /etc/hosts
while read -r line; do
    # Sărim peste liniile de comentarii și cele goale
    if [[ ! $line =~ ^# ]] && [[ ! -z $line ]]; then
        # Extragem adresa IP și numele host-ului
        ip=$(echo $line | awk '{print $1}')
        host=$(echo $line | awk '{print $2}')

        # Apelăm funcția check_ip cu serverul DNS 8.8.8.8 (de exemplu)
        check_ip $host $ip "8.8.8.8"
    fi
done </etc/hosts
