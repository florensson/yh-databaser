# Databaser – YH

Detta repo innehåller allt kursmaterial för databasmomentet i YH-utbildningen. Materialet är organiserat per årskull och per lektion.

## Struktur



- `YH25/` innehåller årets kursmaterial.
- `YH24/` innehåller materialet från tidigare år 2024.

## Lektion 1 – Introduktion och installation

I lektion 1 går vi igenom:

- Vad databaser är  
- Vad SQL används till  
- Installation av MySQL Server och klient  
- Skapa den första databasen  
- Grundläggande SQL-kommandon:
  - CREATE DATABASE
  - USE
  - CREATE TABLE

Materialet finns i `YH25/lektion1/`.

## Lektion 2 – Enkla SQL-skript och ER-diagram

I lektion 2 går vi igenom:

- Databasmodeller och ER-diagram  
- Begrepp: primärnycklar, främmande nycklar, relationer  
- Enkla SQL-skript:
  - INSERT
  - SELECT
  - WHERE
  - ORDER BY
  - Grundläggande CRUD-operationer

Materialet finns i `YH25/lektion2/`.

## Backup och återställning (terminal)

Dessa kommandon körs i terminalen, inte i MySQL-klienten.

Backup:
```bash
mysqldump -u root -p kladbutik > backup.sql
```
Återställning:
```bash
mysql -u root -p < backup.sql
```

## Övrigt

- All kod testas i MySQL 8 eller senare.  
- Materialet byggs ut under kursens gång.
