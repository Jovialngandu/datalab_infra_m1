#!/bin/bash
# TARGET_VLAN : VLAN 20 (SERVERS)
# TARGET_IP   : 10.0.20.10
# ROLE        : Service d'allocation dynamique d'adresses (DHCP)

# 1. Installation
sudo apt update -y
sudo apt install isc-dhcp-server -y

# 2. Configuration de l'interface (eth0 à adapter selon GNS3)
sudo sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/g' /etc/default/isc-dhcp-server

# 3. Fichier de configuration principal
sudo mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak
sudo bash -c 'cat << EOF > /etc/dhcp/dhcpd.conf
authoritative;
option domain-name "datalab.local";
option domain-name-servers 10.0.20.10;

default-lease-time 86400;
max-lease-time 172800;

subnet 10.0.30.0 netmask 255.255.255.0 {
    range 10.0.30.10 10.0.30.100;
    option routers 10.0.30.1;
    option subnet-mask 255.255.255.0;
    option broadcast-address 10.0.30.255;
}

subnet 10.0.20.0 netmask 255.255.255.0 {
    option routers 10.0.20.1;
}
EOF'

# 4. Activation et démarrage
sudo systemctl daemon-reload
sudo systemctl enable isc-dhcp-server
sudo systemctl restart isc-dhcp-server