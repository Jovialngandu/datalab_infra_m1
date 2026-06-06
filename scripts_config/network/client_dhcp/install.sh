#!/bin/bash

# 1. Libérer l'ancienne adresse IP s'il y en a une
sudo dhclient -r eth0

# 2. Lancer la requête DHCP (Cycle DORA) pour récupérer dynamiquement la nouvelle IP
sudo dhclient eth0

# 3. Vérification immédiate de l'IP obtenue
ip addr show eth0