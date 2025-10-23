# Introduction
This project showcases the use of SQL skills and techniques commonly applied by data analysts to explore, clean, and analyze retail sales data. It focuses on setting up a retail sales database, conducting exploratory data analysis (EDA), and using SQL queries to answer key business questions and uncover insights from the data.

SQL Queries? Check them out here: [project_sql_folder](/project_scripts/)

# Background

The company’s sales database contains information about customers, products, and sales transactions.
- **Set up a retail sales database:** Create and populate a retail sales database with the provided sales data.
- **Data Cleaning:** Identify and remove any records with missing or null values.
- **Exploratory Data Analysis (EDA):** Perform basic exploratory data analysis to understand the dataset.
- **Business Analysis:** Use SQL to answer specific business questions and derive insights from the sales data.

# Tools Used
For this project, I employed several key tools which are;

- **SQL:** The backbone of my analysis, allowing me to query the database and discover key insights.
- **PostgresSQL:** The chosen database management system ideal for handling the job posting data
- **Git and GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.  


# The Analysis
Here's how I approached each question:

### 1. Database Setup
- **Database Creation:** The project starts by creating a database named p1_retail_db.
- **Table Creation:** A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

```

### 2. Data Exploration & Cleaning
- **Record Count:** Determine the total number of records in the dataset.
- **Customer Count:** Find out how many unique customers are in the dataset.
- **Category Count:** Identify all unique product categories in the dataset.
- **Null Value Check:** Check for any null values in the dataset and delete records with missing data.

```sql
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date is NULL
    OR
    sale_time IS NULL
    OR
    category IS NULL
    OR
    age IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

#### 1. Sales made on '2022-11-05' 
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

```
#### 2. Transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
```sql
ELECT *
FROM retail_sales
WHERE 
    category = 'Clothing' 
    AND
    quantity >= 4 
    AND
    (sale_date BETWEEN '2022-11-01' AND '2022-11-30');


```

#### 3. The total sales (total_sale) for each category.
```sql
SELECT 
    category,
    SUM(total_sale) AS net_sales,
    COUNT(category) as total_orders
FROM retail_sales
GROUP BY category
ORDER BY net_sales;

```

#### 4. The average age of customers who purchased items from the 'Beauty' category. 
```sql
SELECT 
    category,
    ROUND (AVG(age), 2) AS avg_age
FROM 
    retail_sales
WHERE 
    category = 'Beauty'
GROUP BY
    category;

```

#### 5. All transactions where the total_sale is greater than 1000.
```sql
SELECT *
FROM
    retail_sales
WHERE
    total_sale > 1000;
```

#### 6.  The total number of transactions (transaction_id) made by each gender in each category.
```sql
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

```

#### 7. The average sale for each month. Find out best selling month in each year
```sql
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

```

#### 8. The top 5 customers based on the highest total sales 
```sql
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

```

#### 9. The number of unique customers who purchased items from each category.
```sql
SELECT 
    category,
    count (DISTINCT customer_id) AS uni_customers
FROM 
    retail_sales
GROUP BY
    category;

```

#### 10. Each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
```sql
With temp_table AS 
(
        SELECT 
            *,
        CASE
            WHEN sale_time < '12:00:00' THEN 'Morning'
            WHEN sale_time BETWEEN '12:00:01' AND '17:00:00' THEN 'Afternoon'
            WHEN sale_time > '17:00:00' THEN 'Evening'
        END AS shift

        FROM 
            retail_sales
)

SELECT
    shift,
    count(transactions_id) as number_of_orders
FROM 
    temp_table
GROUP BY
    shift
ORDER BY
    number_of_orders;

```

# Findings
- **Customer Demographics:** The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions:** Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends:** Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights:** The analysis identifies the top-spending customers and the most popular product categories.

# Conclusions

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


