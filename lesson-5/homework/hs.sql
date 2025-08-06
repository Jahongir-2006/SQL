
SELECT ProductName AS Name FROM Products;


SELECT * FROM Customers AS Client;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;
Select distinct customer names and their country:


SELECT DISTINCT FirstName, LastName, Country FROM Customers;
Use CASE to create High or Low based on Price:



SELECT ProductName, Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;
Use IIF to show Yes if Stock > 100, else No from Products_Discounted:


SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS HighStock
FROM Products_Discounted;
 Medium-Level.


SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
Return difference between Products and Products_Discounted using EXCEPT:


SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;
Create conditional column using IIF for price category:


SELECT ProductName, Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceTag
FROM Products;
Find employees with Age < 25 or Salary > 60000:


-- Assuming a table named Employees exists with Age and Salary
SELECT * FROM Employees
WHERE Age < 25 OR Salary > 60000;
Update salary of employee based on department or ID:

UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR' OR EmployeeID = 5;

 Hard-Level.Tasks



SELECT SaleID, CustomerID, SaleAmount,
       CASE
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SaleTier
FROM Sales;

SELECT DISTINCT CustomerID FROM Orders
EXCEPT
SELECT DISTINCT CustomerID FROM Sales;
CASE statement for discount based on quantity (Orders table):


SELECT CustomerID, Quantity,
       CASE 
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;

 
