/* Table creation section */

Create table Products (
product_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
product_name VARCHAR2(50),
product_price NUMBER(10,2) NOT NULL,
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
review_score NUMBER,
customer_id NUMBER,
product_id NUMBER,
    
    CONSTRAINT pk_review
        PRIMARY KEY (review_id),
        
    CONSTRAINT fk_customer_review
        FOREIGN KEY (customer_id) REFERENCES Project_Customers (customer_id),
    CONSTRAINT fk_product_review 
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

-- Audit table for Products
CREATE TABLE Products_Audit_Log (
    audit_products_id NUMBER GENERATED ALWAYS AS IDENTITY,
    product_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    product_name VARCHAR2(50),
    product_price NUMBER(10,2),
    product_category VARCHAR2(20),
    
    PRIMARY KEY (audit_products_id),
    CONSTRAINT fk_product_audit_log
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

-- Audit table for Project_Address 
CREATE TABLE Project_Address_Audit_Log (
    audit_address_id NUMBER GENERATED ALWAYS AS IDENTITY,
    address_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    address VARCHAR(50),
    city_id NUMBER,

    PRIMARY KEY (audit_address_id),
    
    CONSTRAINT fk_address_audit_log
        FOREIGN KEY (address_id) REFERENCES Project_Address (address_id),
    CONSTRAINT fk_city_audit_log
        FOREIGN KEY (city_id) REFERENCES Project_City (city_id)
);

-- Audit table for Project_City 
CREATE TABLE Project_City_Audit_Log (
    audit_city_id NUMBER GENERATED ALWAYS AS IDENTITY,
    city_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    city_name VARCHAR2(50),
    province_name VARCHAR2(50),
    country_name VARCHAR2(50),

    PRIMARY KEY (audit_city_id),
    
    CONSTRAINT fk_project_city_audit_log
        FOREIGN KEY (city_id) REFERENCES Project_City (city_id)
);

-- Audit table for Stores
CREATE TABLE Stores_Audit_Log (
    audit_store_id NUMBER GENERATED ALWAYS AS IDENTITY,
    store_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    store_name VARCHAR2(50),

    PRIMARY KEY (audit_store_id),
    
    CONSTRAINT fk_store_audit_log
        FOREIGN KEY (store_id) REFERENCES Stores (store_id)
);

-- Audit table for Warehouse_Products
CREATE TABLE Warehouse_Products_Audit_Log (
    audit_warehouseProducts_id NUMBER GENERATED ALWAYS AS IDENTITY,
    warehouse_id NUMBER,
    product_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_quantity NUMBER(10,0),

    PRIMARY KEY (audit_warehouseProducts_id),
    
    CONSTRAINT fk_warehouseProducts_audit_log
        FOREIGN KEY (warehouse_id) REFERENCES Warehouse (warehouse_id),
    
    CONSTRAINT fk_productForWarehouse_audit_log 
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

-- Audit table for Project_Customers 
CREATE TABLE Project_Customers_Audit_Log (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY,
    customer_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    firstname VARCHAR2(50) NOT NULL,
    lastname VARCHAR2(50) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    address_id NUMBER,
    city_id NUMBER,

    PRIMARY KEY (audit_id),

    CONSTRAINT fk_customer_audit_log
        FOREIGN KEY (customer_id) REFERENCES Project_Customers (customer_id),
    
    CONSTRAINT fk_cityCustomer_audit_log
        FOREIGN KEY (city_id) REFERENCES Project_City (city_id),

    CONSTRAINT fk_addressOfCustomer_audit_log
        FOREIGN KEY (address_id) REFERENCES Project_Address (address_id)
);

-- Audit table for Project_Orders
CREATE TABLE Project_Orders_Audit_Log (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY,
    order_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_quantity NUMBER(10,0),
    order_date DATE,
    store_id NUMBER,
    customer_id NUMBER,
    product_id NUMBER,

    PRIMARY KEY (audit_id),

    CONSTRAINT fk_order_audit_log
        FOREIGN KEY (order_id) REFERENCES Project_Orders (order_id),
    
    CONSTRAINT fk_storeOrder_audit_log
        FOREIGN KEY (store_id) REFERENCES Stores (store_id),

    CONSTRAINT fk_customerOrder_audit_log
        FOREIGN KEY (customer_id) REFERENCES Project_Customers (customer_id),

    CONSTRAINT fk_product_order_audit_log
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

-- Audit table for Reviews
CREATE TABLE Reviews_Audit_Log (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY,
    review_id NUMBER,
    audit_type VARCHAR2(10),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    flag NUMBER(5,0),
    description VARCHAR2(200),
    review_score NUMBER,
    customer_id NUMBER,
    product_id NUMBER,

    PRIMARY KEY (audit_id),

    CONSTRAINT fk_review_audit_log
        FOREIGN KEY (review_id) REFERENCES Reviews (review_id),
    
    CONSTRAINT fk_customerReview_audit_log
        FOREIGN KEY (customer_id) REFERENCES Project_Customers (customer_id),

    CONSTRAINT fk_product_review_audit_log
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
);


-- Trigger for Products
CREATE OR REPLACE TRIGGER Products_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Products
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;
    
    IF INSERTING OR UPDATING THEN
        INSERT INTO Products_Audit_Log (product_id, audit_type, product_name, product_price, product_category)
            VALUES(:NEW.product_id, v_audit_type, :NEW.product_name, :NEW.product_price, :NEW.product_category);
    ELSIF DELETING THEN
        INSERT INTO Products_Audit_Log (product_id, audit_type, product_name, product_price, product_category)
            VALUES(:OLD.product_id, v_audit_type, :OLD.product_name, :OLD.product_price, :OLD.product_category);
    END IF;
END Products_Audit_Trigger;
/

-- Trigger for Project_Address
CREATE OR REPLACE TRIGGER Project_Address_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Project_Address
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN

    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;

    -- Insert a record into the audit log
    IF INSERTING OR UPDATING THEN
        INSERT INTO Project_Address_Audit_Log (address_id, audit_type, address, city_id)
        VALUES (:NEW.address_id, v_audit_type, :NEW.address, :NEW.city_id);
    ELSIF DELETING THEN
        INSERT INTO Project_Address_Audit_Log (address_id, audit_type, address, city_id)
        VALUES (:OLD.address_id, v_audit_type, :OLD.address, :OLD.city_id);
    END IF;
END;
/

-- Trigger for Project_City
CREATE OR REPLACE TRIGGER Project_City_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Project_City
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    -- Determine the audit type based on the SQL operation
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;

    -- Insert a record into the audit log
    IF INSERTING OR UPDATING THEN
        INSERT INTO Project_City_Audit_Log (city_id, audit_type, city_name, province_name, country_name)
        VALUES (:NEW.city_id, v_audit_type, :NEW.city_name, :NEW.province_name, :NEW.country_name);
    ELSIF DELETING THEN
        INSERT INTO Project_City_Audit_Log (city_id, audit_type, city_name, province_name, country_name)
        VALUES (:OLD.city_id, v_audit_type, :OLD.city_name, :OLD.province_name, :OLD.country_name);
    END IF;
END;
/

-- Trigger for Stores
CREATE OR REPLACE TRIGGER Stores_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Stores
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    -- Determine the audit type based on the SQL operation
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;

    -- Insert a record into the audit log
    IF INSERTING OR UPDATING THEN
        INSERT INTO Stores_Audit_Log (store_id, audit_type,store_name)
        VALUES (:NEW.store_id, v_audit_type, :NEW.store_name);
    ELSIF DELETING THEN
        INSERT INTO Stores_Audit_Log (store_id, audit_type, store_name)
        VALUES (:OLD.store_id, v_audit_type, :OLD.store_name);
    END IF;
END;
/

-- Trigger for Warehouse_Products
CREATE OR REPLACE TRIGGER Warehouse_Products_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Warehouse_Products
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    -- Determine the audit type based on the SQL operation
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;

    -- Insert a record into the audit log
    IF INSERTING OR UPDATING THEN
        INSERT INTO Warehouse_Products_Audit_Log (warehouse_id, product_id, audit_type, total_quantity)
        VALUES (:NEW.warehouse_id, :NEW.product_id, v_audit_type, :NEW.total_quantity);
    ELSIF DELETING THEN
        INSERT INTO Warehouse_Products_Audit_Log (warehouse_id, product_id, audit_type, total_quantity)
        VALUES (:OLD.warehouse_id, :OLD.product_id, v_audit_type, :OLD.total_quantity);
    END IF;
END;
/

-- Trigger for Project_Customers
CREATE OR REPLACE TRIGGER Project_Customers_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Project_Customers
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;

    INSERT INTO Project_Customers_Audit_Log (customer_id, audit_type, audit_timestamp, firstname, lastname, email, address_id, city_id)
        VALUES (:NEW.customer_id, v_audit_type, CURRENT_TIMESTAMP, :NEW.firstname, :NEW.lastname, :NEW.email, :NEW.address_id, :NEW.city_id);
END Project_Customers_Audit_Trigger;
/

-- Trigger for Project_Orders
CREATE OR REPLACE TRIGGER Project_Orders_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Project_Orders
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;
    
    INSERT INTO Project_Orders_Audit_Log (order_id,audit_type,audit_timestamp,order_quantity,order_date,store_id,customer_id,product_id)
        VALUES (:NEW.order_id, v_audit_type, CURRENT_TIMESTAMP, :NEW.order_quantity, :NEW.order_date, :NEW.store_id, :NEW.customer_id, :NEW.product_id);
END Project_Orders_Audit_Trigger;    
/

-- Trigger for Reviews
CREATE OR REPLACE TRIGGER Reviews_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON Reviews
FOR EACH ROW
DECLARE
    v_audit_type VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_audit_type := 'INSERT';
    ELSIF UPDATING THEN
        v_audit_type := 'UPDATE';
    ELSIF DELETING THEN
        v_audit_type := 'DELETE';
    END IF;
    INSERT INTO Reviews_Audit_Log (review_id, audit_type, audit_timestamp, flag ,description, review_score, customer_id, product_id)
        VALUES (:NEW.review_id, v_audit_type, CURRENT_TIMESTAMP, :NEW.flag, :NEW.description, :NEW.review_score, :NEW.customer_id, :NEW.product_id);
END Reviews_Audit_Trigger;
/

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
    VALUES('L''Oreal Normal Hair', 10.00, 'Health');
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
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Tomato', 1.5, 'Grocery');
INSERT INTO Products(product_name, product_price, product_category)
    VALUES('Train X745', 420, 'Vehicle');
    
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
    InsertAddress('304 Rue François-Perrault, Villera Saint-Michel', 'Montreal');
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
    InsertWarehouse('Warehouse D', '304 Rue François-Perrault, Villera Saint-Michel', 'Quebec City');
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
    
    InsertWarehouseProduct('Warehouse F', 'L''Oreal Normal Hair', 450);
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
    IF p_address_name IS NOT NULL THEN
        SELECT address_id INTO v_address_id
        FROM Project_Address
        WHERE address = p_address_name;
    END IF;
    -- Get the city_id based on the city name
    IF p_city_name IS NOT NULL THEN
        SELECT city_id INTO v_city_id
        FROM Project_City
        WHERE city_name = p_city_name;
    END IF;
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
    -- arnt email unique?? typo in address?--> InsertCustomer('Alex', 'Brown', 'alex@gmail.com', 'boul saint laurent', 'Montreal');
    InsertCustomer('Amanda', 'Harry', 'am.harry@yahioo.com', '100 boul saint laurent', 'Montreal');
    InsertCustomer('Ari', 'Brown', 'b.a@gmail.com', null, null);
    InsertCustomer('Daneil', 'Hanne', 'daneil@yahoo.com', '100 atwater street', 'Toronto');
    InsertCustomer('Jack', 'Jonhson', 'johnson.a@gmail.com', null, 'Calgary');
    InsertCustomer('John', 'Boura', 'bdoura@gmail.com', '100 Young street', 'Toronto');
    InsertCustomer('John', 'Belle', 'abcd@yahoo.com', '105 Young street', 'Toronto');
    InsertCustomer('Mahsa', 'Sadeghi', 'msadeghi@dawsoncollege.qc.ca', 'dawson college', 'Montreal');
    InsertCustomer('Mahsa', 'Sadeghi', 'ms@gmail.com', '104 gill street', 'Toronto');
    InsertCustomer('Martin', 'Alexandre', 'marting@yahoo.com', null, 'Brossard');
    InsertCustomer('Martin', 'Li', 'm.li@gmail.com', '87 boul saint laurent', 'Montreal');
    InsertCustomer('Olivia', 'Smith', 'smith@hotmail.com', '76 boul decalthon', 'Laval');
    InsertCustomer('Noah', 'Garcia', 'g.noah@yahoo.com', '22222 happy street', 'Laval');
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
    WHERE email = p_customer_email
    AND ROWNUM = 1;
    
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
    InsertOrder(1, '2023-04-21', 'marche adonis', 'msadeghi@dawsoncollege.qc.ca', 'Laptop ASUS 104S');
    InsertOrder(2, '2023-10-23', 'marche atwater', 'alex@gmail.com', 'Apple');
    InsertOrder(3, '2023-10-01', 'dawson store', 'marting@yahoo.com', 'SIMS CD');
    InsertOrder(1, '2023-10-23', 'store magic', 'daneil@yahoo.com', 'Orange');
    InsertOrder(1, '2023-10-23', 'movie store', 'alex@gmail.com', 'Barbie Movie');
    InsertOrder(1, '2023-10-10', 'super rue champlain', 'marting@yahoo.com', 'L''Oreal Normal Hair');
    InsertOrder(1, '2023-10-11', 'toy r us', 'msadeghi@dawsoncollege.qc.ca', 'BMW iX Lego');
    InsertOrder(1, '2023-10-10', 'Dealer one', 'bdoura@gmail.com', 'BMW i6');
    InsertOrder(1, null, 'dealer montreal', 'b.a@gmail.com', 'Truck 500c');
    InsertOrder(3, null, 'movie start', 'am.harry@yahioo.com', 'Paper Towel');
    InsertOrder(6, '2020-05-06', 'marche atwater', 'johnson.a@gmail.com', 'Plum');
    InsertOrder(3, '2019-09-12', 'super rue champlain', 'marting@yahoo.com', 'L''Oreal Normal Hair');
    InsertOrder(1, '2010-10-11', 'toy r us', 'msadeghi@dawsoncollege.qc.ca', 'Lamborghini Lego');
    InsertOrder(7, '2022-05-06', 'marche atwater', 'msadeghi@dawsoncollege.qc.ca', 'Plum');
    InsertOrder(2, '2023-10-07', 'toy r us', 'ms@gmail.com', 'Lamborghini Lego');
    InsertOrder(1, '2023-08-10', 'Dealer one', 'abcd@yahoo.com', 'BMW i6');
    InsertOrder(1, '2023-10-23', 'movie store', 'alex@gmail.com', 'SIMS CD');
    InsertOrder(1, '2023-10-02', 'toy r us', 'alex@gmail.com', 'Barbie Movie');
    InsertOrder(1, '2019-04-03', 'marche adonis', 'm.li@gmail.com', 'Chicken');
    InsertOrder(3, '2021-12-29', 'marche atwater', 'smith@hotmail.com', 'Pasta');
    InsertOrder(1, '2020-01-20', 'star store', 'g.noah@yahoo.com', 'PS5');
    InsertOrder(1, '2022-10-11', 'toy r us', 'msadeghi@dawsoncollege.qc.ca', 'BMW iX Lego');
    InsertOrder(3, '2021-12-29', 'store magic', 'smith@hotmail.com', 'Pasta');
    COMMIT; -- Commit the transaction
END;
/


--insert reviews
CREATE OR REPLACE PROCEDURE InsertReview(
    p_flag NUMBER,
    p_description VARCHAR2,
    p_review_score NUMBER,
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
    INSERT INTO Reviews (flag, description, review_score, customer_id, product_id)
    VALUES (p_flag, p_description, p_review_score, v_customer_id, v_product_id);
    
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
    InsertReview(0, 'it was affordable.', 4, 'msadeghi@dawsoncollege.qc.ca', 'Laptop ASUS 104S');
    InsertReview(0, 'quality was not good', 3, 'alex@gmail.com', 'Apple');
    InsertReview(1, null, 2, 'marting@yahoo.com', 'SIMS CD');
    InsertReview(0, 'highly recommend', 5, 'daneil@yahoo.com', 'Orange');
    InsertReview(0, null, 1, 'alex@gmail.com', 'Barbie Movie');
    InsertReview(0, 'did not worth the price', 1, 'marting@yahoo.com', 'L''Oreal Normal Hair');
    InsertReview(0, 'missing some parts', 1, 'msadeghi@dawsoncollege.qc.ca', 'BMW iX Lego');
    InsertReview(1, 'trash', 5, 'bdoura@gmail.com', 'BMW i6');
    InsertReview(0, null, 2, 'b.a@gmail.com', 'Truck 500c');
    InsertReview(0, null, 5, 'am.harry@yahioo.com', 'Paper Towel');
    InsertReview(0, null, 4, 'johnson.a@gmail.com', 'Plum');
    InsertReview(0, null, 3, 'marting@yahoo.com', 'L''Oreal Normal Hair');
    InsertReview(0, 'missing some parts', 1, 'msadeghi@dawsoncollege.qc.ca', 'Lamborghini Lego');
    InsertReview(0, null, 4, 'msadeghi@dawsoncollege.qc.ca', 'Plum');
    InsertReview(0, 'great product', 1, 'ms@gmail.com', 'Lamborghini Lego');
    InsertReview(1, 'bad quality', 5, 'abcd@yahoo.com', 'BMW i6');
    InsertReview(0, null, 1, 'alex@gmail.com', 'SIMS CD');
    InsertReview(0, null, 4, 'alex@gmail.com', 'Barbie Movie');
    InsertReview(0, null, 4, 'm.li@gmail.com', 'Chicken');
    InsertReview(0, null, null, 'g.noah@yahoo.com', 'PS5');
    InsertReview(2, 'worse car i have droven!', 1, 'msadeghi@dawsoncollege.qc.ca', 'BMW iX Lego');
    InsertReview(0, null, 4, 'smith@hotmail.com', 'Pasta'); 
    COMMIT; -- Commit the transaction
END;
/


-- HARIS HUSSAIN



--Making Objects for each Table

CREATE OR REPLACE TYPE PRODUCT_TYP AS OBJECT (
    product_id NUMBER,
    product_name VARCHAR2(50),
    product_price NUMBER(10,2),
    product_category VARCHAR2(20)
);
/
CREATE OR REPLACE TYPE PROJECT_CITY_TYP AS OBJECT (
    city_id NUMBER,
    city_name VARCHAR2(50),
    province_name VARCHAR2(50),
    country_name VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE PROJECT_ADDRESS_TYP AS OBJECT (
    address_id NUMBER,
    address VARCHAR2(50),
    city_id NUMBER
);
/
CREATE OR REPLACE TYPE STORE_TYP AS OBJECT (
    store_id NUMBER,
    store_name VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE WAREHOUSE_TYP AS OBJECT (
    warehouse_id NUMBER,
    warehouse_name CHAR(11),
    address_id NUMBER,
    city_id NUMBER
);
/
CREATE OR REPLACE TYPE WAREHOUSE_PRODUCTS_TYP AS OBJECT (
    warehouse_id NUMBER,
    product_id NUMBER,
    total_quantity NUMBER(10,0)
);
/
CREATE OR REPLACE TYPE PROJECT_CUSTOMERS_TYP AS OBJECT (
    customer_id NUMBER,
    firstname VARCHAR2(50),
    lastname VARCHAR2(50),
    email VARCHAR2(50),
    address_id NUMBER,
    city_id NUMBER
);
/
CREATE OR REPLACE TYPE PROJECT_ORDERS_TYP AS OBJECT (
    order_id NUMBER,
    order_quantity NUMBER(10,0),
    order_date DATE,
    store_id NUMBER,
    customer_id NUMBER,
    product_id NUMBER
);
/
CREATE OR REPLACE TYPE REVIEWS_TYP AS OBJECT (
    review_id NUMBER,
    flag NUMBER(5,0),
    description VARCHAR2(200),
    customer_id NUMBER,
    product_id NUMBER
);
/
CREATE OR REPLACE TYPE ORDER_AUDIT_LOG_TYP AS OBJECT (
    OAL_log_id NUMBER,
    event_timestamp TIMESTAMP,
    customer_id NUMBER,
    product_id NUMBER,
    event_description VARCHAR2(200)
);
/
CREATE OR REPLACE TYPE LOGIN_AUDIT_LOG_TYP AS OBJECT (
    LOL_log_id NUMBER,
    event_timestamp TIMESTAMP,
    user_id NUMBER,
    event_description VARCHAR2(200)
);
/
CREATE OR REPLACE TYPE STOCK_UPDATE_AUDIT_LOG_TYP AS OBJECT (
    SUOL_log_id NUMBER,
    event_timestamp TIMESTAMP,
    product_id NUMBER,
    previous_stock NUMBER,
    new_stock NUMBER,
    event_description VARCHAR2(200)
);
/
