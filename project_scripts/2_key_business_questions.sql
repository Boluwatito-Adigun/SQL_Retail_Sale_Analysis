-- Q.1 Sales made on '2022-11-05' 
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

/* Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
and the quantity sold is more than 10 in the month of Nov-2022 */

SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing' 
    AND
    quantity >= 4 
    AND
    (sale_date BETWEEN '2022-11-01' AND '2022-11-30');


-- Q.3 The total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) AS net_sales,
    COUNT(category) as total_orders
FROM retail_sales
GROUP BY category
ORDER BY net_sales;

-- Q.4 The average age of customers who purchased items from the 'Beauty' category.

SELECT 
    category,
    ROUND (AVG(age), 2) AS avg_age
FROM 
    retail_sales
WHERE 
    category = 'Beauty'
GROUP BY
    category;

-- Q.5 All transactions where the total_sale is greater than 1000.

SELECT *
FROM
    retail_sales
WHERE
    total_sale > 1000;

-- Q.6 The total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    gender,
    category,
    COUNT(transactions_id) AS total_transactions
FROM
    retail_sales
GROUP BY 
    category, gender
ORDER BY 
    category;

-- Q.7 The average sale for each month. Find out best selling month in each year

SELECT 
    *
FROM

(
SELECT
    Extract(YEAR FROM sale_date) AS year,
    Extract(month FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM 
    retail_sales
GROUP BY 1, 2
) AS t1
 
 WHERE 
     rank = 1
 order by 
    month;

-- Q.8 The top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) AS net_sales
FROM
    retail_sales
GROUP BY 
    customer_id
Order by
    net_sales DESC
LIMIT 5;

-- Q.9 The number of unique customers who purchased items from each category.
SELECT 
    category,
    count (DISTINCT customer_id) AS uni_customers
FROM 
    retail_sales
GROUP BY
    category;


-- Q.10 Each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

        SELECT 
            count(transactions_id) AS number_of_orders,
        CASE
            WHEN sale_time < '12:00:00' THEN 'Morning'
            WHEN sale_time BETWEEN '12:00:01' AND '17:00:00' THEN 'Afternoon'
            WHEN sale_time > '17:00:00' THEN 'Evening'
        END AS shift

        FROM 
            retail_sales
        GROUP BY
            shift
