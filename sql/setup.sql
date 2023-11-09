/* Table creation section */

Create table Products (
product_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
product_name VARCHAR2(50),
product_price NUMBER(10,2),
product_category VARCHAR2(20),

    CONSTRAINT pk_product
        PRIMARY KEY (product_id)

);

Create table Cities (
city VARCHAR2(50) NOT NULL,
province VARCHAR2(50),
country VARCHAR2(50),

    CONSTRAINT pk_Cities PRIMARY KEY (city)
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
city VARCHAR2(30),
    
    CONSTRAINT pk_warehouseid 
        PRIMARY KEY (warehouse_id),
        
    CONSTRAINT fk_city
        FOREIGN KEY (city) REFERENCES Cities (city) 

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
city VARCHAR2(20),
    
    CONSTRAINT pk_customer 
        PRIMARY KEY (customer_id),
        
    CONSTRAINT fk_city_id
        FOREIGN KEY (city) REFERENCES Cities (city)
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
INSERT INTO Cities
    VALUES('montreal', 'quebec', 'canada');
INSERT INTO Cities
    VALUES('brossard', 'quebec', 'canada');
INSERT INTO Cities
    VALUES('laval', 'quebec', 'canada');
INSERT INTO Cities
    VALUES('saint laurent', 'quebec', 'canada');
INSERT INTO Cities
    VALUES('quebec city', 'quebec', 'canada');
INSERT INTO Cities
    VALUES('toronto', 'ontario', 'canada');
INSERT INTO Cities
    VALUES('ottawa', 'ontario', 'canada');
INSERT INTO Cities
    VALUES('calgary', 'alberta', 'canada');

    
    
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Alex', 'Brown', 'alex@gmail.com', '090 boul saint laurent', 'montreal');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Amanda', 'Harry', 'am.harry@yahioo.com', '100 boul saint laurent', 'montreal');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Mahsa', 'Sadeghi', 'msadeghi@dawsoncollege.qc.ca', 'dawson college', 'montreal');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Mahsa', 'Sadeghi', 'ms@gmail.com', '104 gill street', 'toronto');
INSERT INTO Project_Customers(firstname, lastname, email, city)
    VALUES('Martin', 'Alexandre', 'marting@yahoo.com', 'brossard');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Daneil', 'Hanne', 'daneil@yahoo.com', '100 atwater street', 'toronto');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('John', 'Boura', 'bdoura@gmail.com', '100 Young street', 'toronto');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('John', 'belle', 'abcd@yahoo.com', '105 Young street', 'toronto');
INSERT INTO Project_Customers(firstname, lastname, email)
    VALUES('Ari', 'Brown', 'b.a@gmail.com');
INSERT INTO Project_Customers(firstname, lastname, email, city)
    VALUES('Jack', 'Jonhson', 'johnson.a@gmail.com', 'calgary');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Martin', 'Li', 'm.li@gmail.com', '87 boul saint laurent', 'montreal');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Olivia', 'Smith', 'smith@hotmail.com', '76 boul decalthon', 'laval');
INSERT INTO Project_Customers(firstname, lastname, email, address, city)
    VALUES('Noah', 'Garcia', 'g.noah@yahoo.com', '22222 happy street', 'laval');
    
INSERT INTO Products(product_name)
    VALUES('Apple');
INSERT INTO Products(product_name)
    VALUES('Barbie Movie');
INSERT INTO Products(product_name)
    VALUES('BMW i6');
INSERT INTO Products(product_name)
    VALUES('BMW iX Lego');
INSERT INTO Products(product_name)
    VALUES('Chicken');
INSERT INTO Products(product_name)
    VALUES('Lamborghini Lego');
INSERT INTO Products(product_name)
    VALUES('L"Oreal Normal Hair');
INSERT INTO Products(product_name)
    VALUES('Orange');
INSERT INTO Products(product_name)
    VALUES('Paper Towel');
INSERT INTO Products(product_name)
    VALUES('Pasta');
INSERT INTO Products(product_name)
    VALUES('Plum');
INSERT INTO Products(product_name)
    VALUES('PS5');
INSERT INTO Products(product_name)
    VALUES('SIMS CD');
INSERT INTO Products(product_name)
    VALUES('Tomato');
INSERT INTO Products(product_name)
    VALUES('Train X745');
INSERT INTO Products(product_name)
    VALUES('Truck 500c');

INSERT INTO Warehouse(warehouse_name, warehouse_address, city)
    VALUES('warehouse A', '100 rue William', 'saint laurent');
INSERT INTO Warehouse(warehouse_name, warehouse_address, city)
    VALUES('warehouse B', '304 Rue Fran�ois-Perrault, Villera Saint-Michel', 'montreal');
INSERT INTO Warehouse(warehouse_name, warehouse_address, city)
    VALUES('warehouse C', '86700 Weston Rd', 'toronto');
INSERT INTO Warehouse(warehouse_name, warehouse_address, city)
    VALUES('warehouse D', '170  Sideroad', 'quebec city');
INSERT INTO Warehouse(warehouse_name, warehouse_address, city)
    VALUES('warehouse E', '1231 Trudea road', 'ottawa');
INSERT INTO Warehouse(warehouse_name, warehouse_address)
    VALUES('warehouse F', '16  Whitlock Rd');
    
    



--Objects
Create type PRODUCT_TYP  AS object(
product_id NUMBER
product_name VARCHAR2(50),
product_price NUMBER(10,2),
product_category VARCHAR2(20),
);
/


-- Sub-programs AREA


-- KEVIN WU

/* Function that checks for the total stocks for a product */
/* CREATE OR REPLACE FUNCTION GetTotalStockForProduct(
    some_variable NUMBER
) 
RETURN NUMBER AS 
    
BEGIN
    
    RETURN 1;
END GetTotalStockForProduct;
/

/* Function that checks if a product is available or not */
/*CREATE OR REPLACE FUNCTION IsProductAvailable(
    some_variable NUMBER
)
RETURN NUMBER AS 
    some_variable NUMBER;
BEGIN
    RETURN;
END IsProductAvailable;
/ 










-- TONY DO

/* Procedure to update the stock quantity when a customer orders a product */
CREATE OR REPLACE PROCEDURE UpdateStockQuantity(
    p_customer_id NUMBER,
    p_product_id NUMBER,
    p_order_quantity NUMBER

) AS
BEGIN
    UPDATE Warehouse_Products
    SET total_quantity = total_quantity - p_order_quantity
    WHERE warehouse_id = (SELECT warehouse_id FROM Project_Customers WHERE customer_id = p_customer_id
    AND product_id = p_product_id);
    
    COMMIT;
END UpdateStockQuantity;
/

/* Checks for reviews that are flagged */
CREATE OR REPLACE PROCEDURE CheckFlaggedReviews AS 
BEGIN 
    DECLARE 
        v_review_id NUMBER;
        v_description VARCHAR2(200);
    BEGIN
    
    FOR review_rec IN (SELECT review_id, description FROM Reviews WHERE flag = 1) 
        LOOP
        v_review_id := review_rec.review_id;
        v_description := review_rec.description;
        
        dbms_output.put_line('Flagged Review ID: ' || v_review_id);
        dbms_output.put_line('Description: ' || v_description);
        END LOOP;
    END;
END CheckFlaggedReviews;
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
END; */
/