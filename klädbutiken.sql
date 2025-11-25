/*
Detta är andra omgången av sql för yrkeshögskolan i Kalmar.
Till elevern: detta sammanfattar det mesta vi ska göra och ska ligga som ett stöd åt dig om du tappar tråden under lektionen.
*/
-- Skapar databasen och använder den så vi kan ändra, lägga till osv
CREATE DATABASE Kladbutik; -- Skapar databasen
USE Kladbutik;

-- Skapa Kundtabellen
CREATE TABLE Kunder (
	KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100) NOT NULL,		-- Villkor att det måste finnas nåt här
    Email VARCHAR(255) UNIQUE NOT NULL,
    Registreringsdatum TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Skapa Produkter tabellen
CREATE TABLE Produkter (
	ProduktID INT AUTO_INCREMENT PRIMARY KEY,
	Namn VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),	-- Varje gång vi ska läga in så ser den till att det måste vara posetivt, detta är ett constrin, från sql 8 och framåt
    Kategori VARCHAR(50) NOT NULL
);

-- Skapa Beställningar-tabellen
CREATE TABLE Bestallningar (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
    );
    
    -- Skapa Orderrader-tabellen
CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProduktID INT NOT NULL,
    Antal INT NOT NULL CHECK (Antal > 0),
    Pris DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Bestallningar(OrderID),
    FOREIGN KEY (ProduktID) REFERENCES Produkter(ProduktID)
);


-- Testa och kolla undertiden som vi bygger
SHOW TABLES;
SHOW TABLES;
DESCRIBE Kunder;
DESCRIBE Produkter;
DESCRIBE Bestallningar;
DESCRIBE Orderrader;

-- DROP DATABASE Kladbutik; 
-- Använd denna om något blir fel och skapa sedan om databasen.
-- Det går inte att döpa om en databas direkt; du kan göra backup och importera till en ny databas,
-- eller helt enkelt köra skriptet igen med rätt namn.

-- Lektion 2: 

-- Inforga lite data i Kunder
INSERT INTO Kunder (Namn, Email) VALUES
('Anna Andersson', 'anna@email.com'),
('Erik Svensson', 'erik@email.com'),
('Lisa Berg', 'lisa@email.com');

INSERT INTO Produkter (Namn, Pris, Kategori) VALUES
('T-shirt', 199.99, 'Kläder'),
('Jeans', 499.99, 'Kläder'),
('Sneakers', 899.99, 'Skor');

-- Hämtar data (R i CRUD)
SELECT * FROM Kunder;
SELECT Namn, Email FROM Kunder;

-- Where filterar data
SELECT * FROM Kunder WHERE Namn = 'Anna Andersson';
SELECT * FROM Produkter WHERE Pris > 500; -- Priset är över 500kr

-- Order by, sortera datan
SELECT * FROM Produkter ORDER BY Pris ASC;
SELECT * FROM Kunder ORDER BY Registreringsdatum DESC;

-- Order by, sortera datan
SELECT * FROM Produkter ORDER BY Pris ASC;
SELECT * FROM Kunder ORDER BY Registreringsdatum DESC;

/*
Om det bråkar med delete och update så kan vi använda: 
SET SQL_SAFE_UPDATES = 0;

Om du inte gillar det och de risker som finns kan du 
UPDATE Kunder SET Email = 'anna.new@email.com' WHERE KundID = 1;
där vi använder PK för att lösa det.
*/
SET SQL_SAFE_UPDATES = 1;
-- uppdatera data
UPDATE Kunder SET Email = 'anna.new@email.com' WHERE Namn = 'Anna Andersson';

DELETE FROM Kunder WHERE Namn = 'Erik Svensson';



START TRANSACTION;  -- Börjar en transaktion

UPDATE Kunder 
SET Email = 'anna.ny@email.com' 
WHERE KundID = 1;

SELECT * FROM Kunder WHERE KundID = 1;  -- Kolla om ändringen ser rätt ut
-- om allt ser bra ut kör vi:
-- COMMIT;  -- Spara ändringen permanent


-- L3: Joins

/*
Lägger till lite i databasen så det blir något att hantera
*/

INSERT INTO Bestallningar (KundID, Datum) VALUE
(1, '2024-03-01'),
(1, '2024-03-10'),
(2, '2024-03-05'),
(3, '2024-03-07'),
(3, '2024-03-10'),
(3, '2024-03-12');

INSERT INTO Orderrader (OrderID, ProduktID, Antal, Pris) VALUES
(25, 1, 2, 199.99),  -- Kund 1 köper 2 T-shirts
(26, 3, 1, 899.99),  -- Kund 1 köper 1 par Sneakers
(27, 2, 1, 499.99),  -- Kund 1 köper 1 par Jeans
(28, 1, 1, 199.99),  -- Kund 2 köper 1 T-shirt
(29, 2, 1, 499.99),  -- Kund 3 köper 1 par Jeans
(30, 3, 1, 899.99);  -- Kund 3 köper 3 T-shirts


SELECT * FROM Produkter;
SELECT * FROM Kunder;

-- inner join
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder INNER JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID;

-- left join
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder LEFT JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID;

-- right join
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder LEFT JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID;

-- Group by, räknar antal beställninar per kund
SELECT KundID, COUNT(OrderID) AS AntalBeställninar From Bestallningar GROUP BY KundID;

-- Men med kundern namn blir det lite enklare
SELECT Kunder.Namn, COUNT(OrderID) As Antalbeställningar FROM Bestallningar INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID GROUP BY Kunder.Namn;

SELECT Kunder.Namn, COUNT(OrderID) As Antalbeställningar FROM Bestallningar INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID GROUP BY Kunder.Namn
HAVING COUNT(OrderID) > 2; -- För att se kunder som bara har mer än 2 beställningar

-- om det inte ser bra ut så kör vi: 
-- ROLLBACK;  -- Ångra ändringen
