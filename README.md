# dbdesign_modularbeit
Modularbeit im Fach Datenbankdesign und BigData an der TEKO Bern
Test Test
# DB Design Modulararbeit – SIWACOM Lagerverwaltung

Dieses Projekt ist Teil einer Modulararbeit und stellt ein einfaches **Lagerverwaltungssystem für ein ICT-Geschäft** dar.  
Die Anwendung läuft als **Python-CLI-App**, verwendet **MariaDB** als Datenbank und unterstützt Produkte, Kategorien, Lieferanten sowie Verkaufsrechnungen.

---

## ✨ Features
- Produkte hinzufügen, anzeigen und verwalten
- Kategorien & Lieferanten (relationale Struktur)
- Verkäufe/Rechnungen erfassen (inkl. Positionen)
- Automatische Lagerbestandsanpassung
- Export & Import der Datenbank via SQL-Dumps
- Start über Terminal oder Desktop-Shortcut (GNOME)

---

## 🛠️ Tech-Stack
- **OS:** Debian (VM mit VirtualBox, GNOME-Desktop)
- **DB:** MariaDB (MySQL-kompatibel)
- **Sprache:** Python 3
- **Libs:** `mysql-connector-python`
- **GitHub:** Repo `jomabo1/dbdesign_modularbeit`

---

## 📂 Projektstruktur
/home/joel/siwacom_lager
├── siwacom_cli.py # CLI-App
├── setup_siwacom.sh # Setup- und Start-Skript (ASCII-Logo, venv)
├── export_siwacom_db.sh # DB-Exportskript (Schema + Daten → GitHub)
├── box.png # App-Icon
├── Siwacom.desktop # Desktop-Shortcut (optional)
├── siwacom_lager.sql # Dump: Struktur + Daten (Demo)
├── siwacom_lager_schema.sql# Dump: nur Struktur
└── README.md # Projektdokumentation
