Create Database Customers_Orders_Products 

CREATE TABLE Customers 
(
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
)
INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com')

  CREATE TABLE Orders
  (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
)

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1)

  CREATE TABLE Products
  (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
  )

  INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99)

  ----Task--1
---Q1.Write a query to retrieve all records from the Customers table.

Select * From Customers

/*Q2.Write a query to retrieve the names and email addresses
of customers whose names start with 'J'.
*/

Select Name,Email from Customers
Where Name like 'J%'

/*
Q3.Write a query to retrieve the order details (OrderID, ProductName, Quantity)
for all orders..*/

Select OrderID,ProductName,Quantity From Orders

/*
Q4.Write a query to calculate the total quantity of products ordered.
*/

Select Sum(Quantity) As TotalQuantity From Orders

/*
5.	Write a query to retrieve the names of customers who have placed an order.
*/

SELECT C.name FROM Customers AS C
LEFT JOIN  Orders AS O
ON C.CustomerID = O.OrderID
Where Quantity != 0

/*
6.	Write a query to retrieve the products with a price greater than $10.00
*/

Select ProductName ,Price From Products
Where Price >= 10.00

/*
7.	Write a query to retrieve the customer name and order date for all orders 
placed on or after '2023-07-05'.
*/

SELECT C.name,O.OrderDate
FROM Customers AS C
Inner Join  Orders AS O
ON C.CustomerID = O.OrderID
Where OrderDate > '2023-07-05'

/*
8.	Write a query to calculate the average price of all products.
*/
Select AVG(Price) As AveragePrice From Products

/*
9.	Write a query to retrieve the customer names along with the 
total quantity of products they have ordered
*/

SELECT C.Name,O.Quantity
FROM Customers AS C
LEFT JOIN  Orders AS O
ON C.CustomerID = O.OrderID

/*
10.	Write a query to retrieve the products that have not been ordered.
*/

Select ProductName From Orders
Where Quantity = 0

-----Task ---2

/*
1.	Write a query to retrieve the top 5 customers who 
have placed the highest total quantity of orders.
*/

SELECT Top 5 C.Name,O.Quantity
FROM Customers AS C
LEFT JOIN  Orders AS O
ON C.CustomerID = O.OrderID
Order by Quantity Desc

/*
2.	Write a query to calculate the average price of products for each product category.
*/
Select AVG(Price) As AveragePrice,ProductName From Products
Group by ProductName

/*
3.	Write a query to retrieve the customers who have not placed any orders.
*/

SELECT C.Name,O.Quantity
FROM Customers AS C
LEFT JOIN  Orders AS O
ON C.CustomerID = O.OrderID
Where Quantity = 0

/*
4.	Write a query to retrieve the order details (OrderID, ProductName, Quantity) for 
orders placed by customers whose names start with 'M'
*/
Select O.OrderID,O.ProductName,O.Quantity
From Orders As O
Inner Join Customers As C
ON C.CustomerID = O.OrderID
Where Name like 'M%'
 

 /*
 5.	Write a query to calculate the total revenue generated from all orders.
 */

Select Sum(P.Price) as TotalRevenue
From Products as P
Inner Join Orders As O 
On P.ProductID = O.OrderID

/*
6.	Write a query to retrieve the customer names 
along with the total revenue generated from their orders.
*/

SELECT C.Name, SUM(O.Quantity * P.Price) 
AS TotalRevenue FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID
INNER JOIN Products P
on P.ProductName = O.ProductName 
GROUP BY C.Name


/*
7.	Write a query to retrieve the customers who have placed at 
least one order for each product category.
*/

Select C.Name ,O.Quantity
From Customers As C
Inner Join Orders As O
On O.OrderID = C.CustomerID
Where Quantity != 0 

/*8.	Write a query to retrieve the customers who have 
placed orders on consecutive days.
*/
Select C.Name ,O.OrderDate
From Customers As C
Inner Join Orders As O
On O.OrderID = C.CustomerID
Where Quantity > 1


/*
9.	Write a query to retrieve the top 3 products with the 
highest average quantity ordered.
*/

Select Top 3 P.ProductName,
Avg(O.Quantity) As
AverageQuantity From
Products p  inner Join
Orders as O on
P.ProductName =O.ProductName
Group by P.ProductName
Order by AverageQuantity Desc


/*
10.	Write a query to calculate the percentage of orders that
have a quantity greater than the average quantity.
*/

SELECT (COUNT(CASE WHEN O.Quantity > avg.Quantity THEN 1 END) * 100.0) / COUNT(*) 
AS Percentage FROM Orders O
CROSS JOIN (SELECT AVG(Quantity)
AS Quantity FROM Orders) AVG;
 
 
