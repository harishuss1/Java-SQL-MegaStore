package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class InsertData {
    
    private Connection conn;


    public InsertData(Connection conn) {
        this.conn = conn;
    }

            //Not sure how to deal with this.

    // public void insertProduct(String productName, double productPrice, String productCategory) {
    //     executeStoredProcedure("insert_data.add_product(?, ?, ?)", productName, productPrice, productCategory);
    // }

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
