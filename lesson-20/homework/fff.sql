SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate BETWEEN '2024-03-01' AND '2024-03-31'
);
2. Product with highest total revenue

SELECT TOP 1 Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;
3. Second highest sale amount

SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) t
WHERE SaleAmount < (SELECT MAX(Quantity * Price) FROM #Sales);
4. Total quantity sold per month

SELECT SaleMonth, SUM(TotalQty) AS TotalQuantity
FROM (
    SELECT MONTH(SaleDate) AS SaleMonth, Quantity AS TotalQty
    FROM #Sales
) t
GROUP BY SaleMonth
ORDER BY SaleMonth;
5. Customers who bought same products as another

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);
6. Fruits pivot

SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;
7. Older people with younger

SELECT f1.ParentId AS PID, f2.ChildID AS CHID
FROM Family f1
JOIN Family f2 ON f1.ChildID = f2.ParentId
UNION
SELECT ParentId, ChildID FROM Family
ORDER BY PID, CHID;
(Recursive CTE can also be used to get all generations.)

8. Customers with CA deliveries → show TX deliveries

SELECT o1.CustomerID, o1.OrderID, o1.Amount
FROM #Orders o1
WHERE o1.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1 FROM #Orders o2
      WHERE o2.CustomerID = o1.CustomerID
        AND o2.DeliveryState = 'CA'
  );
9. Insert missing names

UPDATE #residents
SET fullname = fullname + ' name=' + fullname
WHERE fullname NOT LIKE '%name=%';
10. Cheapest & most expensive routes
(Recursive CTE for all paths)


WITH Paths AS (
    SELECT RouteID, DepartureCity, ArrivalCity, Cost,
           CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(200)) AS Route
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT r.RouteID, p.DepartureCity, r.ArrivalCity,
           p.Cost + r.Cost,
           p.Route + ' - ' + r.ArrivalCity
    FROM Paths p
    JOIN #Routes r ON p.ArrivalCity = r.DepartureCity
)
SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost;
11. Rank products order

SELECT ID, Vals,
       ROW_NUMBER() OVER (PARTITION BY Vals ORDER BY ID) AS RankOrder
FROM #RankingPuzzle;
12. Employees > avg in their department

SELECT e.*
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);
13. Employees with highest sales in month using EXISTS

SELECT DISTINCT e.EmployeeName, e.SalesMonth, e.SalesAmount
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e.SalesMonth = e2.SalesMonth
      AND e.SalesAmount >= ALL (
          SELECT SalesAmount
          FROM #EmployeeSales e3
          WHERE e3.SalesMonth = e.SalesMonth
      )
);
14. Employees with sales in every month

SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth FROM #EmployeeSales
    EXCEPT
    SELECT SalesMonth FROM #EmployeeSales e2 WHERE e2.EmployeeName = e.EmployeeName
);
15. Products > average price

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);
16. Products stock < max stock

SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);
17. Products in same category as Laptop

SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');
18. Products price > lowest Electronics
sql
Копировать код
SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);
19. Products > avg price of their category
sql
Копировать код
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(p2.Price) FROM Products p2 WHERE p2.Category = p.Category
);
20. Products ordered at least once

SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;
21. Products ordered more than avg quantity

SELECT p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);
22. Products never ordered

SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);
23. Product with highest total quantity ordered

SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQty DESC;
