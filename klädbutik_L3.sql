-- L3: Joins

/*
Lägger till lite i databasen så det blir något att hantera
*/

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
(2, 1, 1, 199.99),  -- Kund 2 köper 1 T-shirt
(3, 2, 1, 499.99),  -- Kund 3 köper 1 par Jeans
(3, 3, 1, 899.99);  -- Kund 3 köper 3 T-shirts


SELECT * FROM Produkter;
SELECT * FROM Kunder;

-- inner join
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
INNER JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;

-- left join
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
LEFT JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;

-- right join
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
LEFT JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;

-- Group by, räknar antal beställninar per kund
SELECT KundID, COUNT(OrderID) AS AntalBeställninar 
FROM Bestallningar GROUP BY KundID;

-- Men med kundern namn blir det lite enklare
SELECT Kunder.Namn, COUNT(OrderID) As Antalbeställningar FROM Bestallningar 
INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID 
GROUP BY Kunder.Namn;

SELECT Kunder.Namn, COUNT(OrderID) As Antalbeställningar FROM Bestallningar 
INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID 
GROUP BY Kunder.Namn
HAVING COUNT(OrderID) > 2; -- För att se kunder som bara har mer än 2 beställningar

