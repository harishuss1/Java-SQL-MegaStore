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

            ResultSet resultSet = Stocks.getTotalStockForAllProducts(connection);
  
            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                int totalStock = resultSet.getInt("total_stock");

                System.out.println("Product ID: " + productId + ", Total Stock: " + totalStock);
            }

           
            connection.close();
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


