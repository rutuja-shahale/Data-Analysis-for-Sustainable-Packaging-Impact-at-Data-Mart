# SQL Case Study : Data Mart Analysis

✽ Introduction:

• Danny identified a market need and launched Data Mart, an online supermarket specializing in fresh produce. In June 2020, Data Mart began using sustainable packaging for all its products, from the farm to the customer.

• Data Mart offers a wide range of fresh products, with a focus on sustainability and quality. With a data-driven approach, Danny aimed to make informed decisions about the impact of this packaging change on sales and develop strategies for different business areas. This case study emphasizes the use of data to address key business inquiries.

✽ Tool Used:

• MySQL

✽ Columns Used:

• week_date

• region

• platform

• segment

• customer_type

• transactions

• sales 

# Case Study Questions

• Data Cleansing Steps:

Execute a single query to cleanse the data and create a new table (clean_weekly_sales) in the data_mart schema, incorporating the following transformations:

1. Add a week_number as the second column based on week_date.
2. Add a month_number reflecting the calendar month for each week_date.
3. Introduce a calendar_year column (2018, 2019, or 2020).
4. Insert a new column, age_band, based on specific mappings from the original segment.
5. Add a demographic column based on mappings from the first letter in the segment values.
6. Ensure all null string values are replaced with "unknown" in the segment, age_band, and demographic columns.
7. Generate an avg_transaction column, calculated as sales divided by transactions (rounded to 2 decimal places) for each record.

✽ Queries of the Projects:-

Q1. What day of the week is used for each week_date value?
  
Q2. How many total transactions were there for each year in the dataset?
 
Q3. What is the total sales for each region?
  
Q4. What is the total count of transactions for each platform?
   
Q5. Which demographic values contribute the most to Retail sales?
 
Q6. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
