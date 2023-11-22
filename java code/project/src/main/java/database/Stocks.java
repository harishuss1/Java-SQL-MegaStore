package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 * The Stocks class provides methods for retrieving total stock information for products.
 * @class
 */
public class Stocks {

    /**
     * Retrieves and prints the total stock for all products.
     * @static
     * @function
     * @param {Connection} connection - The database connection.
     * @throws {SQLException}
     */
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

    /**
     * Retrieves the total count of product IDs.
     * @static
     * @function
     * @param {Connection} connection - The database connection.
     * @returns {number} - The total count of product IDs.
     * @throws {SQLException}
     */
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

    /**
     * Retrieves the total stock for a specific product.
     * @static
     * @function
     * @param {Connection} connection - The database connection.
     * @param {number} productId - The ID of the product.
     * @returns {number} - The total stock for the specified product.
     * @throws {SQLException}
     */
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
