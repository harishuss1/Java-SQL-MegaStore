package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
public class App {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        try {
            Display.displayLoginMenu();
            
            
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
   