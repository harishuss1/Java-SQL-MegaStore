package database;
import java.sql.*;

import oracle.jdbc.OracleTypes;

public class DisplayProducts {

    public static void displayProductsByCategory(Connection connection, String category) {
        try (CallableStatement statement = connection.prepareCall("{ call ProductStockPackage.DisplayProductPerCategory(?, ?) }")) {
            // Register the OUT parameter for the result set
            statement.setString(1, category);
            statement.registerOutParameter(2, OracleTypes.CURSOR);

            // Execute the stored procedure
            statement.execute();

            // Retrieve the result set
            ResultSet resultSet = (ResultSet) statement.getObject(2);

            // Process the result set
            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                String productName = resultSet.getString("product_name");
                double productPrice = resultSet.getDouble("product_price");

                System.out.println("Product ID: " + productId + ", Product Name: " + productName + ", Product Price: " + productPrice);
            }

        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
