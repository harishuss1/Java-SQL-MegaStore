package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
public class App {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        try {
            Connection connection = Service.getConnection();

            Stocks.getTotalStockForAllProducts(connection);
            System.out.println("Do you want to display specific products of a category? YES/NO");
            String answer = scan.nextLine();
            
            if(answer.equals("YES")) {
                System.out.println("Which category from this list? \n" +
                "Grocery\n" +
                "DVD\n" +
                "Cars\n" +
                "Toys\n" +
                "Electronics\n" +
                "Health\n" +
                "Beauty\n" +
                "Video Games\n" +
                "Vehicle\n" +
                "------------------------");
                String category_choice = scan.nextLine();
                DisplayProducts.displayProductsByCategory(connection, category_choice);
            }
            
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
   