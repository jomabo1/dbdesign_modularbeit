#!/bin/bash

cd /home/joel/siwacom_lager || exit 1

# Farben
green='\033[0;32m'
reset='\033[0m'

# Begrüßung in ASCII-Art
echo -e "${green}"
cat << "EOF"

     _____ _____       _____   __________  __  ___
  / ___//  _/ |     / /   | / ____/ __ \/  |/  /
  \__ \ / / | | /| / / /| |/ /   / / / / /|_/ / 
 ___/ // /  | |/ |/ / ___ / /___/ /_/ / /  / /  
/____/___/  |__/|__/_/  |_\____/\____/_/  /_/   
                                                                                                             
EOF
echo -e "${reset}"

echo -e "${green}🚀 Starte die Siwacom Lagerverwaltung...${reset}"
sleep 1

# Virtuelle Umgebung aktivieren
if [ -d "/home/joel/venv/siwacom" ]; then
    source /home/joel/venv/siwacom/bin/activate
else
    echo "⚠️ Virtuelle Umgebung nicht gefunden, erstelle neu..."
    python3 -m venv /home/joel/venv/siwacom
    source /home/joel/venv/siwacom/bin/activate
    pip install --upgrade pip
    pip install mysql-connector-python
fi

# App starten
python siwacom_cli.py

