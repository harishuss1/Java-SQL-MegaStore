package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * The InsertData class provides methods for executing stored procedures to insert data into the database.
 * @class
 */
public class InsertData {
    
    private Connection conn;

    /**
     * Creates an instance of the InsertData class.
     * @constructor
     * @param {Connection} conn - The database connection.
     */
    public InsertData(Connection conn) {
        this.conn = conn;
    }

    /**
     * Executes a stored procedure with an integer parameter.
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
