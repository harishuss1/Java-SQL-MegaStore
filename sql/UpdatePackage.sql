CREATE OR REPLACE PACKAGE update_data AS
    PROCEDURE update_product(
        vproduct_id IN NUMBER,
        vproduct_name IN VARCHAR2,
        vproduct_price IN NUMBER,
        vproduct_category IN VARCHAR2
    );
    PROCEDURE update_warehouse(
        vwarehouse_id IN NUMBER,
        vwarehouse_name IN CHAR,
        vaddress_id IN NUMBER,
        vcity_id IN NUMBER
    );
    PROCEDURE update_warehouse_products(
        vwarehouse_id IN NUMBER,
        vproduct_id IN NUMBER,
        vtotal_quantity IN NUMBER
    );
END update_data;
/

CREATE OR REPLACE PACKAGE BODY update_data AS
    -- Update Products
    PROCEDURE update_product(
        vproduct_id IN NUMBER,
        vproduct_name IN VARCHAR2,
        vproduct_price IN NUMBER,
        vproduct_category IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Products
        SET
            product_name = vproduct_name,
            product_price = vproduct_price,
            product_category = vproduct_category
        WHERE product_id = vproduct_id;
    END update_product;

    --Update Warehouse
    PROCEDURE update_warehouse(
        vwarehouse_id IN NUMBER,
        vwarehouse_name IN CHAR,
        vaddress_id IN NUMBER,
        vcity_id IN NUMBER
    ) IS
    BEGIN
        UPDATE Warehouse
        SET
            warehouse_name = vwarehouse_name,
            address_id = vaddress_id,
            city_id = vcity_id
        WHERE warehouse_id = vwarehouse_id;
    END update_warehouse;
    
    --Update Warehouse_products
    PROCEDURE update_warehouse_products(
        vwarehouse_id IN NUMBER,
        vproduct_id IN NUMBER,
        vtotal_quantity IN NUMBER
    ) IS
    BEGIN
        UPDATE Warehouse_Products
        SET
            total_quantity = vtotal_quantity
        WHERE warehouse_id = vwarehouse_id
        AND product_id = vproduct_id;
    END update_warehouse_products;
    
END update_data;
/
BEGIN
    update_data.update_product(17, 'Train X745', 420, 'Vehicle');
    update_data.update_warehouse(1, 'Warehouse A', 11, 6);
    update_data.update_warehouse_products(1, 7, 10);
END;
