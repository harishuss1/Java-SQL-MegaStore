CREATE OR REPLACE PACKAGE ProductStockPackage AS
    -- Declare the function signature
    FUNCTION GetTotalStockForProduct(p_product_id NUMBER) RETURN NUMBER;
    FUNCTION IsProductAvailable(p_product_id NUMBER) RETURN NUMBER;
    PROCEDURE UpdateStockQuantityFromOrder(p_order_id NUMBER);
END ProductStockPackage;
/

CREATE OR REPLACE PACKAGE BODY ProductStockPackage AS
    -- Implement the function
    FUNCTION GetTotalStockForProduct(p_product_id NUMBER) RETURN NUMBER AS
        v_total_stock NUMBER;
    BEGIN
        SELECT SUM(total_quantity)
        INTO v_total_stock
        FROM Warehouse_Products WHERE product_id = p_product_id;

        RETURN v_total_stock;
    END GetTotalStockForProduct;
    
    FUNCTION IsProductAvailable(p_product_id NUMBER) RETURN NUMBER AS 
        v_total_stock NUMBER;
        v_product_name VARCHAR2(50);
    BEGIN
        v_total_stock := GetTotalStockForProduct(p_product_id);
        SELECT product_name INTO v_product_name FROM Products WHERE product_id = p_product_id;
        IF v_total_stock > 0 THEN
            dbms_output.put_line('There are ' || v_total_stock || ' available' || ' for ' || v_product_name);
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END IsProductAvailable;
    
    PROCEDURE UpdateStockQuantityFromOrder(p_order_id NUMBER) IS
        v_product_id NUMBER;
        v_order_quantity NUMBER;
    BEGIN
        -- Get the product_id and order_quantity from the Project_Orders table
        SELECT product_id, order_quantity
        INTO v_product_id, v_order_quantity
        FROM Project_Orders
        WHERE order_id = p_order_id;

        -- Update the stock quantity in the Warehouse_Products table
        UPDATE Warehouse_Products
        SET total_quantity = total_quantity - v_order_quantity
        WHERE product_id = v_product_id;

        COMMIT; -- Commit the transaction
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Order not found.');
        WHEN OTHERS THEN
            -- Handle other exceptions if necessary
            dbms_output.put_line('Error updating stock quantity.');
    END UpdateStockQuantityFromOrder;

END ProductStockPackage;
/
DECLARE
    v_product_id NUMBER := 1; -- Replace with the actual product_id you want to test
    v_result NUMBER;
    v_order_id NUMBER;
BEGIN
    v_result := ProductStockPackage.GetTotalStockForProduct(v_product_id);
    DBMS_OUTPUT.PUT_LINE('Total Stock for Product ' || v_product_id || ': ' || v_result);
    
    v_result := ProductStockPackage.IsProductAvailable(v_product_id);
    
    ProductStockPackage.UpdateStockQuantityFromOrder(2);
    
    v_result := ProductStockPackage.IsProductAvailable(v_product_id);
    
    ROLLBACK;
END;
/

