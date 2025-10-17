-- Data Cleaning
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

-- Data Exploration

-- How many sales we have?
SELECT 
    COUNT(*) as total_sale 

FROM 
    retail_sales;

-- How many unique customers we have ?

SELECT 
    COUNT(DISTINCT customer_id) as distinct_customers
FROM 
    retail_sales;

-- How many product categories we have ?
SELECT DISTINCT category 
FROM 
    retail_sales;










