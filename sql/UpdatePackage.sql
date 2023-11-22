CREATE OR REPLACE PACKAGE update_data AS
    PROCEDURE update_product(
        vproduct_id IN NUMBER,
        vproduct_name IN VARCHAR2,
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
    PROCEDURE update_reviews(
        vreview_id IN NUMBER
    );
END update_data;
/

CREATE OR REPLACE PACKAGE BODY update_data AS
    -- Update Products
    PROCEDURE update_product(
        vproduct_id IN NUMBER,
        vproduct_name IN VARCHAR2,
        vproduct_category IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Products
        SET
            product_name = vproduct_name,
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
    
    --Update Warehouse_products (inventory)
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
    
    --update reviews
    PROCEDURE update_reviews(
        vreview_id IN NUMBER
    ) IS
        vflag NUMBER;
    BEGIN
        SELECT flag INTO vflag
        FROM Reviews
        WHERE review_id = vreview_id;
        
        IF vflag >= 1 THEN
            UPDATE Reviews
            SET
                flag = 0
            WHERE review_id = vreview_id;
        END IF;
    END update_reviews;
    
END update_data;
/
