package database;

import java.sql.*;
import java.util.Scanner;
import java.io.Console;


public class Service {

    private Connection conn;
    static Scanner scan = new Scanner(System.in);

    public Service() {
    }

    public Service(String username, String password) throws SQLException {

        String url = "jdbc:oracle:thin:@198.168.52.211: 1521/pdbora19c.dawsoncollege.qc.ca";

        try {
            this.conn = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to database");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static Connection getConnection() throws SQLException {
        Connection conn = null;

        Scanner scan = new Scanner(System.in);
        Console console = System.console();
        System.out.println("Enter username: ");
        String username = scan.next();
        System.out.println("Enter password");
        char[] passwordChars = console.readPassword();
        String password = new String(passwordChars);
        

        String url = "jdbc:oracle:thin:@198.168.52.211: 1521/pdbora19c.dawsoncollege.qc.ca";
        conn = DriverManager.getConnection(url, username, password);
        System.out.println("Connected to database");
        return conn;
    }

    public void Close() throws SQLException {
        if (!this.conn.isClosed() && this.conn != null) {
            this.conn.close();
            System.out.println("Disconnected to database");
        }
    }
}
