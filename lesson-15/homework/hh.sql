SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
2. Find Products Above Average Price

SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);
Level 2: Nested Subqueries with Conditions
3. Find Employees in Sales Department

SELECT *
FROM employees
WHERE department_id = (
    SELECT id FROM departments WHERE department_name = 'Sales'
);
4. Find Customers with No Orders

SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
Level 3: Aggregation and Grouping in Subqueries
5. Find Products with Max Price in Each Category

SELECT p.*
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);
6. Find Employees in Department with Highest Average Salary

SELECT *
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);
Level 4: Correlated Subqueries
7. Find Employees Earning Above Department Average

SELECT e.*
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
8. Find Students with Highest Grade per Course

SELECT s.student_id, s.name, g.course_id, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);
Level 5: Ranking and Complex Conditions
9. Find Third-Highest Price per Category

SELECT p.*
FROM products p
WHERE 2 = (
    SELECT COUNT(DISTINCT price)
    FROM products
    WHERE category_id = p.category_id
      AND price > p.price


10. Employees with Salary Between Company Avg and Dept Max

SELECT e.*
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
      SELECT MAX(salary)
      FROM employees
      WHERE department_id = e.department_id
  );
