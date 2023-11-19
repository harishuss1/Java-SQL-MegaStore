package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DisplayFunctions {

    private Connection conn;

    public DisplayFunctions(Connection conn) {
        this.conn = conn;
    }

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

    public void displayFlaggedReviews() {
        try (CallableStatement callableStatement = conn.prepareCall("{ call utility_package.CheckFlaggedReviews }");
             ResultSet resultSet = callableStatement.executeQuery()) {

            while (resultSet.next()) {
                int reviewId = resultSet.getInt("review_id");
                String description = resultSet.getString("description");
                String productName = resultSet.getString("product_name");
                int flag = resultSet.getInt("flag");

                System.out.println("Review ID: " + reviewId);
                System.out.println("Flag: " + flag);
                System.out.println("Review Description: " + description);
                System.out.println("Product Name: " + productName);
                System.out.println("------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }
}
