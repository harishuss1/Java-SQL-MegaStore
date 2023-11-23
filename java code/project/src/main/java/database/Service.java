package database;

import java.sql.*;
import java.util.Scanner;
import java.io.Console;

/**
 * The Service class provides methods for establishing and closing connections to a database.
 * @class
 */
public class Service {

    private Connection conn;
    static Scanner scan = new Scanner(System.in);

    public Service() {
    }

    /**
     * Creates an instance of the Service class and establishes a database connection using the provided username and password.
     * @constructor
     * @param {string} username - The username for the database connection.
     * @param {string} password - The password for the database connection.
     * @throws {SQLException}
     */
    public Service(String username, String password) throws SQLException {

        String url = "jdbc:oracle:thin:@198.168.52.211: 1521/pdbora19c.dawsoncollege.qc.ca";

        try {
            this.conn = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to database");
        } catch (SQLException e) {
            System.out.println("Invalid username or password. Please try again.");
        }

    }

     /**
     * Retrieves a database connection based on user input for the username and password.
     * @static
     * @function
     * @returns {Connection} The database connection.
     * @throws {SQLException}
     */
    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        boolean validCredentials = false;

        while(!validCredentials){
        Scanner scan = new Scanner(System.in);
        Console console = System.console();
        System.out.println("Enter username: ");
        String username = scan.next();
        System.out.println("Enter password");
        char[] passwordChars = console.readPassword();
        String password = new String(passwordChars);
    
        String url = "jdbc:oracle:thin:@198.168.52.211: 1521/pdbora19c.dawsoncollege.qc.ca";
        try{
        conn = DriverManager.getConnection(url, username, password);
        System.out.println("Connected to database");
        validCredentials =true;
        }catch(SQLException e){
            System.out.println("Invalid username or password. Please try again.");

        }
    }
        return conn;
    }

    /**
     * Closes the database connection.
     * @function
     * @throws {SQLException}
     */
    public void Close() throws SQLException {
        if (!this.conn.isClosed() && this.conn != null) {
            this.conn.close();
            System.out.println("Disconnected to database");
        }
    }
}
