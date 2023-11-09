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
        
    CONSTRAINT fk_project_city 
        FOREIGN KEY (city_id) REFERENCES Project_City (city_id)

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
address_id NUMBER,
city_id NUMBER,
    
    CONSTRAINT pk_warehouse_id 
        PRIMARY KEY (warehouse_id),
    
    CONSTRAINT fk_warehouse_project_address
        FOREIGN KEY (address_id) REFERENCES Project_address (address_id),
        
    CONSTRAINT fk_warehouse_project_city
        FOREIGN KEY (city_id) REFERENCES Project_City (city_id) 

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

Create Table Project_Customers (
customer_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
firstname VARCHAR2(50) NOT NULL,
lastname VARCHAR2(50) NOT NULL,
email VARCHAR2(50) NOT NULL,
address_id NUMBER,
city_id NUMBER,
    
    CONSTRAINT pk_customer 
        PRIMARY KEY (customer_id),
        
    CONSTRAINT fk_city_id
        FOREIGN KEY (city_id) REFERENCES Project_City (city_id),

    CONSTRAINT fk_customer_address 
        FOREIGN KEY (address_id) REFERENCES Project_Address (address_id)
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
    VALUES('Apple', 5.00, 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Barbie Movie', 30.00, 'DVD');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('BMW i6', 50000.00, 'Cars');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('BMW iX Lego', 40.00, 'Toys');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Chicken', 9.50, 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Lamborghini Lego', 40.00, 'Toys');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Laptop ASUS 104S', 970.00, 'Electronics');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('L"Oreal Normal Hair', 10.00, 'Health');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Orange', 2.00, 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Paper Towel', 16.67, 'Beauty');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Pasta', 4.50, 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Plum', 1.43, 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('PS5', 200.00, 'Electronics');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('SIMS CD', 16.00, 'Video Games');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Truck 500c', 856600.00, 'Vehicle');
INSERT INTO Products(product_name, product_category)
    VALUES('Tomato', 'Grocery');
INSERT INTO Products(product_name, product_category)
    VALUES('Train X745', 'Vehicle');
    
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
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Saint Laurent', 'Quebec', 'Canada');
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Ottawa', 'Ontario', 'Canada');
INSERT INTO Project_City(city_name, province_name, country_name)
    VALUES('Quebec City', 'Quebec', 'Canada');

--insert address
CREATE OR REPLACE PROCEDURE InsertAddress(
    p_address VARCHAR2,
    p_city_name VARCHAR2
)
IS
    v_city_id NUMBER;
BEGIN
    -- Get the city ID based on the city name
    SELECT city_id INTO v_city_id
    FROM Project_City
    WHERE city_name = p_city_name;

    -- Insert the data into Project_Address
    INSERT INTO Project_Address (address, city_id)
    VALUES (p_address, v_city_id);
    
    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if necessary
        ROLLBACK; -- Rollback the transaction on error
        RAISE;
END InsertAddress;
/
-- Call the stored procedure to insert data into Project_Address
BEGIN
    InsertAddress('090 boul saint laurent', 'Montreal');
    InsertAddress('100 atwater street', 'Toronto');
    InsertAddress('100 boul saint laurent', 'Montreal');
    InsertAddress('100 Young street', 'Toronto');
    InsertAddress('104 gill street', 'Toronto');
    InsertAddress('105 Young street', 'Toronto');
    InsertAddress('22222 happy street', 'Laval');
    InsertAddress('76 boul decalthon', 'Laval');
    InsertAddress('87 boul saint laurent', 'Montreal');
    InsertAddress('dawson college', 'Montreal');
    InsertAddress('100 rue William', 'Saint Laurent');
    InsertAddress('1231 Trudea road', 'Ottawa');
    InsertAddress('16 Whitlock Rd', 'Calgary');
    InsertAddress('170 Sideroad', 'Calgary');
    InsertAddress('304 Rue Fran�ois-Perrault, Villera Saint-Michel', 'Montreal');
    InsertAddress('86700 Weston Rd', 'Toronto');
    InsertAddress('boul saint laurent', 'Toronto');
END;
/

    
--insert store
INSERT INTO Stores(store_name)
    VALUES('dawson store');
INSERT INTO Stores(store_name)
    VALUES('dealer montreal');
INSERT INTO Stores(store_name)
    VALUES('Dealer one');
INSERT INTO Stores(store_name)
    VALUES('marche adonis');
INSERT INTO Stores(store_name)
    VALUES('marche atwater');
INSERT INTO Stores(store_name)
    VALUES('movie start');
INSERT INTO Stores(store_name)
    VALUES('movie store');
INSERT INTO Stores(store_name)
    VALUES('star store');
INSERT INTO Stores(store_name)
    VALUES('store magic');
INSERT INTO Stores(store_name)
    VALUES('super rue champlain');
INSERT INTO Stores(store_name)
    VALUES('toy r us');

--insert warehouse
CREATE OR REPLACE PROCEDURE InsertWarehouse(
    p_warehouse_name VARCHAR2,
    p_address VARCHAR2,
    p_city_name VARCHAR2
)
IS
    v_address_id NUMBER;
    v_city_id NUMBER;
