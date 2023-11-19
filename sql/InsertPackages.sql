CREATE OR REPLACE PACKAGE insert_data AS
    PROCEDURE add_product(vproduct IN PRODUCT_TYP);
--    PROCEDURE add_project_city(vcities IN PROJECT_CITY_TYP);
--    PROCEDURE add_project_address(vaddresses IN PROJECT_ADDRESS_TYP);
--    PROCEDURE add_store(vstores IN STORE_TYP);
--    PROCEDURE add_warehouse(vwarehouses IN WAREHOUSE_TYP);
--    PROCEDURE add_warehouse_product(vwarehouse_products IN WAREHOUSE_PRODUCTS_TYP);
--    PROCEDURE add_customer(vcustomers IN PROJECT_CUSTOMERS_TYP);
--    PROCEDURE add_order(vorders IN PROJECT_ORDERS_TYP);
--    PROCEDURE add_review(vreviews IN REVIEWS_TYP);
--    PROCEDURE add_order_audit_log(vorder_audit_logs IN ORDER_AUDIT_LOG_TYP);
END insert_data;
/

CREATE OR REPLACE PACKAGE BODY insert_data AS
    -- Adding product
    PROCEDURE add_product(
        vproduct IN PRODUCT_TYP
    ) IS
    BEGIN
        INSERT INTO Products (product_name, product_price, product_category)
        VALUES (
            vproduct.product_name,
            vproduct.product_price,
            vproduct.product_category
        );
    END add_product;

    -- Adding project city
--    PROCEDURE add_project_city(vcities IN PROJECT_CITY_TYP) IS
--    BEGIN
--        INSERT INTO Project_City
--        VALUES (
--            vcities.city_id,
--            vcities.city_name,
--            vcities.province_name,
--            vcities.country_name
--        );
--    END add_project_city;

    -- Adding project address
--    PROCEDURE add_project_address(vaddresses IN PROJECT_ADDRESS_TYP) IS
--    BEGIN
--        INSERT INTO Project_Address
--        VALUES (
--            vaddresses.address_id,
--            vaddresses.address,
--            vaddresses.city_id
--        );
--    END add_project_address;

    -- Adding store
--    PROCEDURE add_store(vstores IN STORE_TYP) IS
--    BEGIN
--        INSERT INTO Stores
--        VALUES (
--            vstores.store_id,
--            vstores.store_name
--        );
--    END add_store;

    -- Adding warehouse
--    PROCEDURE add_warehouse(vwarehouses IN WAREHOUSE_TYP) IS
--    BEGIN
--        INSERT INTO Warehouse
--        VALUES (
--            vwarehouses.warehouse_id,
--            vwarehouses.warehouse_name,
--            vwarehouses.address_id,
--            vwarehouses.city_id
--        );
--    END add_warehouse;

    -- Adding warehouse product
--    PROCEDURE add_warehouse_product(vwarehouse_products IN WAREHOUSE_PRODUCTS_TYP) IS
--    BEGIN
--        INSERT INTO Warehouse_Products
--        VALUES (
--            vwarehouse_products.warehouse_id,
--            vwarehouse_products.product_id,
--            vwarehouse_products.total_quantity
--        );
--    END add_warehouse_product;

    -- Adding customer
--    PROCEDURE add_customer(vcustomers IN PROJECT_CUSTOMERS_TYP) IS
--    BEGIN
--        INSERT INTO Project_Customers
--        VALUES (
--            vcustomers.customer_id,
--            vcustomers.firstname,
--            vcustomers.lastname,
--            vcustomers.email,
--            vcustomers.address_id,
--            vcustomers.city_id
--        );
--    END add_customer;

    -- Adding order
    PROCEDURE add_order(vorders IN PROJECT_ORDERS_TYP) IS
    BEGIN
        INSERT INTO Project_Orders
        VALUES (
            vorders.order_id,
            vorders.order_quantity,
            vorders.order_date,
            vorders.store_id,
            vorders.customer_id,
            vorders.product_id
        );
    END add_order;

    -- Adding review
--    PROCEDURE add_review(vreviews IN REVIEWS_TYP) IS
--    BEGIN
--        INSERT INTO Reviews
--        VALUES (
--            vreviews.review_id,
--            vreviews.flag,
--            vreviews.description,
--            vreviews.customer_id,
--            vreviews.product_id
--        );
--    END add_review;

    -- Adding order audit log
--    PROCEDURE add_order_audit_log(vorder_audit_logs IN ORDER_AUDIT_LOG_TYP) IS
--    BEGIN
--        INSERT INTO OrderAuditLog
--        VALUES (
--            vorder_audit_logs.OAL_log_id,
--            vorder_audit_logs.event_timestamp,
--            vorder_audit_logs.customer_id,
--            vorder_audit_logs.product_id,
--            vorder_audit_logs.event_description
--        );
--    END add_order_audit_log;


END insert_data;
/
