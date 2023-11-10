package database;

import java.sql.*;
import java.util.Scanner;

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
        System.out.println("Enter username: ");
        String username = scan.next();
        System.out.println("Enter password: ");
        String password = scan.next();
        scan.close();

        String url = "jdbc:oracle:thin:@198.168.52.211: 1521/pdbora19c.dawsoncollege.qc.ca";
        conn = DriverManager.getConnection(url, username, password);
        System.out.println("Connected to database");
        return conn;
    }

    public void Close() throws SQLException {
        if (!this.conn.isClosed()) {
            this.conn.close();
            System.out.println("Disconnected to database");
        }
    }
}