BEGIN
    -- Get the address_id based on the address
    SELECT address_id INTO v_address_id
    FROM Project_Address
    WHERE address = p_address;

    -- Get the city_id based on the city name
    SELECT city_id INTO v_city_id
    FROM Project_City
    WHERE city_name = p_city_name;

    -- Insert the data into Warehouse
    INSERT INTO Warehouse (warehouse_name, address_id, city_id)
    VALUES (p_warehouse_name, v_address_id, v_city_id);
    
    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if necessary
        ROLLBACK; -- Rollback the transaction on error
        RAISE;
END InsertWarehouse;
/

-- Call the stored procedure to insert data into Warehouse
BEGIN
    InsertWarehouse('Warehouse A', '100 rue William', 'Saint Laurent');
    InsertWarehouse('Warehouse B', '16 Whitlock Rd', 'Montreal');
    InsertWarehouse('Warehouse C', '170 Sideroad', 'Toronto');
    InsertWarehouse('Warehouse D', '304 Rue Fran�ois-Perrault, Villera Saint-Michel', 'Quebec City');
    InsertWarehouse('Warehouse E', '1231 Trudea road', 'Ottawa');
    InsertWarehouse('Warehouse F', '86700 Weston Rd', 'Calgary');
    COMMIT; -- Commit the transaction
END;
/


--insert warehouse_products
CREATE OR REPLACE PROCEDURE InsertWarehouseProduct(
    p_warehouse_name VARCHAR2,
    p_product_name VARCHAR2,
    p_total_quantity NUMBER
)
IS
    v_warehouse_id NUMBER;
    v_product_id NUMBER;
BEGIN
    -- Get the warehouse_id based on the warehouse name
    SELECT warehouse_id INTO v_warehouse_id
    FROM Warehouse
    WHERE warehouse_name = p_warehouse_name;

    -- Get the product_id based on the product name
    SELECT product_id INTO v_product_id
    FROM Products
    WHERE product_name = p_product_name;

    -- Insert the data into Warehouse_Products
    INSERT INTO Warehouse_Products (warehouse_id, product_id, total_quantity)
    VALUES (v_warehouse_id, v_product_id, p_total_quantity);

    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if necessary
        ROLLBACK; -- Rollback the transaction on error
        RAISE;
END InsertWarehouseProduct;
/

-- Call the stored procedure to insert data into Warehouse_Products
BEGIN
    InsertWarehouseProduct('Warehouse A', 'Laptop ASUS 104S', 10);
    InsertWarehouseProduct('Warehouse A', 'Apple', 1000);
    InsertWarehouseProduct('Warehouse A', 'BMW i6', 6);
    InsertWarehouseProduct('Warehouse A', 'Lamborghini Lego', 352222);
    
    InsertWarehouseProduct('Warehouse B', 'Train X745', 24980);
    InsertWarehouseProduct('Warehouse B', 'Tomato', 39484);
    
    InsertWarehouseProduct('Warehouse C', 'Truck 500c', 103);
    InsertWarehouseProduct('Warehouse C', 'PS5', 43242);
    
    InsertWarehouseProduct('Warehouse D', 'Paper Towel', 35405);
    InsertWarehouseProduct('Warehouse D', 'Plum', 6579);
    InsertWarehouseProduct('Warehouse D', 'SIMS CD', 123);
    
    InsertWarehouseProduct('Warehouse E', 'Barbie Movie', 40);
    InsertWarehouseProduct('Warehouse E', 'Train X745', 1000);
    InsertWarehouseProduct('Warehouse E', 'Lamborghini Lego', 98765);
    InsertWarehouseProduct('Warehouse E', 'Train X745', 4543);
    
    InsertWarehouseProduct('Warehouse F', 'L"Oreal Normal Hair', 450);
    InsertWarehouseProduct('Warehouse F', 'Tomato', 3532);
    InsertWarehouseProduct('Warehouse F', 'Chicken', 43523);
    
    COMMIT; -- Commit the transaction
END;
/


--insert customers
CREATE OR REPLACE PROCEDURE InsertCustomer(
    p_firstname VARCHAR2,
    p_lastname VARCHAR2,
    p_email VARCHAR2,
    p_address_name VARCHAR2,
    p_city_name VARCHAR2
)
IS
    v_address_id NUMBER;
    v_city_id NUMBER;
BEGIN
    -- Get the address_id based on the address name
    SELECT address_id INTO v_address_id
    FROM Project_Address
    WHERE address = p_address_name;

    -- Get the city_id based on the city name
    SELECT city_id INTO v_city_id
    FROM Project_City
    WHERE city_name = p_city_name;

    -- Insert the data into Project_Customers
    INSERT INTO Project_Customers (firstname, lastname, email, address_id, city_id)
    VALUES (p_firstname, p_lastname, p_email, v_address_id, v_city_id);
    
    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if necessary
        ROLLBACK; -- Rollback the transaction on error
        RAISE;
END InsertCustomer;
/

