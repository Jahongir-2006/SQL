WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT n
FROM Numbers
OPTION (MAXRECURSION 1000);
2. Total sales per employee (derived table)

SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID;
3. Average salary of employees (CTE)

WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal
    FROM Employees
)
SELECT AvgSal FROM AvgSalary;
4. Highest sales per product (derived table)

SELECT p.ProductID, p.ProductName, s.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) s ON p.ProductID = s.ProductID;
5. Double numbers until < 1,000,000

WITH Doubles AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n * 2
    FROM Doubles
    WHERE n * 2 < 1000000
)
SELECT n
FROM Doubles
OPTION (MAXRECURSION 1000);
6. Employees with more than 5 sales (CTE)

WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees e
JOIN SalesCount sc ON e.EmployeeID = sc.EmployeeID
WHERE sc.SaleCount > 5;
7. Products with sales > $500 (CTE)

WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductID, p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;
8. Employees with salary above average (CTE)

WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT *
FROM Employees e
CROSS JOIN AvgSalary 
WHERE e.Salary > a.AvgSal;
🔹 Medium Tasks
9. Top 5 employees by orders (derived table)

SELECT TOP 5 e.EmployeeID, e.FirstName, e.LastName, s.OrderCount
FROM Employees e
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.OrderCount DESC;
10. Sales per product category (derived table)

SELECT p.CategoryID, SUM(s.SalesAmount) AS TotalSales
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.CategoryID;
11. Factorial (Numbers1 table)

WITH Factorial AS (
    SELECT Number, CAST(Number AS BIGINT) AS Fact, Number AS Step
    FROM Numbers1
    UNION ALL
    SELECT f.Number, f.Fact * f.Step, f.Step - 1
    FROM Factorial f
    WHERE f.Step > 1
)
SELECT Number, MAX(Fact) AS FactorialValue
FROM Factorial
GROUP BY Number;
12. Split string into characters (recursion, Example table)

WITH Split AS (
    SELECT Id, String, 1 AS Pos, SUBSTRING(String,1,1) AS CharPart
    FROM Example
    UNION ALL
    SELECT Id, String, Pos+1, SUBSTRING(String, Pos+1,1)
    FROM Split
    WHERE Pos < LEN(String)
)
SELECT Id, CharPart
FROM Split
WHERE CharPart IS NOT NULL
OPTION (MAXRECURSION 1000);
13. Sales difference (month vs previous month)

WITH MonthlySales AS (
    SELECT YEAR(SaleDate) AS Yr, MONTH(SaleDate) AS Mn, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
)
SELECT Yr, Mn, TotalSales,
       TotalSales - LAG(TotalSales) OVER (ORDER BY Yr, Mn) AS DiffFromPrevMonth
FROM MonthlySales;
14. Employees with quarterly sales > 45k (derived table)
sql
Копировать код
SELECT e.EmployeeID, e.FirstName, e.LastName, q.TotalQuarterSales, q.Quarter
FROM Employees e
JOIN (
    SELECT EmployeeID,
           DATEPART(QUARTER, SaleDate) AS Quarter,
           SUM(SalesAmount) AS TotalQuarterSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) q ON e.EmployeeID = q.EmployeeID
WHERE q.TotalQuarterSales > 45000;
🔹 Difficult Tasks
15. Fibonacci numbers (recursive)

WITH Fibonacci (n, a, b) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT n+1, b, a+b
    FROM Fibonacci
    WHERE n < 20
)
SELECT n, a AS FibonacciNumber
FROM Fibonacci;
16. Find strings where all characters same & length > 1

SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND LEN(Vals) = LEN(REPLACE(Vals, LEFT(Vals,1), ''));
17. Numbers sequence with gradual increase (n=5 → 1,12,123…)

WITH Seq AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(20)) AS Val
    UNION ALL
    SELECT n+1, Val + CAST(n+1 AS VARCHAR(10))
    FROM Seq
    WHERE n < 5
)
SELECT * FROM Seq;
18. Employees with most sales in last 6 months (derived table)

SELECT TOP 1 e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;
19. Remove duplicate integers from string + remove single integer

;WITH Cleaned AS (
    SELECT PawanName,
           Pawan_slug_name,
           -- remove single digit integers
           REPLACE(Pawan_slug_name, '-', '') AS CleanText
    FROM RemoveDuplicateIntsFromNames
)
SELECT *
FROM Cleaned;
