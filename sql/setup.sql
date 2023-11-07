/* Table creation section */

Create table Products (
product_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
product_name VARCHAR2(50),
product_price NUMBER(10,2),
product_category VARCHAR2(20),

    CONSTRAINT pk_product
        PRIMARY KEY (product_id)

);

Create table Project_City (
city_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
city_name VARCHAR(50),
province_name VARCHAR2(50),
country_name VARCHAR2(50),

    CONSTRAINT pk_project_city PRIMARY KEY (city_id)

);

Create table Project_Address (
address_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
address VARCHAR(50),
city_id NUMBER,

    CONSTRAINT pk_project_address 
        PRIMARY KEY (address_id),
        
    CONSTRAINT pk_project_city 
        FOREIGN KEY (city_id) REFERENCES Project_Province (city_id)

); 


Create table Stores (
store_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
store_name VARCHAR2(50),

    CONSTRAINT pk_store
        PRIMARY KEY (store_id)
);

Create Table Warehouse (
warehouse_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
warehouse_name CHAR(11),
warehouse_address VARCHAR2(50),
city_id NUMBER,
    
    CONSTRAINT pk_warehouseid 
        PRIMARY KEY (warehouse_id),
        
    CONSTRAINT fk_city
        FOREIGN KEY (city_id) REFERENCES Project_Province (city_id) 

);

Create Table Warehouse_Products (
warehouse_id NUMBER, 
product_id NUMBER,
total_quantity NUMBER(10,0),

    CONSTRAINT fk_warehouse_id
        FOREIGN KEY (warehouse_id) REFERENCES Warehouse (warehouse_id), 
        
    CONSTRAINT fk_product_id 
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
        
);

Create Table  Project_Customers (
customer_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
firstname VARCHAR2(50) NOT NULL,
lastname VARCHAR2(50) NOT NULL,
email VARCHAR2(50) NOT NULL,
address VARCHAR2(50),
city_id NUMBER,
    
    CONSTRAINT pk_customer 
        PRIMARY KEY (customer_id),
        
    CONSTRAINT fk_city_id
        FOREIGN KEY (city_id) REFERENCES Project_Province (city_id)
);

Create table Project_Orders (
order_id NUMBER GENERATED ALWAYS AS IDENTITY,
order_quantity NUMBER(10,0),
order_date DATE,
store_id NUMBER,
customer_id NUMBER,
product_id NUMBER,
    
    CONSTRAINT pk_order 
        PRIMARY KEY (order_id),
        
    CONSTRAINT fk_store_id 
        FOREIGN KEY (store_id) REFERENCES Stores (store_id),
    
    CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id) REFERENCES Project_Customers (customer_id),
    
    CONSTRAINT fk_product_order
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

Create table Reviews (
review_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
flag NUMBER(5,0),
description VARCHAR2(200),
customer_id NUMBER,
product_id NUMBER,
    
    CONSTRAINT pk_review
        PRIMARY KEY (review_id),
        
    CONSTRAINT fk_customer_review
        FOREIGN KEY (customer_id) REFERENCES Project_Customers (customer_id),
    CONSTRAINT fk_product_review 
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

CREATE TABLE OrderAuditLog (
    OAL_log_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    event_timestamp TIMESTAMP,
    customer_id NUMBER,
    product_id NUMBER,
    event_description VARCHAR2(200),
    
    CONSTRAINT pk_OAL
        PRIMARY KEY (OAL_log_id)
    
);

CREATE TABLE LoginAuditLog (
    LOL_log_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    event_timestamp TIMESTAMP,
    user_id NUMBER,
    event_description VARCHAR2(200),
    
    CONSTRAINT pk_LOL
        PRIMARY KEY (LOL_log_id)
);

CREATE TABLE StockUpdateAuditLog (
    SUOL_log_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    event_timestamp TIMESTAMP,
    product_id NUMBER,
    previous_stock NUMBER,
    new_stock NUMBER,
    event_description VARCHAR2(200),
    
    CONSTRAINT pk_SUOL
        PRIMARY KEY (SUOL_log_id)
);

COMMIT;
/
/*INSERTING DATA AREA*/

--insert products
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Apple', '5.00', 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Barbie Movie', '30.00', 'DVD');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('BMW i6', '50000.00', 'Cars');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('BMW iX Lego', '40.00', 'Toys');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Chicken', '9.50', 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Lamborghini Lego', '40.00', 'Toys');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Laptop ASUS 104S', '970.00', 'Electronics');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('L"Oreal Normal Hair', '10.00', 'Health');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Orange', '2.00', 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Paper Towel', '16.67', 'Beauty');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Pasta', '4.50', 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Plum', '1.43', 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('PS5', '200.00', 'Electronics');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('SIMS CD', '16.00', 'Video Games');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Truck 500c', '856600.00', 'Vehicle');
    
