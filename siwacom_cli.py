import mysql.connector
from datetime import datetime

# Datenbankverbindung 
conn = mysql.connector.connect(
    host="localhost",
    user="joel",
    password="joel",  #
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
    print("\n📦 Produkte im Lager:")
    for row in rows:
        print(f"  [{row['product_id']}] {row['name']} ({row['category']}) - CHF {row['sale_price']:.2f} - Bestand: {row['quantity']}")
    print()

def add_product():
    name = input("Produktname: ")
    description = input("Beschreibung: ")
    purchase_price = float(input("Einkaufspreis (CHF): "))
    sale_price = float(input("Verkaufspreis (CHF): "))
    quantity = int(input("Anfangsbestand: "))

    # Kategorien anzeigen
    print("\n📂 Verfügbare Kategorien:")
    cursor.execute("SELECT category_id, name FROM categories ORDER BY category_id")
    for cat in cursor.fetchall():
        print(f"  [{cat['category_id']}] {cat['name']}")
    category_id = int(input("Kategorie-ID auswählen: "))

    # Lieferanten anzeigen
    print("\n🏢 Verfügbare Lieferanten:")
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
    print("✅ Produkt hinzugefügt.\n")

def create_sale():
    customer_name = input("Kundenname: ")
    customer_email = input("Kunden-E-Mail: ")
    cursor.execute("INSERT INTO sales (customer_name, customer_email) VALUES (%s, %s)", (customer_name, customer_email))
    conn.commit()
    sale_id = cursor.lastrowid
    print(f"\n🧾 Neue Rechnung ID: {sale_id}\n")

    while True:
        show_products()
        product_id = int(input("Produkt-ID (0 zum Beenden): "))
        if product_id == 0:
            break
        quantity = int(input("Menge: "))
        cursor.execute("SELECT sale_price, quantity FROM products WHERE product_id = %s", (product_id,))
        result = cursor.fetchone()
        if not result:
            print("❌ Produkt nicht gefunden.")
            continue
        if result["quantity"] < quantity:
            print("❌ Nicht genügend Bestand!")
            continue

        sale_price = result["sale_price"]
        cursor.execute("""
            INSERT INTO sale_items (sale_id, product_id, quantity, sale_price)
            VALUES (%s, %s, %s, %s)
        """, (sale_id, product_id, quantity, sale_price))
        cursor.execute("UPDATE products SET quantity = quantity - %s WHERE product_id = %s", (quantity, product_id))
        conn.commit()
        print("✅ Artikel verkauft und Lager aktualisiert.\n")

def show_sales():
    cursor.execute("SELECT * FROM sales ORDER BY date DESC")
    sales = cursor.fetchall()
    print("\n🧾 Rechnungen:")
    for sale in sales:
        print(f"\nRechnung ID: {sale['sale_id']}, Kunde: {sale['customer_name']}, Datum: {sale['date']}")
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

def main_menu():
    while True:
        print("\n=== Siwacom Lagerverwaltung ===")
        print("1. Produkte anzeigen")
        print("2. Produkt hinzufügen")
        print("3. Verkauf erfassen (Rechnung)")
        print("4. Rechnungen anzeigen")
        print("0. Beenden")

        choice = input("Auswahl: ")
        if choice == "1":
            show_products()
        elif choice == "2":
            add_product()
        elif choice == "3":
            create_sale()
        elif choice == "4":
            show_sales()
        elif choice == "0":
            print("👋 Programm beendet – Terminal wird geschlossen...")
            exit(0)
        else:
            print("❌ Ungültige Eingabe.")

if __name__ == "__main__":
    try:
        main_menu()
    finally:
        cursor.close()
        conn.close()

