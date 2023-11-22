package database;

import java.sql.*;

/**
 * The UpdateData class provides methods for updating product and warehouse information in the database.
 * @class
 */
public class UpdateData {

    public static Object updateData;
    private Connection conn;

    /**
     * Creates an instance of UpdateData with a specified database connection.
     * @constructor
     * @param {Connection} conn - The database connection.
     */
    public UpdateData(Connection conn) {
        this.conn = conn;
    }

    /**
     * Updates product information in the database.
     * @function
     * @param {number} productId - The ID of the product to update.
     * @param {string} productName - The new name of the product.
     * @param {number} productPrice - The new price of the product.
     * @param {string} productCategory - The new category of the product.
     * @throws {SQLException}
     */
    public void updateProduct(int productId, String productName, int productPrice, String productCategory) {
        try (CallableStatement callableStatement = conn.prepareCall("{call update_data.update_product(?, ?, ?, ?)}")) {
            callableStatement.setInt(1, productId);
            callableStatement.setString(2, productName);
            callableStatement.setInt(3, productPrice);
            callableStatement.setString(4, productCategory);
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
     * @param {number} warehouseId - The ID of the warehouse to update.
     * @param {string} warehouseName - The new name of the warehouse.
     * @param {number} addressId - The new address ID of the warehouse.
     * @param {number} cityId - The new city ID of the warehouse.
     * @throws {SQLException}
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

}
