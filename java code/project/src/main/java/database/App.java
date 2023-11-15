package database;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;
public class App {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        Display display  = new Display(connection);
        display.Greet();
        try {
            Connection connection = Service.getConnection();
            display.DisplayOptions();
            String user_choice = scan.nextLine();
    
            if(user_choice.equals("YES")) {
                  displayData.displayAllProducts();

                /* call display method */
            }

            DeleteData deleteData = new DeleteData(connection);

            // deleteData.deleteProduct(1);
            // deleteData.deleteReviews(1);
            

            // Step 4: Close the database connection
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
