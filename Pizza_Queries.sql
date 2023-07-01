SELECT * FROM pizza_sales

--Total Revenue
SELECT SUM(Total_price) AS 'Total_revenue' FROM pizza_sales

--Avg_Order_Value
SELECT SUM(Total_price)/COUNT(DISTINCT(order_id)) AS 'Avg_Order_Value' FROM pizza_sales

--Total_Pizzas_Sold
SELECT SUM(quantity) AS 'Total_Pizzas_Sold' FROM pizza_sales

--Total_Orders
SELECT COUNT(DISTINCT(order_id)) AS 'Total_Orders' FROM pizza_sales

--Avg_pizza_per_order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS 'Avg_pizza_per_order' FROM pizza_sales

--Daily Trends
SELECT DATENAME(DW,order_date) AS Orders_day,COUNT(DISTINCT(order_id)) AS 'Total_orders' FROM pizza_sales
GROUP BY DATENAME(DW,order_date)


--Hourly Trends
SELECT DATEPART(HOUR,order_time) AS Orders_hours,COUNT(DISTINCT(order_id)) AS 'Total_orders' FROM pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time)


--Percentage of sale by pizza category
SELECT pizza_category, SUM(total_price) AS Total_Sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date)=1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category



--Percentage of sale by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter,order_date)=1) AS DECIMAL(10,2))AS PCT
FROM pizza_sales
WHERE DATEPART(quarter,order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC


--Total pizza sold by category
SELECT pizza_category, sum(quantity) AS Total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category


--Total 5 best seller pizza
SELECT TOP 5 pizza_name ,SUM(quantity) as Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY SUM(quantity) DESC


--Bottom 5 worst seller pizza
SELECT TOP 5 pizza_name ,SUM(quantity) as Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY SUM(quantity) 