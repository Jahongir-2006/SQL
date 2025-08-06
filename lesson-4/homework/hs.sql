SELECT TOP 5 * FROM Employees;
SELECT DISTINCT Category FROM Products;
SELECT * FROM Products WHERE Price > 100;
SELECT * FROM Customers WHERE FirstName LIKE 'A%';
SELECT * FROM Products ORDER BY Price ASC;
SELECT * FROM Employees WHERE Salary >= 60000 AND DepartmentName = 'HR';
SELECT EmployeeID, FirstName, LastName,
       ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;
SELECT * FROM Products WHERE Price BETWEEN 50 AND 100;
SELECT DISTINCT Category, ProductName FROM Products;
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;


SELECT TOP 10 * FROM Products ORDER BY Price DESC;
SELECT EmployeeID, COALESCE(FirstName, LastName) AS Name FROM Employees;
SELECT DISTINCT Category, Price FROM Products;
SELECT * FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';
SELECT * FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
SELECT * FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;
SELECT * FROM Products WHERE ProductName LIKE '%e%';
SELECT * FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');
SELECT * FROM Customers
ORDER BY City ASC, PostalCode DESC;
  

SELECT TOP 5 P.ProductName, SUM(S.SaleAmount) AS TotalSales
FROM Sales S
JOIN Products_Discounted P ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSales DESC;
SELECT EmployeeID, 
       (COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '')) AS FullName
FROM Employees;
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;
SELECT * FROM Products
WHERE Price < (SELECT AVG(Price) * 0.10 FROM Products);
SELECT * FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');
SELECT * FROM Customers WHERE Email LIKE '%@gmail.com%';
SELECT * FROM Employees
WHERE Salary > ALL (
    SELECT Salary FROM Employees WHERE DepartmentName = 'Sales'
);
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, CAST(GETDATE() AS DATE)) AND CAST(GETDATE() AS DATE);


