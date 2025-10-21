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


