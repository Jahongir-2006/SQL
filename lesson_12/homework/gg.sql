SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;
2. Employees Earning More Than Their Managers

SELECT e.name AS Employee
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
WHERE e.salary > m.salary;
3. Duplicate Emails

SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;
4. Delete Duplicate Emails

DELETE p
FROM Person p
JOIN Person p2
  ON p.email = p2.email
 AND p.id > p2.id;
5. Parents Who Have Only Girls
We want parents in girls table but not in boys table.


SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (SELECT ParentName FROM boys);
6. Total Sales Amount > 50 and Least Weight (TSQL2012)

SELECT customerid,
       SUM(salesamount) AS TotalSales,
       MIN(weight) AS LeastWeight
FROM Sales.Orders
WHERE weight > 50
GROUP BY customerid;
7. Carts Comparison
We need full outer join (Cart1 ∪ Cart2).


SELECT c1.Item AS [Item Cart 1],
       c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item;
8. Customers Who Never Order

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.id IS NULL;
