select * from coffee_shop_sales;

update coffee_shop_sales
set transaction_date = str_to_date(transaction_date, '%d-%m-%Y');




DESCRIBE coffee_shop_sales;

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%d-%m-%Y');

alter table coffee_shop_sales
modify column transaction_date date;

describe coffee_shop_sales

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');

alter table coffee_shop_sales
modify column transaction_time time;


select round(sum(unit_price * transaction_qty))asTotal_sales
from coffee_shop_sales
where
month(transaction_date) = 3 -- march month

-- Selected Month /CM - May = 5
-- PM - April = 4




WITH monthly_sales AS (
    SELECT 
        MONTH(transaction_date) AS month, -- Extract month
        ROUND(SUM(unit_price * transaction_qty)) AS total_sales -- Total sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) IN (4, 5) -- Only consider April and May
    GROUP BY 
        MONTH(transaction_date)
)
SELECT 
    month, 
    total_sales, 
    (total_sales - LAG(total_sales, 1) OVER (ORDER BY month)) / 
    LAG(total_sales, 1) OVER (ORDER BY month) * 100 AS mom_increase_percentage -- MoM percentage
FROM 
    monthly_sales
ORDER BY 
    month;
    
    SELECT COUNT(transaction_id) as Total_Orders
FROM coffee_shop_sales 
WHERE MONTH (transaction_date)= 5 -- for month of (CM-May)


    
    
    
    WITH monthly_orders AS (
    SELECT 
        MONTH(transaction_date) AS month,  -- Extract the month
        ROUND(COUNT(transaction_id)) AS total_orders -- Count the number of orders
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) IN (4, 5)  -- Only consider April and May
    GROUP BY 
        MONTH(transaction_date)
)
SELECT 
    month, 
    total_orders, 
    (total_orders - LAG(total_orders, 1) OVER (ORDER BY month)) / 
    LAG(total_orders, 1) OVER (ORDER BY month) * 100 AS mom_increase_percentage -- MoM percentage
FROM 
    monthly_orders
ORDER BY 
    month;
    
    
    SELECT SUM(transaction_qty) as Total_Quantity_Sold
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 5 -- for month of (CM-May)


    
    
    WITH monthly_sales AS (
    SELECT 
        MONTH(transaction_date) AS month,  -- Extract the month
        ROUND(SUM(transaction_qty)) AS total_quantity_sold  -- Sum the total quantity sold
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) IN (4, 5)  -- Only consider April and May
    GROUP BY 
        MONTH(transaction_date)
)
SELECT 
    month, 
    total_quantity_sold, 
    (total_quantity_sold - LAG(total_quantity_sold, 1) OVER (ORDER BY month)) / 
    LAG(total_quantity_sold, 1) OVER (ORDER BY month) * 100 AS mom_increase_percentage  -- MoM percentage
FROM 
    monthly_sales
ORDER BY 
    month;
    
    
    SELECT
    SUM(unit_price * transaction_qty) AS total_sales,
    SUM(transaction_qty) AS total_quantity_sold,
    COUNT(transaction_id) AS total_orders
FROM 
    coffee_shop_sales
WHERE 
    transaction_date = '2023-06-18'; -- For 18 May 2023
    
    
    SELECT
    concat(round(SUM(unit_price * transaction_qty)/1000,1), 'K') AS total_sales,  -- Total sales value
    concat(round(SUM(transaction_qty)/1000,1), 'K') AS total_quantity_sold,      -- Total quantity sold
    concat(round(COUNT(transaction_id)/1000,1), 'K') AS total_orders             -- Total number of orders
FROM 
    coffee_shop_sales
WHERE 
    transaction_date = '2023-05-18';  -- For 18 May 2023
    
    select
          case when dayofweek(transaction_date) in (1,7) then 'Weekends'
          else 'Weekdays'
          end as day_type,
          CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1),'k') as Total_sales
          from coffee_shop_sales
          where month(transaction_date) = 5 -- May Month
          group by 
                case when dayofweek(transaction_date) in (1,7) then 'Weekends'
          else 'Weekdays'
          end




SELECT 
    store_location,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 2), 'K') AS Total_Sales
FROM 
    coffee_shop_sales
WHERE
    MONTH(transaction_date) = 5  -- May
GROUP BY 
    store_location
ORDER BY 
    SUM(unit_price * transaction_qty) DESC;  -- Order by the numeric SUM value, not the alias
    
    
    
    SELECT 
    CONCAT(ROUND(AVG(total_sales)/1000, 1), 'K') AS average_sales
FROM (
    SELECT 
        SUM(unit_price * transaction_qty) AS total_sales
    FROM 
        coffee_shop_sales
	WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        transaction_date
) AS internal_query;


SELECT 
    DAY(transaction_date) AS day_of_month,
    ROUND(SUM(unit_price * transaction_qty),1) AS total_sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5  -- Filter for May
GROUP BY 
    DAY(transaction_date)
ORDER BY 
    DAY(transaction_date);
    
    
    
    
    SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;
    
    
    
    SELECT 
	product_category,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(transaction_date) = 5 
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC





SELECT 
    product_type,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE
    MONTH(transaction_date) = 5  -- May
GROUP BY 
    product_type
ORDER BY 
    Total_Sales DESC  -- Use the alias here instead of recalculating
LIMIT 10;




SELECT 
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
    SUM(transaction_qty) AS Total_Quantity,
    COUNT(*) AS Total_Orders
FROM 
    coffee_shop_sales
WHERE 
    DAYOFWEEK(transaction_date) = 3 -- Filter for Tuesday (1 is Sunday, 2 is Monday, ..., 7 is Saturday)
    AND HOUR(transaction_time) = 8 -- Filter for hour number 8
    AND MONTH(transaction_date) = 5; -- Filter for May (month number 5)
    
    
    
    SELECT 
    HOUR(transaction_time) AS Hour_of_Day,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    HOUR(transaction_time)
ORDER BY 
    HOUR(transaction_time);
    
    
    SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;











 






