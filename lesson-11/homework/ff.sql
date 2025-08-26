SELECT o.OrderID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;
2. Employees in Sales or Marketing


SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');
3. Highest salary per department


SELECT d.DepartmentName, MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;
4. USA customers with orders in 2023

SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;
5. Number of orders per customer

SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
6. Products from Gadget Supplies or Clothing Mart


SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');
7. Most recent order per customer (include those with none)


SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
🟠 Medium-Level Queries
1. Customers with order > 500


SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;
2. Sales in 2022 or > 400


SELECT p.ProductName, s.SaleDate, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;
3. Total sales amount per product

sql
Копировать
Редактировать
SELECT p.ProductName, SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;
4. HR employees with salary > 60000

sql
Копировать
Редактировать
SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' AND e.Salary > 60000;
5. Products sold in 2023 with stock > 100

sql
Копировать
Редактировать
SELECT p.ProductName, s.SaleDate, p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;
6. Employees in Sales or hired after 2020

sql
Копировать
Редактировать
SELECT e.Name AS EmployeeName, d.DepartmentName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020;
🔴 Hard-Level Queries
1. USA customers, address starts with 4 digits

sql
Копировать
Редактировать
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
       o.OrderID, c.Address, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';
2. Electronics or sale > 350

sql
Копировать
Редактировать
SELECT p.ProductName, cat.CategoryName, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Categories cat ON p.Category = cat.CategoryID
WHERE cat.CategoryName = 'Electronics' OR s.SaleAmount > 350;
3. Product count per category

sql
Копировать
Редактировать
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Products p
JOIN Categories c ON p.Category = c.CategoryID
GROUP BY c.CategoryName;
4. Orders from Los Angeles, amount > 300

sql
Копировать
Редактировать
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
       c.City, o.OrderID, o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;
5. HR/Finance employees OR names with ≥4 vowels

sql
Копировать
Редактировать
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Human Resources', 'Finance')
   OR LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'a','')) 
     - LEN(REPLACE(LOWER(e.Name), 'e',''))
     - LEN(REPLACE(LOWER(e.Name), 'i',''))
     - LEN(REPLACE(LOWER(e.Name), 'o',''))
     - LEN(REPLACE(LOWER(e.Name), 'u','')) >= 4;
6. Sales/Marketing employees salary > 60000


SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing') AND e.Salary > 60000;
