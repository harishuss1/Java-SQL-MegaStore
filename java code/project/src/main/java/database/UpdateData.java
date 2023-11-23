package database;

import java.sql.*;

/**
 * The `UpdateData` class provides methods for updating data in the database using stored procedures.
 * @class
 */
public class UpdateData {

    public static Object updateData;
    private Connection conn;

     /**
     * Constructs an instance of the `UpdateData` class with a specified database connection.
     * @constructor
     * @param conn The database connection.
     */
    public UpdateData(Connection conn) {
        this.conn = conn;
    }

    /**
     * Updates product information in the database.
     * @function
     * @param productId The ID of the product to be updated.
     * @param productName The updated product name.
     * @param productCategory The updated product category.
     */
    public void updateProduct(int productId, String productName, String productCategory) {
        try (CallableStatement callableStatement = conn.prepareCall("{call update_data.update_product(?, ?, ?)}")) {
            callableStatement.setInt(1, productId);
            callableStatement.setString(2, productName);
            callableStatement.setString(3, productCategory);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    /**
     * Updates warehouse information in the database.
     * @function
     * @param warehouseId The ID of the warehouse to be updated.
     * @param warehouseName The updated warehouse name.
     * @param addressId The updated address ID.
     * @param cityId The updated city ID.
     */
    public void updateWarehouse(int warehouseId, String warehouseName, int addressId, int cityId) {
        try (CallableStatement callableStatement = conn
                .prepareCall("{call update_data.update_warehouse(?, ?, ?, ?)}")) {
            callableStatement.setInt(1, warehouseId);
            callableStatement.setString(2, warehouseName);
            callableStatement.setInt(3, addressId);
            callableStatement.setInt(4, cityId);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    /**
     * Updates warehouse product information in the database.
     * @function
     * @param warehouseId The ID of the warehouse for the product.
     * @param productId The ID of the product to be updated.
     * @param quantity The updated quantity of the product.
     */
    public void updateWarehouseProducts(int warehouseId, int productId, int quantity) {
        try (CallableStatement callableStatement = conn
                .prepareCall("{call update_data.update_warehouse_products(?, ?, ?)}")) {
            callableStatement.setInt(1, warehouseId);
            callableStatement.setInt(2, productId);
            callableStatement.setInt(3, quantity);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    /**
     * Updates review information in the database.
     * @function
     * @param reviewId The ID of the review to be updated.
     */
    public void updateReviews(int reviewId) {
        try (CallableStatement callableStatement = conn
                .prepareCall("{call update_data.update_reviews(?)}")) {
            callableStatement.setInt(1, reviewId);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

}
