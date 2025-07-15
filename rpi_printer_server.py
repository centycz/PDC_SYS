#!/usr/bin/env python3
"""
Raspberry Pi Printer Server for Pizza Orders
Verze: USB Direct Print (bez CORS)
Datum: 2025-07-13
"""

import json
import logging
import subprocess
import time
from datetime import datetime
from flask import Flask, request, jsonify

# USB Direct Print Configuration
USB_DEVICE = '/dev/usb/lp0'
USE_DIRECT_USB = True

# Konfigurace logování
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('/tmp/printer_server.log'),
        logging.StreamHandler()
    ]
)

app = Flask(__name__)

# Konfigurace tiskáren (priorita)
PRINTER_NAMES = [
    'xprinter',
    'usb',
    'thermal',
    'receipt',
    'pos',
    'default'
]

PRINT_WIDTH = 42

def print_direct_usb(content):
    """Přímý tisk na USB bez CUPS"""
    try:
        with open(USB_DEVICE, 'w', encoding='utf-8', errors='ignore') as printer:
            printer.write(content)
            printer.flush()
        logging.info(f"✅ Přímý USB tisk: {len(content)} znaků")
        return True
    except Exception as e:
        logging.error(f"❌ USB tisk selhal: {e}")
        return False

def get_active_printer():
    """Vrací aktivní tiskárnu (vždy USB Direct)"""
    if USE_DIRECT_USB:
        logging.info(f"🖨️ Používám přímý USB tisk na {USB_DEVICE}")
        return 'xprinter'
    return None

def print_to_printer(content, printer_name="xprinter"):
    """Tisk obsahu na tiskárnu"""
    if USE_DIRECT_USB:
        logging.info(f"🖨️ Přímý USB tisk na {USB_DEVICE}")
        return print_direct_usb(content)
    return False

def format_receipt(order_data):
    """Formatuje objednavku pro tisk - minimalni verze s odtrzenim"""
    
    # FILTRUJ JEN JIDLO
    items = order_data.get('items', [])
    
    # Rozdeleni kategorii
    pizza_items = []
    kitchen_items = []
    
    for item in items:
        category = item.get('category', 'ostatni')
        item_type = item.get('item_type', category)
        
        if category in ['pizza'] or item_type in ['pizza']:
            pizza_items.append(item)
        elif category in ['pasta', 'predkrm', 'dezert'] or \
             item_type in ['pasta', 'predkrm', 'dezert']:
            kitchen_items.append(item)
    
    # ZKONTROLUJ JESTLI JSOU NEJAKE POLOZKY K TISKU
    if not pizza_items and not kitchen_items:
        lines = []
        lines.append("=" * PRINT_WIDTH)
        lines.append("PIZZA OBJEDNAVKA".center(PRINT_WIDTH))
        lines.append("Zadne polozky pro kuchyn.")
        lines.append("=" * PRINT_WIDTH)
        lines.append("\n\n\n\n")  # Prazdne radky pro odtrzeni
        return "\n".join(lines)
    
    # VYTVOR SAMOSTATNE SEKCE
    all_sections = []
    
    # 1. PIZZA SEKCE
    if pizza_items:
        lines = []
        lines.append("=" * PRINT_WIDTH)
        lines.append("PIZZA OBJEDNAVKA".center(PRINT_WIDTH))
        lines.append("=" * PRINT_WIDTH)
        
        lines.append(f"Objednavka: {order_data.get('order_id', 'N/A')}")
        lines.append(f"Stul: {order_data.get('table_code', 'N/A')}")
        lines.append(f"Obsluha: {order_data.get('employee_name', 'N/A')}")
        lines.append(f"Cas: {datetime.now().strftime('%d.%m.%Y %H:%M:%S')}")
        lines.append("")
        
        for item in pizza_items:
            item_name = item.get('item_name', 'Neznama polozka')
            quantity = item.get('quantity', 1)
            note = item.get('note', '')
            
            lines.append(f"{quantity}x {item_name}")
            if note:
                lines.append(f"    Poznamka: {note}")
        
        lines.append("")
        lines.append("=" * PRINT_WIDTH)
        
        # Pokud nejsou kuchynske polozky, pridej prazdne radky
        if not kitchen_items:
            lines.append("")
            lines.append("")
            lines.append("")
            lines.append("")
        
        all_sections.append("\n".join(lines))
    
    # 2. KUCHYNE SEKCE
    if kitchen_items:
        lines = []
        
        # Kratky oddelovac mezi sekcemi
        if pizza_items:
            lines.append("")
            lines.append("-" * 20)
            lines.append("")
        
        lines.append("=" * PRINT_WIDTH)
        lines.append("KUCHYNE OBJEDNAVKA".center(PRINT_WIDTH))
        lines.append("=" * PRINT_WIDTH)
        
        lines.append(f"Objednavka: {order_data.get('order_id', 'N/A')}")
        lines.append(f"Stul: {order_data.get('table_code', 'N/A')}")
        lines.append(f"Obsluha: {order_data.get('employee_name', 'N/A')}")
        lines.append(f"Cas: {datetime.now().strftime('%d.%m.%Y %H:%M:%S')}")
        lines.append("")
        
        for item in kitchen_items:
            item_name = item.get('item_name', 'Neznama polozka')
            quantity = item.get('quantity', 1)
            note = item.get('note', '')
            
            lines.append(f"{quantity}x {item_name}")
            if note:
                lines.append(f"    Poznamka: {note}")
        
        lines.append("")
        lines.append("=" * PRINT_WIDTH)
        # Prazdne radky pro odtrzeni na konci
        lines.append("")
        lines.append("")
        lines.append("")
        lines.append("")
        
        all_sections.append("\n".join(lines))
    
    return "\n".join(all_sections)


