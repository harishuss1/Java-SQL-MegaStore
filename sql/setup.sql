/* Table creation section */

Create Table  Customers (

c_firstname VARCHAR2(50) NOT NULL,
c_lastname VARCHAR2(50) NOT NULL,
c_email VARCHAR2(50) NOT NULL,
c_address VARCHAR2(50) NOT NULL,
c_reviewFlag NUMBER(1)
-- Make sure customer has an address maybe its nullable  
);

Create Table Products (
product_name VARCHAR2(50),
product_price NUMBER,
product_review NUMBER(1),
product_category VARCHAR2(20)

);

Create Table Warehouse (

warehouse VARCHAR2(20) NOT NULL,
warehouse_address VARCHAR2(100) NOT NULL,
quantity NUMBER
);

Create Table Warehouse_Product (

product_name VARCHAR2(50)

);

Create Table Order (
order_date DATE,
product ,
customer names,
email,
address,
stores,
price FROM getTotalPrice,
quantity ,
review flag,
review description,
store ordered,
--/* takes in orders by customer */
);

/* Procedure that calcultes total price depending on quantity */
/* Functions that returns the average review score per product ordered */
CREATE OR REPLACE Function getTotalPrice (

BEGIN 
    SELECT price from Products
        RETURN price * quantity AS totalPrice;
END;

);

CREATE OR REPLACE Procedure checkReviewFlag(

BEGIN
    SELECT c_reviewFlag FROM Customers WHERE c_reviewFlag = 2;
    

END;
);

