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


/*
Om det bråkar med delete och update så kan vi använda: 
SET SQL_SAFE_UPDATES = 0;

Om du inte gillar det och de risker som finns kan du 
UPDATE Kunder SET Email = 'anna.new@email.com' WHERE KundID = 1;
där vi använder PK för att lösa det.
*/

/*
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

*/
