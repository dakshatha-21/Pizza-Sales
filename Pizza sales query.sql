
--TOTAL REVENUE

select sum(total_price) as TOTAL_REVENUE from pizza_sales;

--AVERAGE ORDER VALUE

select sum(total_price) / count (distinct order_id)  as AVERAGE_ORDER_VALUES FROM pizza_sales;

--TOTAL PIZZAS SOLD

select * from pizza_sales;

select sum(quantity) as TOTAL_PIZZAS_SOLD from pizza_sales;


--TOTAL ORDERS


select COUNT(DISTINCT order_id) as TOTAL_ORDERS from pizza_sales;


--AVERAGE PIZZAS PER ORDER

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(count(distinct order_id) AS DECIMAL(10,2))  AS DECIMAL (10,2)) 
as AVERAGE_PIZZAS_PER_ORDER from pizza_sales;


--DAILY TRENDS FOR TOTAL ORDERS

SELECT DATENAME(DW,order_date) as ORDER_DAY , count(distinct order_id) as TOTAL_ORDERS
from pizza_sales
group by DATENAME(DW,order_date),DATEPART(DW,order_date)
ORDER BY DATEPART(DW,order_date);


--HOURLY TRENDS FOR TOTAL ORDERS

SELECT DATEPART(HOUR,order_time) as ORDER_HRS ,
count(distinct order_id) as TOTAL_ORDERS
from pizza_sales
group by DATEPART(HOUR,order_time)
order by ORDER_HRS DESC;

--PERCENTAGE OF SALES BY PIZZA CATEGORY

SELECT pizza_category,CAST(sum(total_price) AS DECIMAL(10,2)) AS TOTAL_REVENUE,
CAST(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT 
from pizza_sales 
group by pizza_category
ORDER BY PCT DESC;

--PARTICULARLY FOR A MONTH

SELECT pizza_category,CAST(sum(total_price) AS DECIMAL(10,2))AS TOTAL_REVENUE ,
CAST(sum(total_price) * 100 / (select sum(total_price) from pizza_sales WHERE MONTH(order_date)=6) AS DECIMAL(10,2)) AS PCT 
from pizza_sales 
WHERE MONTH(order_date) = 6
group by pizza_category
ORDER BY PCT DESC;



--PERCENTAGE OF SALES BY PIZZA SIZE

SELECT pizza_size,CAST(sum(total_price) AS DECIMAL(10,2))AS TOTAL_REVENUE ,
CAST(sum(total_price) * 100 / (select sum(total_price) from pizza_sales  ) AS DECIMAL(10,2)) AS PCT 
from pizza_sales 
group by pizza_size
ORDER BY pizza_size;

--PARTICULARLY FOR A MONTH 

SELECT pizza_size,CAST(sum(total_price) AS DECIMAL(10,2))AS TOTAL_REVENUE ,
CAST(sum(total_price) * 100 / (select sum(total_price) from pizza_sales where DATEPART(QUARTER,order_date)=1 ) AS DECIMAL(10,2)) AS PCT 
from pizza_sales 
where DATEPART(QUARTER,order_date)=1
group by pizza_size
ORDER BY pizza_size;

--TOTAL PIZZAS SOLD BY PIZZA CATEGORY

select pizza_category,sum(quantity) as Total_Pizzas_sold
from pizza_sales
group by pizza_category;

--TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD

SELECT TOP 5 pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by Total_pizzas_sold DESC;

--WORST 5 SELLERS BY TOTAL PIZZAS SOLD


SELECT TOP 5 pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by Total_pizzas_sold ASC;