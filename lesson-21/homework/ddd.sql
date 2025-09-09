SELECT *,
       ROW_NUMBER() OVER (ORDER BY SaleDate) AS rn
FROM ProductSales;
2) Rank products by total quantity (dense, no gaps)

SELECT ProductName,
       SUM(Quantity) AS TotalQty,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS qty_rank
FROM ProductSales
GROUP BY ProductName;
3) Top sale per customer by SaleAmount


WITH s AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC, SaleDate) AS rn
  FROM ProductSales
)
SELECT * FROM s WHERE rn = 1;
4) Current amount + next amount (by date)

SELECT SaleID, SaleDate, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales
ORDER BY SaleDate;
5) Current amount + previous amount (by date)

SELECT SaleID, SaleDate, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales
ORDER BY SaleDate;
6) Sales greater than previous sale’s amount (by date)

SELECT *
FROM (
  SELECT *,
         LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmt
  FROM ProductSales
) s
WHERE PrevAmt IS NOT NULL AND SaleAmount > PrevAmt
ORDER BY SaleDate;
7) Difference from previous sale for every product


SELECT ProductName, SaleID, SaleDate, SaleAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;
8) % change vs next sale (by date)


SELECT SaleID, SaleDate, SaleAmount,
       CASE 
         WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NULL THEN NULL
         ELSE (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount
       END AS PctChangeToNext
FROM ProductSales
ORDER BY SaleDate;
9) Ratio current / previous within same product


SELECT ProductName, SaleDate, SaleAmount,
       CAST(SaleAmount AS DECIMAL(18,4)) /
       NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS RatioToPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;
10) Difference from very first sale of that product


SELECT ProductName, SaleDate, SaleAmount,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER
           (PARTITION BY ProductName ORDER BY SaleDate
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED PRECEDING) AS DiffFromFirst
FROM ProductSales
ORDER BY ProductName, SaleDate;
11) Sales that are strictly increasing for a product (each row > previous)


SELECT *
FROM (
  SELECT *,
         LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmt
  FROM ProductSales
) s
WHERE PrevAmt IS NOT NULL AND SaleAmount > PrevAmt
ORDER BY ProductName, SaleDate;
12) Running total (“closing balance”) of sales amounts (by date)


SELECT SaleDate, SaleAmount,
       SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales
ORDER BY SaleDate;
13) Moving average over last 3 sales (by date)


SELECT SaleDate, SaleAmount,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MA_3
FROM ProductSales
ORDER BY SaleDate;
14) Difference from overall average sale amount


SELECT SaleID, SaleAmount,
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales
ORDER BY SaleID;
Employees1 (Tasks 15–23)
15) Employees who share the same salary rank


SELECT EmployeeID, Name, Department, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
ORDER BY Salary DESC, Name;
16) Top 2 highest salaries in each department


WITH r AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rk
  FROM Employees1
)
SELECT * FROM r WHERE rk <= 2
ORDER BY Department, rk, Salary DESC;
17) Lowest-paid employee(s) in each department (handles ties)


WITH r AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rk
  FROM Employees1
)
SELECT * FROM r WHERE rk = 1
ORDER BY Department, Salary, Name;
18) Running total of salaries in each department (by HireDate)


SELECT Department, Name, HireDate, Salary,
       SUM(Salary) OVER (
         PARTITION BY Department
         ORDER BY HireDate
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS DeptRunningTotal
FROM Employees1
ORDER BY Department, HireDate;
19) Total salary of each department (no GROUP BY)


SELECT DISTINCT
       Department,
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees1
ORDER BY Department;
20) Average salary in each department (no GROUP BY)


SELECT DISTINCT
       Department,
       AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees1
ORDER BY Department;
21) Difference between salary and department average

SELECT EmployeeID, Name, Department, Salary,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1
ORDER BY Department, Salary DESC;
22) Moving average salary over 3 employees (current, prev, next) within department


SELECT Department, Name, HireDate, Salary,
       AVG(Salary) OVER (
         PARTITION BY Department
         ORDER BY HireDate
         ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS Dept_MA3
FROM Employees1
ORDER BY Department, HireDate;
23) Sum of salaries for the last 3 hired employees (overall)


WITH r AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS rn
  FROM Employees1
)
SELECT SUM(Salary) AS SumLast3Hires
FROM r
WHERE rn <= 3;
