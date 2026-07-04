/*=====================================================
            PIZZA SALES ANALYSIS USING SQL
=======================================================

Project  : Pizza Sales Analytics - Tableau - Sql
Database : pizza_sales 
Author   : Teneti Srujana Reddy
Purpose  : Analyze the pizza sales dataset using SQL by
            writing business queries to calculate KPIs,
            identify sales trends, and answer key business
            questions. The same dataset was also analyzed
            separately in Tableau to create interactive
            dashboards and visualizations.
=====================================================*/

/*=====================================================
1. TOTAL REVENUE
=====================================================*/

SELECT
    SUM(total_price) AS Total_Revenue
FROM pizza_sales;

/*=====================================================
2. AVERAGE ORDER VALUE
=====================================================*/

SELECT
    SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;

/*=====================================================
3. TOTAL PIZZAS SOLD
=====================================================*/

SELECT
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

/*=====================================================
4. TOTAL ORDERS
=====================================================*/

SELECT
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

/*=====================================================
5. AVERAGE PIZZAS PER ORDER
=====================================================*/

SELECT
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) /
        CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
    AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

/*=====================================================
6. HOURLY TREND FOR TOTAL PIZZAS SOLD
=====================================================*/

SELECT
    DATEPART(HOUR, order_time) AS Order_Hour,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

/*=====================================================
7. WEEKLY TREND FOR TOTAL ORDERS
=====================================================*/

SELECT
    DATEPART(ISO_WEEK, order_date) AS Week_Number,
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY
    Year,
    Week_Number;

/*=====================================================
8. PERCENTAGE OF SALES BY PIZZA CATEGORY
=====================================================*/

SELECT
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales)
    AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category;

/*=====================================================
9. PERCENTAGE OF SALES BY PIZZA SIZE
=====================================================*/

SELECT
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales)
    AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

/*=====================================================
10. TOTAL PIZZAS SOLD BY CATEGORY (FEBRUARY)
=====================================================*/

SELECT
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

/*=====================================================
11. TOP 5 PIZZAS BY REVENUE
=====================================================*/

SELECT TOP 5
    pizza_name,
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

/*=====================================================
12. BOTTOM 5 PIZZAS BY REVENUE
=====================================================*/

SELECT TOP 5
    pizza_name,
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

/*=====================================================
13. TOP 5 PIZZAS BY QUANTITY SOLD
=====================================================*/

SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC;

/*=====================================================
14. BOTTOM 5 PIZZAS BY QUANTITY SOLD
=====================================================*/

SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC;

/*=====================================================
15. TOP 5 PIZZAS BY TOTAL ORDERS
=====================================================*/

SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

/*=====================================================
16. BOTTOM 5 PIZZAS BY TOTAL ORDERS
=====================================================*/

SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;

/*=====================================================
17. OPTIONAL FILTER EXAMPLE
Filter the analysis for a specific pizza category.
=====================================================*/

SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC;