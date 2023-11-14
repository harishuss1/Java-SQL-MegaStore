CREATE OR REPLACE PACKAGE delete_data AS
    PROCEDURE delete_product(vproduct_id IN NUMBER);
    PROCEDURE delete_project_city(vcity_id IN NUMBER);
    PROCEDURE delete_project_address(vaddress_id IN NUMBER);
    PROCEDURE delete_store(vstore_id IN NUMBER);
    PROCEDURE delete_warehouse(vwarehouse_id IN NUMBER);
    PROCEDURE delete_warehouse_product(vwarehouse_id IN NUMBER, vproduct_id IN NUMBER);
    PROCEDURE delete_customer(vcustomer_id IN NUMBER);
    PROCEDURE delete_order(vorder_id IN NUMBER);
    PROCEDURE delete_review(vreview_id IN NUMBER);
END delete_data;
/

CREATE OR REPLACE PACKAGE BODY delete_data AS
    -- Deleting product
    PROCEDURE delete_product(vproduct_id IN NUMBER) IS
    BEGIN
        DELETE FROM Products WHERE product_id = vproduct_id;
    END delete_product;

    -- Deleting project city
    PROCEDURE delete_project_city(vcity_id IN NUMBER) IS
    BEGIN
        DELETE FROM Project_City WHERE city_id = vcity_id;
    END delete_project_city;

    -- Deleting project address
    PROCEDURE delete_project_address(vaddress_id IN NUMBER) IS
    BEGIN
        DELETE FROM Project_Address WHERE address_id = vaddress_id;
    END delete_project_address;

    -- Deleting store
    PROCEDURE delete_store(vstore_id IN NUMBER) IS
    BEGIN
        DELETE FROM Stores WHERE store_id = vstore_id;
    END delete_store;

    -- Deleting warehouse
    PROCEDURE delete_warehouse(vwarehouse_id IN NUMBER) IS
    BEGIN
        DELETE FROM Warehouse WHERE warehouse_id = vwarehouse_id;
    END delete_warehouse;

    -- Deleting warehouse product
    PROCEDURE delete_warehouse_product(vwarehouse_id IN NUMBER, vproduct_id IN NUMBER) IS
    BEGIN
        DELETE FROM Warehouse_Products WHERE warehouse_id = vwarehouse_id AND product_id = vproduct_id;
    END delete_warehouse_product;

    -- Deleting customer
    PROCEDURE delete_customer(vcustomer_id IN NUMBER) IS
    BEGIN
        DELETE FROM Project_Customers WHERE customer_id = vcustomer_id;
    END delete_customer;

    -- Deleting order
    PROCEDURE delete_order(vorder_id IN NUMBER) IS
    BEGIN
        DELETE FROM Project_Orders WHERE order_id = vorder_id;
    END delete_order;

    -- Deleting review
    PROCEDURE delete_review(vreview_id IN NUMBER) IS
    BEGIN
        DELETE FROM Reviews WHERE review_id = vreview_id;
    END delete_review;

END delete_data;
/
