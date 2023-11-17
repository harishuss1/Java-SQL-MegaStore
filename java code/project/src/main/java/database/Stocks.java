package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

public class Stocks {

    public static ResultSet getTotalStockForAllProducts(Connection connection) {
        ResultSet resultSet = null;

        try (CallableStatement statement = connection.prepareCall("{ ? = call ProductStockPackage.GetTotalStockForProduct(?) }")) {

            // Register the output parameter as a cursor
            statement.registerOutParameter(1, OracleTypes.CURSOR);

            // Get the total count of product IDs
            int totalProductCount = getTotalProductCount(connection);

            // Iterate through product IDs
            for (int productId = 1; productId <= totalProductCount; productId++) {
                // Set the input parameter
                statement.setInt(2, productId);

                // Execute the function
                statement.execute();

                // Retrieve the result set
                resultSet = (ResultSet) statement.getObject(1);
                
                // Process the result set here if needed
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultSet;
    }

    private static int getTotalProductCount(Connection connection) throws SQLException {
        int totalProductCount = 0;

        try (CallableStatement statement = connection.prepareCall("{ ? = call ProductStockPackage.GetTotalProductCount }")) {
            // Register the output parameter
            statement.registerOutParameter(1, java.sql.Types.INTEGER);

            // Execute the function
            statement.execute();

            // Retrieve the result
            totalProductCount = statement.getInt(1);
        }

        return totalProductCount;
    }
}
