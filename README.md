# 🏛️ DataLab Research - Datacenter Privé & Infrastructure Services

Ce dépôt centralise exclusivement les livrables textuels, les scripts de configuration et les codes sources développés dans le cadre du projet intégrateur de Master 1 Architecture Réseau (Année Académique 2025-2026).

## 📋 Présentation du Projet
L'objectif est de concevoir, simuler et déployer un datacenter privé virtuel complet pour l'institut de recherche fictif **DataLab Research**, garantissant un cloud privé autonome, des transferts sécurisés, une haute disponibilité du stockage et une supervision proactive.


## 🔗 Ressources Réseaux & Liens Drive
Pour des raisons de performance et de propreté du dépôt, les éléments de modélisation réseau sont déportés ici :
* 📁 [Dossier Google Drive Global du Projet](https://drive.google.com/drive/folders/138T0okjlNifCohbSNKVKOXDt1d6A1Hqe?usp=sharing) — Contient l'intégralité des documents et des configurations d'ingénierie.
* 🗺️ [Schéma d'Architecture Réseau (Draw.io / PDF)](https://drive.google.com/drive/folders/1PWZKfhPXko96S1dDjtPhOhZFnBeCwFG3?usp=drive_link) — Cartographie visuelle complète des 8 VLANs et de l'isolement de la DMZ.
* 📦 [Export de la Topologie GNS3 (.gns3project)](https://drive.google.com/drive/folders/1OAFGxuTuT7rFG8uUCfVc0iM-dH2dd0k6?usp=drive_link) — Maquette réseau épurée prête à être importée pour simuler le routage inter-VLAN.
* 📊 [Matrice de Flux Complète (Excel/image)](https://drive.google.com/file/d/1KZaB0NAS0Pg6Mwq6k0zuCMLSfj8uVcIc/view?usp=drive_link) — Document de référence des ouvertures de ports TCP/UDP.

---

## 🛠️ Organisation du Dépôt
* `scripts_config/` : Contient l'ensemble des fichiers de configuration commentés et scripts d'installation pour la zone réseau, le stockage RAID/LVM, les services Cloud (Nextcloud, SFTP) et la supervision.
* `src_bot/` : Contient le code source du bot d'alerte automatisé pour la remontée d'incidents.
* `documentation/` : Sources textuelles au format `.tex` nécessaires à la compilation du rapport d'ingénierie et de la présentation de soutenance Beamer.

```bash
datalab_infra_m1/
├── .gitignore
├── README.md
├── scripts_config/         # Tous nos scripts de configuration système
│   ├── network/            # Config BIND9, isc-dhcp-server, nftables
│   ├── storage/            # Scripts d'automatisation RAID 10 et LVM
│   ├── cloud_apps/         # Configuration Nginx, Nextcloud, vsftpd
│   └── supervision/        # Scripts Prometheus / configurations des agents
├── src_bot/                # Code source de notre bot (telegram)
└── documentation/          # nos fichiers sources pour le rapport et la soutenance
    ├── rapport/            # Fichiers .tex du rapport de 20-25 pages
    └── beamer/             # Fichiers .tex des slides de présentation
```



## 🛠️ Technologies & Outils Utilisés
### 🐧 Système d'Exploitation & Infrastructure
![Ubuntu Server](https://img.shields.io/badge/Ubuntu_Server-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![GNS3](https://img.shields.io/badge/GNS3-6150FF?style=for-the-badge&logo=gns3&logoColor=white)

### 🔀 Réseau & Sécurité
![HAProxy](https://img.shields.io/badge/HAProxy-01A4CA?style=for-the-badge&logo=haproxy&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![SFTP / SSH](https://img.shields.io/badge/SFTP_/_SSH-000000?style=for-the-badge&logo=openssh&logoColor=white)
![DNS](https://img.shields.io/badge/DNS_/_BIND9-4169E1?style=for-the-badge&logo=internet-explorer&logoColor=white)
![DHCP](https://img.shields.io/badge/DHCP-0052CC?style=for-the-badge&logo=cisco&logoColor=white)
![SFTP](https://img.shields.io/badge/SFTP-000000?style=for-the-badge&logo=openssh&logoColor=white)
![FTP](https://img.shields.io/badge/FTPS-2C3E50?style=for-the-badge&logo=filezilla&logoColor=white)

### 💾 Cloud Privé & Stockage
![Nextcloud](https://img.shields.io/badge/Nextcloud-0082C9?style=for-the-badge&logo=nextcloud&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Linux Storage](https://img.shields.io/badge/RAID10_/_LVM-FFA500?style=for-the-badge&logo=linux&logoColor=white)

### 📊 Supervision & Alertes
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

### 📝 Gestion de Projet & Rédaction
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![LaTeX](https://img.shields.io/badge/LaTeX-008080?style=for-the-badge&logo=latex&logoColor=white)
![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white)
