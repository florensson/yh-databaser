-- L3: Joins


/*
Lägger till lite i databasen så det blir något att hantera.
Vi lägger även till kunder som inte har gjort några beställningar
och produkter som ännu inte har sålts
tydligare kan se skillnaden mellan olika JOIN.
*/

INSERT INTO Kunder (Namn, Email) VALUES
('Johan Karlsson', 'johan@email.com'),
('Maria Nilsson', 'maria@email.com');

INSERT INTO Produkter (Namn, Pris, Kategori) VALUES
('Jacka', 1299.99, 'Kläder'),
('Mössa', 149.99, 'Accessoarer');

INSERT INTO Bestallningar (KundID, Datum) VALUES
(1, '2024-03-01'),
(1, '2024-03-10'),
(2, '2024-03-05'),
(3, '2024-03-07'),
(3, '2024-03-10'),
(3, '2024-03-12');

INSERT INTO Orderrader (OrderID, ProduktID, Antal, Pris) VALUES
(1, 1, 2, 199.99),  -- Kund 1 köper 2 T-shirts
(2, 3, 1, 899.99),  -- Kund 1 köper 1 par Sneakers
(2, 2, 1, 499.99),  -- Kund 1 köper 1 par Jeans
(2, 1, 1, 199.99),  -- Kund 1 köper 1 T-shirt
(3, 2, 1, 499.99),  -- Kund 2 köper 1 par Jeans
(3, 3, 1, 899.99);  -- Kund 2 köper 1 par Sneakers


-- Titta på innehållet i våra tabeller
SELECT * FROM Produkter;
SELECT * FROM Kunder;
SELECT * FROM Bestallningar;
SELECT * FROM Orderrader;


-- INNER JOIN
-- Visar endast rader där det finns en matchning i båda tabellerna.
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
INNER JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;


-- LEFT JOIN
-- Visar alla kunder, även de som inte har gjort någon beställning.
-- Om en matchning saknas får vi NULL.
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
LEFT JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;


-- RIGHT JOIN
-- Visar alla beställningar och deras tillhörande kunder.
-- Varför får vi samma resultat som med INNER JOIN?
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
RIGHT JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;


-- RIGHT JOIN med omvänd ordning på tabellerna.
-- Jämför resultatet med vår tidigare LEFT JOIN.
SELECT Kunder.Namn, Bestallningar.OrderID FROM Bestallningar 
RIGHT JOIN Kunder 
ON Kunder.KundID = Bestallningar.KundID;


/*
Vi kan även använda JOIN mellan andra tabeller.
Här tittar vi på vilka produkter som har sålts
och vilka produkter som ännu inte har sålts.
*/

-- INNER JOIN, endast produkter som har sålts
SELECT Produkter.Namn, Orderrader.Antal FROM Produkter
INNER JOIN Orderrader
ON Produkter.ProduktID = Orderrader.ProduktID;


-- LEFT JOIN, alla produkter oavsett om de har sålts
SELECT Produkter.Namn, Orderrader.Antal FROM Produkter
LEFT JOIN Orderrader
ON Produkter.ProduktID = Orderrader.ProduktID;


-- RIGHT JOIN, alla produkter oavsett om de har sålts
SELECT Produkter.Namn, Orderrader.Antal FROM Orderrader
RIGHT JOIN Produkter
ON Produkter.ProduktID = Orderrader.ProduktID;


/*
GROUP BY
Används för att gruppera rader, exempelvis när vi vill
räkna, summera eller beräkna medelvärden.
*/

-- GROUP BY, räknar antal beställningar per kund
SELECT KundID, COUNT(OrderID) AS AntalBestallningar 
FROM Bestallningar 
GROUP BY KundID;


-- Men med kundernas namn blir det lite enklare
SELECT Kunder.Namn, COUNT(OrderID) AS AntalBestallningar 
FROM Bestallningar 
INNER JOIN Kunder 
ON Bestallningar.KundID = Kunder.KundID 
GROUP BY Kunder.KundID, Kunder.Namn;


-- Vi vill även se kunder som inte har gjort någon beställning.
-- Därför använder vi LEFT JOIN istället för INNER JOIN.
SELECT Kunder.Namn, COUNT(OrderID) AS AntalBestallningar
FROM Kunder
LEFT JOIN Bestallningar
ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.KundID, Kunder.Namn;


-- Vad händer om vi istället använder COUNT(*)?
-- Varför får vi ett annat resultat för vissa kunder?
SELECT Kunder.Namn, COUNT(*) AS AntalRader
FROM Kunder
LEFT JOIN Bestallningar
ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.KundID, Kunder.Namn;


/*
HAVING
WHERE filtrerar rader innan de grupperas.
HAVING filtrerar grupper efter att de har grupperats.
*/

-- Visar kunder som har gjort fler än 2 beställningar
SELECT Kunder.Namn, COUNT(OrderID) AS AntalBestallningar 
FROM Bestallningar 
INNER JOIN Kunder 
ON Bestallningar.KundID = Kunder.KundID 
GROUP BY Kunder.KundID, Kunder.Namn
HAVING COUNT(OrderID) > 2;
