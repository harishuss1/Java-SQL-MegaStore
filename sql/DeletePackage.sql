CREATE OR REPLACE PACKAGE delete_data AS
    PROCEDURE delete_product(vproduct_id IN NUMBER);
    PROCEDURE delete_project_city(vcity_id IN NUMBER);
    PROCEDURE delete_project_address(vaddress_id IN NUMBER);
    PROCEDURE delete_store(vstore_id IN NUMBER);
    PROCEDURE delete_warehouse(vwarehouse_name IN VARCHAR2);
    PROCEDURE delete_warehouse_product(vwarehouse_id IN NUMBER, vproduct_id IN NUMBER);
    PROCEDURE delete_customer(vcustomer_id IN NUMBER);
    PROCEDURE delete_order(vorder_id IN NUMBER);
    PROCEDURE delete_review(vreview_id IN NUMBER);
END delete_data;
/

CREATE OR REPLACE PACKAGE BODY delete_data AS
    
    PROCEDURE delete_product(vproduct_id IN NUMBER) IS
    v_old_product_id   NUMBER;
    v_audit_type       VARCHAR2(30);
    v_audit_timestamp  TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    v_product_name     VARCHAR2(50);
    v_product_price    NUMBER(10,2);
    v_product_category VARCHAR2(20);
    BEGIN
        SELECT product_id, 'DELETE' AS audit_type, product_name, product_price, product_category
            INTO v_old_product_id, v_audit_type, v_product_name, v_product_price, v_product_category FROM Products
            WHERE product_id = vproduct_id;
            
        UPDATE Project_Orders SET product_id = NULL WHERE product_id = vproduct_id;
        DELETE FROM Products WHERE product_id = vproduct_id;
        
        INSERT INTO Products_Audit_Log ( product_id, old_product_id, audit_type, audit_timestamp, product_name, product_price, product_category)
            VALUES (NULL, vproduct_id, v_audit_type, v_audit_timestamp, v_product_name, v_product_price, v_product_category);
    END delete_product;

    -- Deleting project city
    PROCEDURE delete_project_city(vcity_id IN NUMBER) IS
    v_old_city_id NUMBER;
    v_audit_type VARCHAR2(30);
    v_audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    v_city_name VARCHAR2(50);
    v_province_name VARCHAR2(50);
    v_country_name VARCHAR2(50);
    BEGIN
        SELECT city_id, 'DELETE' AS audit_type, city_name, province_name, country_name INTO 
        v_old_city_id, v_audit_type, v_city_name, v_province_name, v_country_name FROM Project_City
        WHERE city_id = vcity_id;
        
        UPDATE Project_Customers SET city_id = NULL WHERE city_id = vcity_id;
        UPDATE Project_Address SET city_id = NULL WHERE city_id = vcity_id;
        DELETE FROM Project_City WHERE city_id = vcity_id;
        
        INSERT INTO Project_City_Audit_Log (city_id, old_city_id, audit_type, audit_timestamp, city_name, province_name, country_name)
        VALUES (NULL, v_old_city_id, v_audit_type, v_audit_timestamp, v_city_name, v_province_name, v_country_name);
    END delete_project_city;

    -- Deleting project address
    PROCEDURE delete_project_address(vaddress_id IN NUMBER) IS
    v_old_address_id NUMBER;
    v_audit_type VARCHAR2(30);
    v_audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    v_address VARCHAR(50);
    v_city_id NUMBER;
    BEGIN
    SELECT address_id, 'DELETE' AS audit_type, address, city_id INTO
    v_old_address_id, v_audit_type, v_address, v_city_id FROM Project_Address WHERE address_id = vaddress_id;
        
        UPDATE Project_Customers SET address_id = NULL WHERE address_id = vaddress_id;
        DELETE FROM Project_Address WHERE address_id = vaddress_id;
    INSERT INTO Project_Address_Audit_Log (address_id, old_address_id, audit_type, audit_timestamp, address, city_id)
        VALUES (NULL, v_old_address_id, v_audit_type, v_audit_timestamp, v_address, v_city_id);
        
    END delete_project_address;

    -- Deleting store
    PROCEDURE delete_store(vstore_id IN NUMBER) IS
    v_old_store_id NUMBER;
    v_audit_type VARCHAR(30);
    v_audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    v_store_name VARCHAR2(50);
    BEGIN
    SELECT store_id, 'DELETE' AS audit_type,store_name INTO v_old_store_id, v_audit_type, v_store_name FROM Stores WHERE store_id = vstore_id;
    
        UPDATE Project_Orders SET store_id = NULL WHERE store_id = vstore_id;
        DELETE FROM Stores WHERE store_id = vstore_id;
    INSERT INTO Stores_Audit_Log (store_id, old_store_id, audit_type, audit_timestamp, store_name)
        VALUES (NULL, v_old_store_id, v_audit_type, v_audit_timestamp, v_store_name);
    END delete_store;

    -- Deleting warehouse
    PROCEDURE delete_warehouse(vwarehouse_name IN VARCHAR2) IS
        vwarehouse_id Warehouse.warehouse_id%TYPE;
        v_old_warehouse_id NUMBER;
        v_product_id NUMBER;
        v_total_quantity NUMBER;
        v_audit_type VARCHAR2(30);
        v_audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP; 
    BEGIN
        -- Get the warehouse_id
        SELECT warehouse_id INTO vwarehouse_id
        FROM Warehouse
        WHERE warehouse_name = vwarehouse_name;
    
        -- Open a cursor to fetch product_id and total_quantity
        FOR warehouse_prod IN (SELECT product_id, total_quantity FROM Warehouse_Products WHERE warehouse_id = vwarehouse_id) 
        LOOP
            -- Store values in variables
            v_product_id := warehouse_prod.product_id;
            v_total_quantity := warehouse_prod.total_quantity;
    
            -- Insert into Warehouse_Products_Audit_Log
            INSERT INTO Warehouse_Products_Audit_Log (warehouse_id, product_id, old_warehouse_id, audit_type, audit_timestamp, total_quantity)
            VALUES (NULL, v_product_id, vwarehouse_id, 'DELETE', SYSTIMESTAMP, v_total_quantity);
    
            -- Delete from Warehouse_Products table
            DELETE FROM Warehouse_Products WHERE warehouse_id = vwarehouse_id AND product_id = v_product_id;
        END LOOP;
    
    END delete_warehouse;
    
    
    -- Deleting warehouse product
    PROCEDURE delete_warehouse_product(vwarehouse_id IN NUMBER, vproduct_id IN NUMBER) IS
    BEGIN
        DELETE FROM Warehouse_Products WHERE warehouse_id = vwarehouse_id AND product_id = vproduct_id;
    END delete_warehouse_product;

    -- Deleting customer
    PROCEDURE delete_customer(vcustomer_id IN NUMBER) IS
    BEGIN
        UPDATE Project_Orders SET customer_id = NULL WHERE customer_id = vcustomer_id;
        UPDATE Reviews SET customer_id = NULL WHERE customer_id = vcustomer_id;
        DELETE FROM Project_Customers WHERE customer_id = vcustomer_id;
    END delete_customer;

    -- Deleting order
    PROCEDURE delete_order(vorder_id IN NUMBER) IS
    BEGIN
        DELETE FROM Project_Orders WHERE order_id = vorder_id;
    END delete_order;

    -- Deleting review
    PROCEDURE delete_review(vreview_id IN NUMBER) IS
    v_old_review_id NUMBER;
    v_audit_type VARCHAR2(30);
    v_audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    v_flag NUMBER(5,0);
    v_description VARCHAR2(200);
    v_review_score NUMBER;
    v_customer_id NUMBER;
    v_product_id NUMBER;
    BEGIN
    
    SELECT review_id, 'DELETE' AS audit_type, flag, description, review_score, customer_id, product_id
    INTO v_old_review_id, v_audit_type, v_flag, v_description, v_review_score, v_customer_id, v_product_id
    FROM Reviews WHERE review_id = vreview_id;
    
        DELETE FROM Reviews WHERE review_id = vreview_id;
        
        INSERT INTO Reviews_Audit_Log (review_id, old_review_id, audit_type, audit_timestamp, flag, description, review_score, customer_id, product_id)
            VALUES (NULL, v_old_review_id, v_audit_type, v_audit_timestamp, v_flag, v_description, v_review_score, v_customer_id, v_product_id);
    END delete_review;

END delete_data;
/
