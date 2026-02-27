
---Exploratory Data Analysis
---1. Product by Category
SELECT product_name, category_name 
FROM products p
JOIN categories c ON p.category_id = c. category_id

--2. get current Product list (Product ID and name).
SELECT product_id, (product_name) current_product
FROM products 
Where discontinued = 0

---3. get Product name and quantity/unit. 
SELECT PRODUCT_NAME, (quantity_per_unit)
FROM PRODUCTS

---4.  get discontinued Product list (Product ID and name).
SELECT product_id, (product_name) discontinued_product
FROM products 
Where discontinued = 1

---5. get most expense and least expensive Product list (name 
and unit price).
(SELECT Product_name, unit_price  
FROM products
ORDER BY UNIT_PRICE ASC
limit 1)
UNION  
(SELECT Product_name, unit_price  
FROM products
ORDER BY UNIT_PRICE DESC
limit 1)


---6. get Product list (id, name, unit price) where current products 
cost less than $20.

SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price < 20

---7. get Product list (id, name, unit price) where products cost 
between $15 and $25. 

SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price between 15 and 25

---8.  get Average price and Product list (name, unit price) of above average price. 
SELECT  AVG(unit_price)  AVG_PRICE
FROM products
---
SELECT product_name, unit_price
FROM products
where unit_price > ( select AVG (UNIT_PRICE) FROM Products)
ORDER BY unit_price DESC

---9. get Product list (name, unit price) of ten most expensive 
products. 
SELECT product_name, unit_price
FROM products
order by unit_price Desc
limit 10

---10. Count current and discontinued products.
SELECT (product_name), count(discontinued) current_product
FROM products
where discontinued =0
group by product_name
-----
SELECT (product_name), count(discontinued) discontinued_product
FROM products
where discontinued =1
group by product_name

---11.  get Product list (name, units on order , units in stock) of stock 
is less than the quantity on order. 
SELECT product_name, units_on_order, units_in_stock
FROM products
WHERE units_in_stock < (units_on_order)

---12.  For each employee, get their sales amount.

SELECT CONCAT(e. first_name, ' ', e. last_name) Employee_name, sum(od.quantity * od.unit_price) as total_sales_amount
FROM Order_details od
join Orders o ON od. order_id = o. order_id
join Employees e ON o. employee_id = e. employee_id
GROUP BY e. first_name, e.last_name

---13.  A Query that returns the order and calculates sales price for each order 
after discount is applied. 

SELECT Order_id, sum(od.quantity * od.unit_price *(1-od.discount)) as total_sales_amount
FROM Order_details od
Group By order_id

---14.  For each category, get the list of products sold and the total sales amount per 
product 

SELECT Category_name, product_name, sum(od.quantity * od.unit_price) as total_sales_amount
FROM Products p
JOIN order_details od ON p. product_id = od. product_id
JOIN Categories c ON p. category_id =c.category_id
GROUP BY product_name, Category_name

---15. Write a query that shows sales figures by categories for the year 1997 alone.

SELECT Category_name,ROUND (sum(od.quantity * od.unit_price *(1-od.discount))::NUMERIC,2) as total_sales
FROM Categories c
JOIN products p ON c.category_id = p. category_id
JOIN Order_details od ON p. product_id = od. product_id
JOIN Orders o ON od. order_id = o. order_id
WHERE EXTRACT (YEAR FROM o. order_date)= 1997
GROUP BY Category_name;



