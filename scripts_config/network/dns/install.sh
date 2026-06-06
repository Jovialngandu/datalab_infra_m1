#!/bin/bash
# TARGET_VLAN : VLAN 20 (SERVERS)
# TARGET_IP   : 10.0.20.10
# ROLE        : Résolution de noms locale & Redirection WAN (BIND9)

# 1. Installation
sudo apt update -y
sudo apt install bind9 bind9utils -y

# 2. Options et Redirecteurs
sudo bash -c 'cat << EOF > /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders {
        8.8.8.8;
        1.1.1.1;
    };
    dnssec-validation auto;
    listen-on { any; };
    allow-query { any; };
};
EOF'

# 3. Déclaration de zone
sudo bash -c 'cat << EOF > /etc/bind/named.conf.local
zone "datalab.local" {
    type master;
    file "/etc/bind/db.datalab.local";
};
EOF'

# 4. Fichier de base de données DNS
sudo bash -c 'cat << EOF > /etc/bind/db.datalab.local
\$TTL    604800
@       IN      SOA     ns1.datalab.local. root.datalab.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.datalab.local.

ns1          IN      A       10.0.20.10
srv-web-pub  IN      A       10.0.10.20
haproxy      IN      A       10.0.10.10
nextcloud    IN      A       10.0.20.21
backup-node  IN      A       10.0.60.10
EOF'

# 5. Activation et démarrage
sudo systemctl enable bind9
sudo systemctl restart bind9