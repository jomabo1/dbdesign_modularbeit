import mysql.connector
import pyfiglet
from datetime import datetime

# Datenbankverbindung
conn = mysql.connector.connect(
    host="localhost",
    user="joel",
    password="joel",
    database="siwacom_lager"
)
cursor = conn.cursor(dictionary=True)

def show_products():
    cursor.execute("""
        SELECT p.product_id, p.name, c.name AS category, p.sale_price, p.quantity
        FROM products p
        JOIN categories c ON p.category_id = c.category_id
        ORDER BY p.product_id
    """)
    rows = cursor.fetchall()
    print("\nProdukte im Lager:")
    for row in rows:
        print(f"  [{row['product_id']}] {row['name']} ({row['category']}) - CHF {row['sale_price']:.2f} - Bestand: {row['quantity']}")
    print()

def add_product():
    name = input("Produktname: ")
    description = input("Beschreibung: ")
    purchase_price = float(input("Einkaufspreis (CHF): "))
    sale_price = float(input("Verkaufspreis (CHF): "))
    quantity = int(input("Anfangsbestand: "))

    print("\nVerfügbare Kategorien:")
    cursor.execute("SELECT category_id, name FROM categories ORDER BY category_id")
    for cat in cursor.fetchall():
        print(f"  [{cat['category_id']}] {cat['name']}")
    category_id = int(input("Kategorie-ID auswählen: "))

    print("\nVerfügbare Lieferanten:")
    cursor.execute("SELECT supplier_id, name FROM suppliers ORDER BY supplier_id")
    for sup in cursor.fetchall():
        print(f"  [{sup['supplier_id']}] {sup['name']}")
    supplier_id = int(input("Lieferanten-ID auswählen: "))

    warranty = int(input("Garantie (Monate): "))

    cursor.execute("""
        INSERT INTO products (name, description, purchase_price, sale_price, quantity, category_id, supplier_id, warranty_months)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """, (name, description, purchase_price, sale_price, quantity, category_id, supplier_id, warranty))
    conn.commit()
    print("Produkt hinzugefügt.\n")

def create_sale():
    print("\nKundenverwaltung")
    email = input("Kunden-E-Mail eingeben: ").strip()

    cursor.execute("SELECT customer_id, name FROM customers WHERE email = %s", (email,))
    customer = cursor.fetchone()

    if customer:
        customer_id = customer["customer_id"]
        print(f"Kunde gefunden: {customer['name']} (ID: {customer_id})")
    else:
        print("Neuer Kunde")
        name = input("Name des Kunden: ").strip()
        cursor.execute("INSERT INTO customers (name, email) VALUES (%s, %s)", (name, email))
        conn.commit()
        customer_id = cursor.lastrowid
        print(f"Kunde '{name}' hinzugefügt (ID: {customer_id})")

    cursor.execute("INSERT INTO sales (customer_id) VALUES (%s)", (customer_id,))
    conn.commit()
    sale_id = cursor.lastrowid
    print(f"Neue Rechnung ID: {sale_id}\n")

    while True:
        show_products()
        product_id = int(input("Produkt-ID (0 zum Beenden): "))
        if product_id == 0:
            break
        quantity = int(input("Menge: "))
        cursor.execute("SELECT sale_price, quantity FROM products WHERE product_id = %s", (product_id,))
        result = cursor.fetchone()
        if not result:
            print("Produkt nicht gefunden.")
            continue
        if result["quantity"] < quantity:
            print("Nicht genügend Bestand!")
            continue

        sale_price = result["sale_price"]
        cursor.execute("""
            INSERT INTO sale_items (sale_id, product_id, quantity, sale_price)
            VALUES (%s, %s, %s, %s)
        """, (sale_id, product_id, quantity, sale_price))
        cursor.execute("UPDATE products SET quantity = quantity - %s WHERE product_id = %s", (quantity, product_id))
        conn.commit()
        print("Artikel verkauft und Lager aktualisiert.\n")

