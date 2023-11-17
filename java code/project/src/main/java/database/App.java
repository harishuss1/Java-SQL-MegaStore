package database;

import java.sql.Connection;
import java.sql.SQLException;

public class App {
    public static void main(String[] args) {

        try {
            // Step 1: Create a Service instance to establish a connection
            Connection connection = Service.getConnection();

            // Step 2: Create a DeleteData instance and pass the connection
            DeleteData deleteData = new DeleteData(connection);

            // Step 3: Use DeleteData methods to interact with stored procedures
            deleteData.deleteProduct(1);
            deleteData.deleteReviews(1);
            // Add more delete operations as needed...

            // Step 4: Close the database connection
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
