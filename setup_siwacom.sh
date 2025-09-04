#!/bin/bash

cd /home/joel/siwacom_lager || exit 1

# Farben
green='\033[0;32m'
reset='\033[0m'


echo -e "${reset}"

echo -e "${green}Starte die Siwacom Lagerverwaltung...${reset}"
sleep 1

# Virtuelle Umgebung aktivieren oder erstellen
VENV_DIR="/home/joel/venv/siwacom"
if [ -d "$VENV_DIR" ]; then
    source "$VENV_DIR/bin/activate"
else
    echo "Virtuelle Umgebung nicht gefunden – erstelle sie neu..."
    python3 -m venv "$VENV_DIR"
    source "$VENV_DIR/bin/activate"
    pip install --upgrade pip
    pip install mysql-connector-python pyfiglet
fi

# Starte CLI-Script
if [ -f "siwacom_cli.py" ]; then
    python siwacom_cli.py
else
    echo "Fehler: siwacom_cli.py nicht gefunden!"
    read -p "Drücke Enter zum Schließen..."
    exit 1
fi

# Nachlaufend offen halten
read -p "Drücke Enter zum Schließen..."
