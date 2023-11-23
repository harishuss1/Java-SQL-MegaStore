package database;

import java.sql.*;

/**
 * The DeleteData class provides methods for deleting data from the database using stored procedures.
 * @class
 */
public class DeleteData {

    public static Object deleteData;
    private Connection conn;

    /**
     * Creates an instance of DeleteData with a specified database connection.
     * @constructor
     * @param {Connection} conn - The database connection.
     */
    public DeleteData(Connection conn) {
        this.conn = conn;
    }

    /**
     * Delete methods that removes a record from the database, depends on the field
     * @param {number} fieldId - The ID of the record to delete
     */
    public void deleteProduct(int productId) {
        executeStoredProcedure("delete_data.delete_product(?)", productId);
    }

    public void deleteProjectCity(int cityId) {
        executeStoredProcedure("delete_data.delete_project_city(?)", cityId);
    }
    
    public void deleteProjectCustomers(int customerId) {
        executeStoredProcedure("delete_data.delete_customer(?)", customerId);
    }
    
    public void deleteAddress(int addressId) {
        executeStoredProcedure("delete_data.delete_project_address(?)", addressId);
    }

    public void deleteStores(int storeId) {
        executeStoredProcedure("delete_data.delete_store(?)", storeId);
    }

    public void deleteReviews(int reviewId) {
        executeStoredProcedure("delete_data.delete_review(?)", reviewId);
    }
    
    public void deleteWarehouse(String warehouse_Name) {
        executeStoredProcedure("delete_data.delete_warehouse(?)", warehouse_Name);
    }

    public void deleteOrder(int orderId) {
        executeStoredProcedure("delete_data.delete_order(?)", orderId);
    }

    /**
     * Executes a stored procedure with an integer parameter.
     * @private
     * @param {string} procedureCall - The stored procedure call.
     * @param {number} parameter - The integer parameter for the stored procedure.
     */
    private void executeStoredProcedure(String procedureCall, int parameter) {
        try (CallableStatement callableStatement = conn.prepareCall("{call " + procedureCall + "}")) {
            callableStatement.setInt(1, parameter);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } 
        catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    /**
     * Executes a stored procedure with a string parameter.
     * @private
     * @param {string} procedureCall - The stored procedure call.
     * @param {string} parameter - The string parameter for the stored procedure.
     */
    private void executeStoredProcedure(String procedureCall, String parameter) {
        try (CallableStatement callableStatement = conn.prepareCall("{call " + procedureCall + "}")) {
            callableStatement.setString(1, parameter);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }
}
