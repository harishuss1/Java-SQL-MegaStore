package database;

import java.sql.*;

public class DeleteData {

    private Connection conn;

    public DeleteData(Connection conn) {
        this.conn = conn;
    }

    public void deleteProduct(int productId) {
        executeStoredProcedure("delete_data.delete_product(?)", productId);
    }

    public void deleteProjectCity(int cityId) {
        executeStoredProcedure("delete_data.delete_project_city(?)", cityId);
    }

    public void deleteProjectCustomers(int customerId) {
        executeStoredProcedure("delete_data.delete_customer(?)", customerId);
    }

    

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
}
