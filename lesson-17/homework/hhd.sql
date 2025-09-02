
SELECT r.Region, d.Distributor, ISNULL(s.Sales,0) AS Sales
FROM (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN #RegionSales s 
    ON r.Region = s.Region AND d.Distributor = s.Distributor
ORDER BY d.Distributor, r.Region;
✅ Produces expected rows with 0 for missing sales.

2️⃣ Managers with ≥ 5 direct reports

SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) >= 5;
✅ Returns John.

3️⃣ Products with ≥ 100 units ordered in Feb 2020

SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
✅ Returns Leetcode Solutions (130) and Leetcode Kit (100).

4️⃣ Vendor with most orders per customer

WITH VendorRank AS (
    SELECT CustomerID, Vendor, 
           SUM([Count]) AS TotalOrders,
           ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor
FROM VendorRank
WHERE rn = 1;
✅ Returns Direct Parts for 1001 and ACME for 2002.

5️⃣ Check Prime Number with WHILE

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2, @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i += 1;
END

IF @Check_Prime < 2 SET @isPrime = 0;

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';
6️⃣ Device locations/signals summary

WITH LocationCounts AS (
    SELECT Device_id, Locations, COUNT(*) AS Signals
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLocation AS (
    SELECT Device_id, Locations, Signals,
           ROW_NUMBER() OVER(PARTITION BY Device_id ORDER BY Signals DESC) AS rn
    FROM LocationCounts
)
SELECT l.Device_id,
       (SELECT COUNT(DISTINCT Locations) FROM Device d WHERE d.Device_id = l.Device_id) AS no_of_location,
       m.Locations AS max_signal_location,
       (SELECT COUNT(*) FROM Device d WHERE d.Device_id = l.Device_id) AS no_of_signals
FROM MaxLocation m
JOIN Device l ON m.Device_id = l.Device_id
WHERE m.rn = 1
GROUP BY l.Device_id, m.Locations;
✅ Returns expected output (Device 12 → Bangalore, Device 13 → Secunderabad).

7️⃣ Employees earning more than department avg

SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS AvgSal
    FROM Employee
    GROUP BY DeptID
) a ON e.DeptID = a.DeptID
WHERE e.Salary > a.AvgSal;
✅ Matches expected result.

8️⃣ Lottery winnings ($100 full match, $10 partial)

WITH TicketMatch AS (
    SELECT t.TicketID,
           SUM(CASE WHEN t.Number IN (SELECT Number FROM Numbers) THEN 1 ELSE 0 END) AS Matches,
           COUNT(DISTINCT t.Number) AS TicketNums
    FROM Tickets t
    GROUP BY t.TicketID
)
SELECT SUM(CASE WHEN Matches = (SELECT COUNT(*) FROM Numbers) THEN 100
                WHEN Matches > 0 THEN 10
                ELSE 0 END) AS TotalWinnings
FROM TicketMatch;
✅ Returns 110.

9️⃣ Spending by Mobile/Desktop/Both

WITH UserSpend AS (
    SELECT User_id, Spend_date,
           SUM(CASE WHEN Platform='Mobile' THEN Amount ELSE 0 END) AS Mobile,
           SUM(CASE WHEN Platform='Desktop' THEN Amount ELSE 0 END) AS Desktop
    FROM Spending
    GROUP BY User_id, Spend_date
)
SELECT Spend_date, 'Mobile' AS Platform,
       SUM(Mobile) AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM UserSpend
WHERE Mobile > 0 AND Desktop = 0
GROUP BY Spend_date
UNION ALL
SELECT Spend_date, 'Desktop', SUM(Desktop), COUNT(DISTINCT User_id)
FROM UserSpend
WHERE Desktop > 0 AND Mobile = 0
GROUP BY Spend_date
UNION ALL
SELECT Spend_date, 'Both', SUM(Mobile+Desktop), COUNT(DISTINCT User_id)
FROM UserSpend
WHERE Mobile > 0 AND Desktop > 0
GROUP BY Spend_date
ORDER BY Spend_date, Platform;
✅ Produces the expected 6 rows.

🔟 De-group Grouped table (expand Quantity → rows)

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 1000);