def show_sales():
    cursor.execute("SELECT * FROM sales ORDER BY date DESC")
    sales = cursor.fetchall()
    print("\nRechnungen:")
    for sale in sales:
        cursor.execute("SELECT name FROM customers WHERE customer_id = %s", (sale['customer_id'],))
        customer = cursor.fetchone()
        customer_name = customer["name"] if customer else "Unbekannt"

        print(f"\nRechnung ID: {sale['sale_id']}, Kunde: {customer_name}, Datum: {sale['date']}")
        cursor.execute("""
            SELECT si.quantity, si.sale_price, p.name
            FROM sale_items si
            JOIN products p ON si.product_id = p.product_id
            WHERE si.sale_id = %s
        """, (sale["sale_id"],))
        items = cursor.fetchall()
        for item in items:
            print(f"  - {item['quantity']} x {item['name']} à CHF {item['sale_price']:.2f}")
    print()

def search_product():
    term = input("Suchbegriff eingeben: ").lower()
    query = """
        SELECT p.product_id, p.name, p.description, c.name AS category, p.sale_price, p.quantity
        FROM products p
        JOIN categories c ON p.category_id = c.category_id
        WHERE LOWER(p.name) LIKE %s OR LOWER(p.description) LIKE %s
    """
    like_term = f"%{term}%"
    cursor.execute(query, (like_term, like_term))
    results = cursor.fetchall()

    print("\nSuchergebnisse:")
    if not results:
        print("Keine Produkte gefunden.")
    else:
        for row in results:
            print(f"[{row['product_id']}] {row['name']} ({row['category']}) - CHF {row['sale_price']:.2f} - Bestand: {row['quantity']}")
    print()

def show_customers():
    print("\nKundenliste:\n")
    cursor.execute("SELECT customer_id, name, email FROM customers ORDER BY name")
    customers = cursor.fetchall()

    if not customers:
        print("Keine Kunden gefunden.")
        return

    for cust in customers:
        print(f"[{cust['customer_id']}] {cust['name']} – {cust['email']}")
    print()

def show_customer_stats():
    print("\nKundenstatistik:\n")

    query = """
        SELECT c.customer_id, c.name, c.email,
               COUNT(DISTINCT s.sale_id) AS anzahl_rechnungen,
               SUM(si.quantity) AS anzahl_artikel,
               SUM(si.quantity * si.sale_price) AS umsatz
        FROM customers c
        LEFT JOIN sales s ON c.customer_id = s.customer_id
        LEFT JOIN sale_items si ON s.sale_id = si.sale_id
        GROUP BY c.customer_id
        ORDER BY umsatz DESC
    """
    cursor.execute(query)
    rows = cursor.fetchall()

    for row in rows:
        print(f"{row['name']} ({row['email']})")
        print(f"  Rechnungen: {row['anzahl_rechnungen']}")
        print(f"  Artikel gekauft: {row['anzahl_artikel'] or 0}")
        print(f"  Umsatz: CHF {row['umsatz'] or 0:.2f}\n")

def main_menu():
    while True:
        ascii_banner = pyfiglet.figlet_format("SIWACOM")
        print(ascii_banner)
        print("=== Siwacom Lagerverwaltung ===")
        print("1. Alle Produkte anzeigen")
        print("2. Produkt suchen")
        print("3. Produkt hinzufügen")
        print("4. Verkauf erfassen (Rechnung)")
        print("5. Rechnungen anzeigen")
        print("6. Kunden anzeigen")
        print("7. Kundenstatistik anzeigen")
        print("0. Beenden")

        choice = input("Auswahl: ")
        if choice == "1":
            show_products()
            input("Enter drücken, um ins Menü zurückzukehren...")
        elif choice == "2":
            search_product()
            input("Enter drücken, um ins Menü zurückzukehren...")
        elif choice == "3":
            add_product()
            input("Enter drücken, um ins Menü zurückzukehren...")
        elif choice == "4":
            create_sale()
            input("Enter drücken, um ins Menü zurückzukehren...")
        elif choice == "5":
            show_sales()
            input("Enter drücken, um ins Menü zurückzukehren...")
        
        elif choice == "6":
            show_customers()
            input("Enter drücken, um ins Menü zurückzukehren...")
        elif choice == "7":
            show_customer_stats()
            input("Enter drücken, um ins Menü zurückzukehren...")
        elif choice == "0":
            print("Programm beendet.")
            break
        else:
            print("Ungültige Eingabe.")

if __name__ == "__main__":
    try:
        main_menu()
    finally:
        cursor.close()
        conn.close()

