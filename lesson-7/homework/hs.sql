SELECT MIN(Price) AS MinPrice FROM Products;

SELECT MAX(Salary) AS MaxSalary FROM Employees;


SELECT COUNT(*) AS TotalCustomers FROM Customers;


SELECT COUNT(DISTINCT Category) AS UniqueCategories FROM Products;

SELECT SUM(SaleAmount) AS TotalSalesForProduct7 FROM Sales WHERE ProductID = 7;


SELECT AVG(Age) AS AverageEmployeeAge FROM Employees;


SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;



SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;



SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;
