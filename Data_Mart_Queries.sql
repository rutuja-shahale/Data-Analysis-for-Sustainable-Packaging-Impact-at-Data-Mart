-- Data Cleaning Process
  SELECT
    week_date AS original_date,
    CASE
        WHEN STR_TO_DATE(week_date, '%d/%m/%y') IS NOT NULL THEN DATE_FORMAT(STR_TO_DATE(week_date, '%d/%m/%y'), '%Y-%m-%d')
        ELSE NULL -- Handle invalid dates or unexpected formats
    END AS formatted_date
FROM
    weekly_sales;

-- Create clean_weekly_sales table with required columns
CREATE TABLE clean_weekly_sales AS
SELECT
    STR_TO_DATE(week_date, '%d/%m/%y') AS week_date,
    EXTRACT(WEEK FROM STR_TO_DATE(week_date, '%d/%m/%y')) AS week_number,
    EXTRACT(MONTH FROM STR_TO_DATE(week_date, '%d/%m/%y')) AS month_number,
    EXTRACT(YEAR FROM STR_TO_DATE(week_date, '%d/%m/%y')) AS calendar_year,
    CASE 
        WHEN segment = '1' THEN 'Young Adults'
        WHEN segment = '2' THEN 'Middle Aged'
        WHEN segment = '3' OR segment = '4' THEN 'Retirees'
        ELSE 'unknown'
    END AS age_band,
    CASE 
        WHEN LEFT(segment, 1) = 'C' THEN 'Couples'
        WHEN LEFT(segment, 1) = 'F' THEN 'Families'
        ELSE 'unknown'
    END AS demographic,
    ROUND(sales / transactions, 2) AS avg_transaction
FROM
    weekly_sales;

-- Data Exploration

-- Q1. What day of the week is used for each week_date value?
SELECT week_date,
    DAYNAME(STR_TO_DATE(week_date, '%d/%m/%y')) AS day_of_week
FROM weekly_sales;

-- Q2.How many total transactions were there for each year in the dataset?
SELECT cws.calendar_year,
    SUM(ws.transactions) AS total_transactions
FROM clean_weekly_sales cws
JOIN weekly_sales ws ON cws.week_date = ws.week_date  -- Assuming week_date is the common column
GROUP BY cws.calendar_year
ORDER BY cws.calendar_year;

-- 3.What is the total sales for each region?
SELECT region,
    SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY region
ORDER BY total_sales DESC;  

-- 4. What is the total count of transactions for each platform?
SELECT platform,
    SUM(transactions) AS total_transactions
FROM weekly_sales
GROUP BY platform
ORDER BY total_transactions DESC;  

-- 5. Which demographic values contribute the most to Retail sales?
SELECT c.demographic,
    SUM(w.sales) AS total_sales
FROM clean_weekly_sales c
JOIN weekly_sales w ON EXTRACT(YEAR FROM w.week_date) = c.calendar_year
WHERE w.platform = 'Retail'
GROUP BY c.demographic
ORDER BY total_sales DESC;

-- 6. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? 
SELECT EXTRACT(YEAR FROM w.week_date) AS calendar_year,
    w.platform,
    AVG(c.avg_transaction) AS average_transaction_size
FROM weekly_sales w
JOIN clean_weekly_sales c ON EXTRACT(YEAR FROM w.week_date) = c.calendar_year
WHERE w.platform IN ('Retail', 'Shopify')
GROUP BY EXTRACT(YEAR FROM w.week_date),
    w.platform
ORDER BY calendar_year, w.platform;