@app.route('/status', methods=['GET'])
def status():
    """Kontrola stavu serveru a tiskárny"""
    active_printer = get_active_printer()
    usb_device_exists = False
    
    try:
        import os
        usb_device_exists = os.path.exists(USB_DEVICE)
    except:
        pass
    
    return jsonify({
        'status': 'running',
        'timestamp': datetime.now().isoformat(),
        'active_printer': active_printer,
        'use_direct_usb': USE_DIRECT_USB,
        'usb_device': USB_DEVICE,
        'usb_device_exists': usb_device_exists
    })

@app.route('/print-order', methods=['POST'])
def print_order():
    """Vytiskne objednávku"""
    try:
        order_data = request.get_json()
        
        if not order_data:
            return jsonify({'error': 'Chybí data objednávky'}), 400
        
        # Validace povinných polí
        required_fields = ['order_id', 'table_code', 'employee_name', 'items']
        for field in required_fields:
            if field not in order_data:
                return jsonify({'error': f'Chybí povinné pole: {field}'}), 400
        
        if not order_data['items']:
            return jsonify({'error': 'Objednávka musí obsahovat alespoň jednu položku'}), 400
        
        # Formátování a tisk
        receipt_content = format_receipt(order_data)
        active_printer = get_active_printer()
        
        if not active_printer:
            return jsonify({'error': 'Žádná tiskárna není dostupná'}), 500
        
        # Pokus o tisk
        success = print_to_printer(receipt_content, active_printer)
        
        if success:
            logging.info(f"✅ Objednávka {order_data.get('order_id')} úspěšně vytištěna")
            return jsonify({
                'success': True,
                'message': 'Objednávka byla úspěšně vytištěna',
                'order_id': order_data.get('order_id'),
                'printer': active_printer,
                'timestamp': datetime.now().isoformat()
            })
        else:
            logging.error(f"❌ Tisk objednávky {order_data.get('order_id')} selhal")
            return jsonify({'error': 'Tisk selhal'}), 500
        
    except Exception as e:
        logging.error(f"❌ Chyba při zpracování objednávky: {e}")
        return jsonify({'error': f'Serverová chyba: {str(e)}'}), 500

@app.route('/test-print', methods=['POST'])
def test_print():
    """Test tisk"""
    try:
        data = request.get_json() or {}
        test_message = data.get('message', 'Test tisk z Raspberry Pi serveru')
        
        active_printer = get_active_printer()
        
        if not active_printer:
            return jsonify({'error': 'Žádná tiskárna není dostupná'}), 500
        
        # Formátování test zprávy
        test_content = f"""
{"=" * PRINT_WIDTH}
{"TEST TISK".center(PRINT_WIDTH)}
{"=" * PRINT_WIDTH}

{test_message}

Čas: {datetime.now().strftime('%d.%m.%Y %H:%M:%S')}
Tiskárna: {active_printer}
USB Direct: {USE_DIRECT_USB}

{"=" * PRINT_WIDTH}

"""
        
        success = print_to_printer(test_content, active_printer)
        
        if success:
            return jsonify({
                'success': True,
                'message': 'Test tisk byl úspěšný',
                'printer': active_printer,
                'usb_direct': USE_DIRECT_USB
            })
        else:
            return jsonify({'error': 'Test tisk selhal'}), 500
            
    except Exception as e:
        logging.error(f"❌ Chyba při test tisku: {e}")
        return jsonify({'error': f'Chyba test tisku: {str(e)}'}), 500

if __name__ == '__main__':
    logging.info("=" * 60)
    logging.info("🚀 Raspberry Pi Printer Server - USB Direct")
    logging.info("=" * 60)
    
    # Kontrola USB device
    try:
        import os
        if os.path.exists(USB_DEVICE):
            logging.info(f"✅ USB device nalezen: {USB_DEVICE}")
        else:
            logging.warning(f"⚠️ USB device nenalezen: {USB_DEVICE}")
    except:
        pass
    
    # Zobrazení konfigurace
    active_printer = get_active_printer()
    if active_printer:
        logging.info(f"✅ Aktivní tiskárna: {active_printer}")
        logging.info(f"🖨️ Režim: Přímý USB tisk ({USB_DEVICE})")
    else:
        logging.error("❌ Žádná tiskárna není dostupná!")
    
    logging.info("📡 Server běží na http://localhost:5000")
    logging.info("🔄 Pro zastavení použij Ctrl+C")
    logging.info("=" * 60)
    
    try:
        app.run(host='0.0.0.0', port=5000, debug=False)
    except KeyboardInterrupt:
        logging.info("\n👋 Server zastaven uživatelem")
    except Exception as e:
        logging.error(f"❌ Chyba serveru: {e}")