-- Call the stored procedure to insert data into Project_Customers
BEGIN
    InsertCustomer('Alex', 'Brown', 'alex@gmail.com', '090 boul saint laurent', 'Montreal');
    /* Martin Alexandre */
    InsertCustomer('Daneil', 'Hanne', 'daneil@yahoo.com', '100 atwater street', 'Toronto');
    InsertCustomer('Alex', 'Brown', 'alex@gmail.com', 'boul saint laurent', 'Montreal');
    /* #7, Martin Alexandre */
    InsertCustomer('Mahsa', 'Sadeghi', 'msadeghi@dawsoncollege.qc.ca', 'dawson college', 'Montreal');
    InsertCustomer('John', 'Boura', 'bdoura@gmail.com', '100 Young street', 'Toronto');
    /* #10 Ari Brown */
    InsertCustomer('Amanda', 'Harry', 'am.harry@yahioo.com', '100 boul saint laurent', 'Montreal');
    /* #12 Jack Jonhson */
    /* 13 Martin Alexandre */
    
    InsertCustomer('Mahsa', 'Sadeghi', 'msadeghi@dawsoncollege.qc.ca', 'dawson college', 'Montreal');
    InsertCustomer('Mahsa', 'Sadeghi', 'msadeghi@dawsoncollege.qc.ca', 'dawson college', 'Montreal');
    InsertCustomer('Mahsa', 'Sadeghi', 'ms@gmail.com', '104 gill street', 'Toronto');
    InsertCustomer('John', 'Belle', 'abcd@yahoo.com', '105 Young street', 'Toronto');
    InsertCustomer('Alex', 'Brown', 'alex@gmail.com', 'boul saint laurent', 'Montreal');
    InsertCustomer('Alex', 'Brown', 'alex@gmail.com', 'boul saint laurent', 'Montreal');
    InsertCustomer('Martin', 'Li', 'm.li@gmail.com', '87 boul saint laurent', 'Montreal');
    InsertCustomer('Olivia', 'Smith', 'smith@hotmail.com', '76 boul decalthon', 'Laval');
    InsertCustomer('Noah', 'Garcia', 'g.noah@yahoo.com', '22222 happy street', 'Laval');
    InsertCustomer('Mahsa', 'Sadeghi', 'msadeghi@dawsoncollege.qc.ca', 'dawson college', 'Montreal');
    InsertCustomer('Olivia', 'Smith', 'smith@hotmail.com', '76 boul decalthon', 'Laval');
    COMMIT; -- Commit the transaction
END;
/




--insert orders
CREATE OR REPLACE PROCEDURE InsertOrder(
    p_order_quantity NUMBER,
    p_order_date DATE,
    p_store_name VARCHAR2,
    p_customer_email VARCHAR2,
    p_product_name VARCHAR2
)
IS
    v_store_id NUMBER;
    v_customer_id NUMBER;
    v_product_id NUMBER;
BEGIN
    -- Get the store_id based on the store name
    SELECT store_id INTO v_store_id
    FROM Stores
    WHERE store_name = p_store_name;
    
    -- Get the customer_id based on the customer email
    SELECT customer_id INTO v_customer_id
    FROM Project_Customers
    WHERE email = p_customer_email;
    
    -- Get the product_id based on the product name
    SELECT product_id INTO v_product_id
    FROM Products
    WHERE product_name = p_product_name;

    -- Insert the data into Project_Orders
    INSERT INTO Project_Orders (order_quantity, order_date, store_id, customer_id, product_id)
    VALUES (p_order_quantity, p_order_date, v_store_id, v_customer_id, v_product_id);
    
    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if necessary
        ROLLBACK; -- Rollback the transaction on error
        RAISE;
END InsertOrder;
/

-- Call the stored procedure to insert data into Project_Orders
BEGIN
    /* Quantity -> Date -> store_name -> email -> product_name */ 
    InsertOrder();
    
    -- Call the procedure with other order data as needed
    COMMIT; -- Commit the transaction
END;
/


--insert reviews
CREATE OR REPLACE PROCEDURE InsertReview(
    p_flag NUMBER,
    p_description VARCHAR2,
    p_customer_email VARCHAR2,
    p_product_name VARCHAR2
)
IS
    v_customer_id NUMBER;
    v_product_id NUMBER;
BEGIN
    -- Get the customer_id based on the customer email
    SELECT customer_id INTO v_customer_id
    FROM Project_Customers
    WHERE email = p_customer_email;
    
    -- Get the product_id based on the product name
    SELECT product_id INTO v_product_id
    FROM Products
    WHERE product_name = p_product_name;

    -- Insert the data into Reviews
    INSERT INTO Reviews (flag, description, customer_id, product_id)
    VALUES (p_flag, p_description, v_customer_id, v_product_id);
    
    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if necessary
        ROLLBACK; -- Rollback the transaction on error
        RAISE;
END InsertReview;
/

-- Call the stored procedure to insert data into Reviews
BEGIN
    /* flag number -> description -> email -> product_name */
    InsertReview(0, 'This is a great product!', 'customer@email.com', 'Product Name');
    
    -- Call the procedure with other review data as needed
    COMMIT; -- Commit the transaction
END;
/


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
