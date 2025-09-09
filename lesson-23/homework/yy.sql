SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;


SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;

SELECT COUNT(*) AS TotalTransactions
FROM Sales;


SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;


SELECT Category, SUM(QuantitySold) AS TotalUnitsSold
FROM Sales
GROUP BY Category;


SELECT Region, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Region;


SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;


SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) AS DailyRevenue,
    SUM(SUM(QuantitySold * UnitPrice)) OVER (ORDER BY SaleDate) AS RunningTotalRevenue
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;
9. Вклад каждой категории в общий доход

SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER() AS PercentageContribution
FROM Sales
GROUP BY Category;


SELECT 
    S.SaleID,
    C.CustomerName,
    S.Product,
    S.QuantitySold,
    S.UnitPrice,
    (S.QuantitySold * S.UnitPrice) AS TotalAmount,
    S.SaleDate,
    S.Region
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID;


SELECT C.CustomerID, C.CustomerName
FROM Customers C
LEFT JOIN Sales S ON C.CustomerID = S.CustomerID
WHERE S.SaleID IS NULL;


SELECT 
    C.CustomerID,
    C.CustomerName,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Customers C
JOIN Sales S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID, C.CustomerName;


SELECT TOP 1 
    C.CustomerID,
    C.CustomerName,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Customers C
JOIN Sales S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY TotalRevenue DESC;


SELECT 
    C.CustomerID,
    C.CustomerName,
    COUNT(S.SaleID) AS TotalSales,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Customers C
JOIN Sales S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID, C.CustomerName;


SELECT 
    ProductName,
    Category,
    CostPrice,
    SellingPrice,
    (SellingPrice - CostPrice) AS ProfitPerUnit
FROM Products;
