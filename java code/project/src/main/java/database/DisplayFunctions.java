package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import oracle.jdbc.OracleTypes;

/**
 * The DisplayFunctions class provides methods for displaying information from the database.
 * @class
 */
public class DisplayFunctions {

    private Connection conn;

    /**
     * Creates an instance of DisplayFunctions with the specified database connection.
     * @constructor
     * @param {Connection} conn - The database connection.
     */
    public DisplayFunctions(Connection conn) {
        this.conn = conn;
    }

    /**
     * Displays the average review score for a given product ID.
     * @param {number} productId - The ID of the product.
     * @throws {SQLException} - If an SQL error occurs.
     */
    public void displayAverageReviewScore(int productId) {
        try (CallableStatement callableStatement = conn.prepareCall("{ ? = call utility_package.calculate_average_review_score(?) }")) {
            callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);
            callableStatement.setInt(2, productId);
            callableStatement.execute();
            double averageScore = callableStatement.getDouble(1);
            if (averageScore != 0) {
                System.out.println("Average Review Score for Product ID " + productId + ": " + averageScore);
            } else {
                System.out.println("No reviews available for Product ID " + productId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    /**
     * Displays flagged reviews from the database.
     * @param {Connection} connection - The database connection.
     * @throws {SQLException} - If an SQL error occurs.
     */
    public void displayFlaggedReviews(Connection connection) throws SQLException {
        try (CallableStatement statement = connection.prepareCall("{ ? = call utility_package.GetFlaggedReviews }")) {
            // Register the output parameter as a cursor
            statement.registerOutParameter(1, OracleTypes.CURSOR);

            // Execute the function
            statement.execute();

            // Retrieve the result set
            try (ResultSet resultSet = (ResultSet) statement.getObject(1)) {
                while (resultSet.next()) {
                    int reviewId = resultSet.getInt("review_id");
                    int customerId = resultSet.getInt("customer_id");
                    int flag = resultSet.getInt("flag");
                    String description = resultSet.getString("description");
                    String productName = resultSet.getString("product_name");

                    // Process the result here
                    System.out.println("Review ID: " + reviewId);
                    System.out.println("Customer ID: " + customerId);
                    System.out.println("Flag: " + flag);
                    System.out.println("Review Description: " + description);
                    System.out.println("Product Name: " + productName);
                    System.out.println("------------------------------------");
                }
            }
        }
    }

    /**
     * Displays audit logs for a specified table in the database.
     * @param {Connection} conn - The database connection.
     * @param {string} tableName - The name of the table for which to display audit logs.
     */
    public static void displayAuditLogs(Connection conn, String tableName) {
    try (Statement stmt = conn.createStatement()) {
        String sql = "SELECT * FROM " + tableName + "_Audit_Log";
        try (ResultSet rs = stmt.executeQuery(sql)) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            System.out.println("Columns in the result set:");
            for (int i = 1; i <= columnCount; i++) {
                System.out.println("Column " + i + ": " + metaData.getColumnName(i));
            }
            System.out.println("----------------------------");

            System.out.println("Audit Logs for " + tableName + " Audits:");
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnName(i);
                    System.out.println(columnName + ": " + rs.getString(columnName));
                }
                System.out.println("------------------------------");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Error retrieving audit logs from the database for " + tableName + " Audits");
    }
}

    
}