--insert cities
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Montreal', 'Quebec', 'Canada');
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Laval', 'Quebec', 'Canada');
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Brossard', 'Quebec', 'Canada');
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Toronto', 'Ontario', 'Canada');
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Calgary', 'Alberta', 'Canada');

--insert address
INSERT INTO Address(address, city_id)
    VALUES('090 boul saint laurent', '1');
INSERT INTO Address(address, city_id)
    VALUES('100 atwater street', '4');
INSERT INTO Address(address, city_id)
    VALUES('100 boul saint laurent', '1');
INSERT INTO Address(address, city_id)
    VALUES('100 Young street', '4');
INSERT INTO Address(address, city_id)
    VALUES('104 gill street', '4');
INSERT INTO Address(address, city_id)
    VALUES('105 Young street', '4');
INSERT INTO Address(address, city_id)
    VALUES('22222 happy street', '2');
INSERT INTO Address(address, city_id)
    VALUES('76 boul decalthon', '2');
INSERT INTO Address(address, city_id)
    VALUES('87 boul saint laurent', '1');
INSERT INTO Address(address, city_id)
    VALUES('dawson college', '1');
    
--insert


-- INSERT INTO PROJECT_PROVINCE AREA

-- Sub-programs AREA


-- KEVIN WU

/* Function that checks for the total stocks for a product */


/* Function that checks if a product is available or not */











-- TONY DO

/* Procedure to update the stock quantity when a customer orders a product */
CREATE OR REPLACE PROCEDURE UpdateStockQuantityFromOrder(
    p_order_id NUMBER
) AS
BEGIN
    -- Loop through order items and update stock quantities.
    FOR order_item IN (SELECT po.product_id, po.order_quantity
                       FROM Project_Orders po
                       WHERE po.order_id = p_order_id)
    LOOP
        DECLARE
            v_current_stock NUMBER;
        BEGIN
            -- Get the current stock quantity.
            SELECT wp.total_quantity INTO v_current_stock
            FROM Warehouse_Products wp
            WHERE wp.product_id = order_item.product_id;

            -- Check if there is enough stock to fulfill the order.
            IF v_current_stock >= order_item.order_quantity THEN
                -- Update the stock quantity after the order.
                UPDATE Warehouse_Products
                SET total_quantity = v_current_stock - order_item.order_quantity
                WHERE product_id = order_item.product_id;
            ELSE
                -- Handle insufficient stock (you can raise an exception or perform other actions).
                -- Here, we simply print a message to indicate insufficient stock.
                DBMS_OUTPUT.PUT_LINE('Insufficient stock for product ID ' || order_item.product_id);
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle the case where the product is not found in the Warehouse_Products table.
                DBMS_OUTPUT.PUT_LINE('Product ID ' || order_item.product_id || ' not found in the Warehouse.');
            WHEN OTHERS THEN
                -- Handle other exceptions as needed.
                DBMS_OUTPUT.PUT_LINE('An error occurred while updating stock quantity.');
        END;
    END LOOP;
END;
/

/* Checks for reviews that are flagged */
CREATE OR REPLACE PROCEDURE CheckFlaggedReviews AS
BEGIN
    FOR review_rec IN (SELECT r.review_id, r.description, p.product_name
                      FROM Reviews r
                      JOIN Products p ON r.product_id = p.product_id
                      WHERE r.flag >= 1)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Review ID: ' || review_rec.review_id);
        DBMS_OUTPUT.PUT_LINE('Review Description: ' || review_rec.description);
        DBMS_OUTPUT.PUT_LINE('Product Name: ' || review_rec.product_name);
        DBMS_OUTPUT.PUT_LINE('------------------------------------');
    END LOOP;
END;
/

CREATE OR REPLACE TRIGGER OrderPlacedTrigger
AFTER INSERT ON Project_Orders
FOR EACH ROW
BEGIN
    INSERT INTO OrderAuditLog (event_timestamp, customer_id, product_id, event_description)
    VALUES (SYSTIMESTAMP, :new.customer_id, :new.product_id, 'Customer placed an order');
END;
/

CREATE OR REPLACE TRIGGER StockUpdateTrigger
AFTER UPDATE ON Warehouse_Products
FOR EACH ROW
BEGIN
    IF :new.total_quantity <> :old.total_quantity THEN
        INSERT INTO StockUpdateAuditLog (event_timestamp, product_id, previous_stock, new_stock, event_description)
        VALUES (SYSTIMESTAMP, :new.product_id, :old.total_quantity, :new.total_quantity, 'Stock updated');
    END IF;
END;
/ 




-- HARIS HUSSAIN

/* Anonymous block for testing */
/*DECLARE
     v_product_id NUMBER := 1; 
     v_available NUMBER;
BEGIN 
    -- checking availability 
    v_available := IsProductAvailable(v_product_id);
    IF v_available = 0 THEN
        dbms_output.put_line('That product isnt available');
    END IF;
    
    -- checking for flags 
    CheckFlaggedReviews;
END;*/
