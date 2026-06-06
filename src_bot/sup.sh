#!/bin/bash

# =========================================================================
# SYSTEM DAEMON - DATALAB RESEARCH STORAGE MONITORING
# =========================================================================
# Description : Surveillance en temps réel de la volumétrie (VLAN 60)
# Fréquence   : 10 secondes
# Sécurité    : Anti-flooding intégré (Notification max toutes les 1 heure si critique)
# =========================================================================

# --- CONFIGURATION STRICTE ---
readonly TELEGRAM_TOKEN="TELEGRAM_BOT_TOKEN"
readonly CHAT_ID="VOTRE_CHAT_ID"
readonly INTERVAL=10               # Intervalle de vérification (en secondes)
readonly ANTISPAM_DELAY=3      # Attente entre 2 alertes identiques (1h en secondes /360)

# Seuil dynamique (75% par défaut, modifiable par le premier argument)
readonly SEUIL=${1:-75}

# --- VARIABLES D'ÉTAT INTERNES ---
LAST_ALERT_TIME=0

# --- FONCTION DE JOURNALISATION (LOGGING) ---
log_message() {
    local level="$1"
    local msg="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$level] $msg"
}

# --- GESTION PROPRE DE L'ARRÊT (SIGNAUX SYSTEME) ---
cleanup() {
    echo ""
    log_message "INFO" "Arrêt du démon de supervision DataLab..."
    exit 0
}
trap cleanup SIGINT SIGTERM

# --- FONCTION D'ENVOI API TELEGRAM ---
send_telegram() {
    local text="$1"
    local response
    
    response=$(curl -s -w "%{http_code}" -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
        -d "chat_id=${CHAT_ID}" \
        -d "text=${text}" \
        -d "parse_mode=Markdown")
        
    local http_status="${response: -3}"
    
    if [ "$http_status" -eq 200 ]; then
        log_message "SUCCESS" "Notification Telegram transmise avec succès."
    else
        log_message "ERROR" "Échec de l'envoi API Telegram. Code HTTP : $http_status"
    fi
}

# --- COEUR DU PROGRAMME (BOUCLE INFINIE PROFESSIONNELLE) ---
log_message "START" "Démarrage du démon de supervision (Seuil: ${SEUIL}%, Intervalle: ${INTERVAL}s)"

while true; do
    # 1. Extraction et isolation des données de stockage
    if df -h | grep -q 'ubuntu--vg'; then
        LINE_DATA=$(df -h | grep 'ubuntu--vg' | head -n 1)
    else
        LINE_DATA=$(df -h / | tail -n 1)
    fi

    POURCENTAGE=$(echo "$LINE_DATA" | awk '{print $5}' | tr -d '%')
    TAILLE=$(echo "$LINE_DATA" | awk '{print $2}')
    UTILISE=$(echo "$LINE_DATA" | awk '{print $3}')
    DISPO=$(echo "$LINE_DATA" | awk '{print $4}')

    # Sécurité : Contrôle de validité de la mesure
    if [ -z "$POURCENTAGE" ] || ! [[ "$POURCENTAGE" =~ ^[0-9]+$ ]]; then
        log_message "WARNING" "Impossible de parser l'espace disque. Prochaine tentative dans ${INTERVAL}s."
    else
        # 2. Analyse logique du seuil
        if [ "$POURCENTAGE" -ge "$SEUIL" ]; then
            CURRENT_TIME=$(date +%s)
            TIME_DIFF=$((CURRENT_TIME - LAST_ALERT_TIME))

            # Mécanisme Anti-Spam de niveau Production
            if [ "$TIME_DIFF" -ge "$ANTISPAM_DELAY" ]; then
                log_message "CRITICAL" "Seuil dépassé (${POURCENTAGE}% >= ${SEUIL}%). Génération de l'alerte..."
                
                MESSAGE="⚠️ *ALERTE SEUIL : Datacenter DataLab Research*

Le serveur de sauvegarde (*backup-vlan-60*) fait l'objet d'une alerte critique.

• *Espace Utilisé :* ${POURCENTAGE}% (Seuil : ${SEUIL}%)
• *Espace Disponible :* ${DISPO} / ${TAILLE}
• *Volume Physique :* ${UTILISE} consommé

🚨 _Action requise : Analyse immédiate requise (Purger les archives ou extension LVM à chaud)._"

                send_telegram "$MESSAGE"
                LAST_ALERT_TIME=$CURRENT_TIME
            else
                log_message "VIGILANCE" "Espace critique (${POURCENTAGE}%), mais notification en attente (Anti-Spam actif, reste $((ANTISPAM_DELAY - TIME_DIFF))s)."
            fi
        else
            log_message "OK" "Stockage nominal : ${POURCENTAGE}% utilisé. (Seuil : ${SEUIL}%)"
        fi
    fi

    # 3. Temporisation stricte de 10 secondes avant le prochain cycle
    sleep "$INTERVAL"
done