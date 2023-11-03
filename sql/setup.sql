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
address VARCHAR2(50) NOT NULL,
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
COMMIT;





