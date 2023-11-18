package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

public class Stocks {

    public static void getTotalStockForAllProducts(Connection connection) {
        

        try {
            // Get the total count of product IDs
            int totalProductCount = getTotalProductCount(connection);

            // Iterate through product IDs
            for (int productId = 1; productId <= totalProductCount; productId++) {
                // Call the function to get total stock for each product
                int totalStock = getTotalStockForProduct(connection, productId);

                // Process the result here if needed
                System.out.println("Product ID: " + productId + ", Total Stock: " + totalStock);
            }

        } 
        catch (SQLException e) {
            e.printStackTrace();
        }

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

    private static int getTotalStockForProduct(Connection connection, int productId) throws SQLException {
        int totalStock = 0;

        try (CallableStatement statement = connection.prepareCall("{ ? = call ProductStockPackage.GetTotalStockForProduct(?) }")) {
            // Register the output parameter
            statement.registerOutParameter(1, java.sql.Types.INTEGER);

            // Set the input parameter (product_id)
            statement.setInt(2, productId);

            // Execute the function
            statement.execute();

            // Retrieve the result
            totalStock = statement.getInt(1);
        }

        return totalStock;
    }
}
