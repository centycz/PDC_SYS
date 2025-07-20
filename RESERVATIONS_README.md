# Rezervační systém - Testovací dokumentace

## Implementované funkce

### 1. Databázová struktura
- ✅ Tabulka `reservations` s všemi požadovanými sloupci
- ✅ Propojení s existující tabulkou `restaurant_tables`
- ✅ Indexy pro optimalizaci výkonu

### 2. API Endpointy (restaurant-api.php)
- ✅ `add-reservation` - přidání nové rezervace
- ✅ `get-reservations` - získání seznamu rezervací
- ✅ `update-reservation` - aktualizace rezervace  
- ✅ `cancel-reservation` - zrušení rezervace
- ✅ `get-table-reservations` - rezervace pro konkrétní stůl

### 3. Frontend (reservations.html)
- ✅ Responzivní formulář pro nové rezervace
- ✅ Seznam rezervací s filtry (datum, stav)
- ✅ Přehled stolů s rezervacemi
- ✅ Modal pro úpravu rezervací
- ✅ Kompatibilní design se stávajícím systémem

### 4. Funkce rezervačního formuláře
- ✅ Jméno zákazníka (povinné)
- ✅ Telefonní číslo (povinné)
- ✅ Email (volitelné)
- ✅ Počet osob (1-12, povinné)
- ✅ Datum a čas rezervace (15min intervaly)
- ✅ Poznámka (volitelné)  
- ✅ Výběr stolu (automatické/manuální)

### 5. Správa rezervací
- ✅ Zobrazení rezervací podle data
- ✅ Filtrace podle stavu (čekající/potvrzené/zrušené)
- ✅ Editace existujících rezervací
- ✅ Rušení rezervací
- ✅ Kontrola konfliktů při přiřazování stolů

### 6. Vizuální přehled stolů
- ✅ Zobrazení všech stolů s informacemi o rezervacích
- ✅ Zvýraznění stolů s aktivními rezervacemi
- ✅ Detaily při kliknutí na stůl

## Testování

### Manuální test API endpointů
Příklady volání API:

```bash
# Přidání rezervace
curl -X POST http://localhost/api/restaurant-api.php?action=add-reservation \
  -H "Content-Type: application/json" \
  -d '{
    "customer_name": "Jan Novák",
    "phone": "+420123456789", 
    "email": "jan@example.com",
    "party_size": 4,
    "reservation_date": "2025-07-21",
    "reservation_time": "18:00:00",
    "notes": "Oslava narozenin",
    "table_number": 1
  }'

# Získání rezervací pro dnešní den  
curl http://localhost/api/restaurant-api.php?action=get-reservations&date=2025-07-20

# Aktualizace rezervace
curl -X POST http://localhost/api/restaurant-api.php?action=update-reservation&id=1 \
  -H "Content-Type: application/json" \
  -d '{"status": "confirmed"}'

# Zrušení rezervace
curl -X POST http://localhost/api/restaurant-api.php?action=cancel-reservation&id=1
```

### Validace
- ✅ Kontrola povinných polí
- ✅ Validace počtu osob (1-12)
- ✅ Kontrola konfliktů při rezervaci stejného stolu ve stejný čas
- ✅ Sanitizace vstupních dat
- ✅ Správné JSON odpovědi podle JSend formátu

## Databázová migrace

Pro nasazení je potřeba spustit SQL script:

```sql
CREATE TABLE `reservations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `party_size` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `reservation_time` time NOT NULL,
  `notes` text DEFAULT NULL,
  `table_number` int(11) DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_reservation_date_time` (`reservation_date`, `reservation_time`),
  KEY `idx_table_number` (`table_number`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_reservations_table` FOREIGN KEY (`table_number`) REFERENCES `restaurant_tables` (`table_number`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```