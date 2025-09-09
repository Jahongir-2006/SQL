SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM sales_data
ORDER BY customer_id, order_date;
2. Count Orders per Product Category


SELECT product_category,
       COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;
3. Max Total Amount per Product Category

SELECT product_category,
       MAX(total_amount) AS max_amount
FROM sales_data
GROUP BY product_category;
4. Min Unit Price per Product Category


SELECT product_category,
       MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;
5. Moving Average of Sales (3-day window)


SELECT order_date, total_amount,
       AVG(total_amount) OVER (
         ORDER BY order_date
         ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS moving_avg
FROM sales_data
ORDER BY order_date;
6. Total Sales per Region


SELECT region,
       SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;
7. Rank Customers by Total Purchase


SELECT customer_id, customer_name,
       SUM(total_amount) AS total_spending,
       DENSE_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_customers
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY rank_customers;
8. Difference Between Current and Previous Sale per Customer


SELECT customer_id, order_date, total_amount,
       total_amount - LAG(total_amount) OVER (
           PARTITION BY customer_id ORDER BY order_date
       ) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, order_date;
9. Top 3 Most Expensive Products in Each Category


WITH r AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY product_category ORDER BY unit_price DESC
           ) AS rnk
    FROM sales_data
)
SELECT product_category, product_name, unit_price
FROM r
WHERE rnk <= 3
ORDER BY product_category, rnk;
10. Cumulative Sum of Sales per Region (by date)


SELECT region, order_date, total_amount,
       SUM(total_amount) OVER (
           PARTITION BY region ORDER BY order_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS region_cumulative_sales
FROM sales_data
ORDER BY region, order_date;
✅ Medium Questions
11. Cumulative Revenue per Product Category

SELECT product_category, order_date, total_amount,
       SUM(total_amount) OVER (
           PARTITION BY product_category ORDER BY order_date
       ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;
12. Sum of Previous Values (OneColumn)


SELECT Value,
       SUM(Value) OVER (
         ORDER BY Value
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS SumOfPrevious
FROM OneColumn;
13. Customers Who Bought from >1 Category


SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;
14. Customers with Above-Average Spending in Their Region


SELECT customer_id, customer_name, region,
       SUM(total_amount) AS customer_total,
       AVG(SUM(total_amount)) OVER (PARTITION BY region) AS region_avg
FROM sales_data
GROUP BY customer_id, customer_name, region
HAVING SUM(total_amount) > AVG(SUM(total_amount)) OVER (PARTITION BY region);
15. Rank Customers by Spending (within region)


SELECT customer_id, customer_name, region,
       SUM(total_amount) AS total_spending,
       DENSE_RANK() OVER (
           PARTITION BY region ORDER BY SUM(total_amount) DESC
       ) AS region_rank
FROM sales_data
GROUP BY customer_id, customer_name, region
ORDER BY region, region_rank;
16. Running Total per Customer (by order date)


SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER (
           PARTITION BY customer_id ORDER BY order_date
       ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;
17. Sales Growth Rate per Month


WITH monthly AS (
    SELECT FORMAT(order_date,'yyyy-MM') AS month,
           SUM(total_amount) AS monthly_sales
    FROM sales_data
    GROUP BY FORMAT(order_date,'yyyy-MM')
)
SELECT month, monthly_sales,
       (monthly_sales - LAG(monthly_sales) OVER (ORDER BY month)) * 100.0 /
        LAG(monthly_sales) OVER (ORDER BY month) AS growth_rate
FROM monthly;
18. Customers with Higher Amount than Previous Order


SELECT customer_id, order_date, total_amount,
       LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date);
✅ Hard Questions
19. Products Above Average Price


SELECT DISTINCT product_name, unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data)
ORDER BY unit_price DESC;
20. MyData Puzzle (Put Group Total on First Row Only)


SELECT Id, Grp, Val1, Val2,
       CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
            THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
       END AS Tot
FROM MyData
ORDER BY Grp, Id;
21. TheSumPuzzle (Aggregate Cost & Quantity)


SELECT Id,
       SUM(Cost) AS Cost,
       SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY Id;
22. Seats Puzzle (Find Gaps)


WITH ordered AS (
  SELECT SeatNumber,
         ROW_NUMBER() OVER (ORDER BY SeatNumber) AS rn
  FROM Seats
),
groups AS (
  SELECT SeatNumber,
         SeatNumber - rn AS grp
  FROM ordered
)
SELECT MIN(SeatNumber)+1 AS GapStart,
       MAX(SeatNumber)-1 AS GapEnd
FROM groups
GROUP BY grp
HAVING MAX(SeatNumber) - MIN(SeatNumber) > 1
ORDER BY GapStart;













ChatGPT может допускать ошибки. Рек
