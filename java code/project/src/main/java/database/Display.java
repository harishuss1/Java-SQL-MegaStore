package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.InputMismatchException;
import java.util.Scanner;

import oracle.jdbc.OracleTypes;

//All the stuff related to Displaying information is here
public class Display {
    private static Scanner scanner = new Scanner(System.in);
    private static Connection connection;




     public static void main(String[] args) throws SQLException, ClassNotFoundException {
        // Assume the program starts here
        System.out.print("\033[H\033[2J");
        System.out.flush();
        Greet();
        displayLoginMenu();
    }
    
    public static void Greet(){
        System.out.println("   ________________");
        System.out.println("  /\\              /\\");
        System.out.println(" /  \\____________/  \\");
        System.out.println("/____________________\\");
        System.out.println("|                    |");
        System.out.println("|        SHOP        |");
        System.out.println("\\                    /");
        System.out.println(" \\__________________/");
        System.out.println("");
       
    }

    

    public static void displayLoginMenu() throws SQLException, ClassNotFoundException {
        System.out.println("Welcome to the Application!");
        System.out.println("1. Log In");
        System.out.println("2. Exit");

        int choice = getUserChoice();
        scanner.nextLine();
        switch (choice) {
            case 1:
                // Call the method for user login
                // For example: loginUser();
                connection = Service.getConnection();
                displayMainMenu();
                break;
            case 2:
                System.out.println("Exiting the application. Goodbye!");
                break;
            default:
                System.out.println("Invalid choice. Please try again.");
                displayLoginMenu();
        }
    }

    public static void displayMainMenu() throws SQLException, ClassNotFoundException {
        System.out.println("\nMain Menu:");
        System.out.println("1. Add");
        System.out.println("2. Remove");
        System.out.println("3. Update");
        System.out.println("4. View Functions");
        System.out.println("5. Logout");

        int choice = getUserChoice();

        switch (choice) {
            case 1:
                // Call the method for adding data
                addData();
                displayMainMenu();
                break;
            case 2:
                removeData();
                displayMainMenu();
                break;
            case 3:
                // Call the method for updating data
                // For example: updateData();
                displayMainMenu();
                break;
            case 4:
                viewFunctions();
                displayMainMenu();
                break;
            case 5:
                System.out.println("Logging out. Goodbye!");
                System.exit(1);
                break;
            default:
                System.out.println("Invalid choice. Please try again.");
                displayMainMenu();
        }
    }

    public static int getUserChoice() {
        int choice = 0;
        boolean isValidInput = false;

        while (!isValidInput) {
            try {
                System.out.print("Enter your choice: ");
                choice = scanner.nextInt();
                isValidInput = true;
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a number.");
                scanner.next();
            }
        }

        return choice;
    }


    public static void addData() throws SQLException, ClassNotFoundException {
        System.out.println("\nAdd Data Menu:");
        System.out.println("1. Add Product");
        System.out.println("2. Add Customer");
        System.out.println("3. Add Project Order");
        System.out.println("4. Add Review");
        System.out.println("5. Add Project Address");
        System.out.println("6. Add Warehouse");
        System.out.println("7. Add Warehouse Product");
        System.out.println("8. Back to Main Menu");

        int choice = getUserChoice();

        switch (choice) {
            case 1:
                Product productToAdd = Product.collectProductInformation();
                productToAdd.AddToDatabase(connection);
                break;
            case 2:
                // Call the method to add a customer
                // For example: addCustomer();
                break;
            case 3:
                // Call the method to add a project order
                // For example: addProjectOrder();
                break;
            case 4:
                // Call the method to add a review
                // For example: addReview();
                break;
            case 5:
                // Call the method to add a project address
                // For example: addProjectAddress();
                break;
            case 6:
                // Call the method to add a warehouse
                // For example: addWarehouse();
                break;
            case 7:
                // Call the method to add a warehouse product
                // For example: addWarehouseProduct();
                break;
            case 8:
                displayMainMenu();
                break;
            default:
                System.out.println("Invalid choice. Please try again.");
                addData();
        }
    }

    public static void removeData() {
        System.out.println("\nRemove Data Menu:");
        System.out.println("1. Remove Product");
        System.out.println("2. Remove Warehouse");
        int choice = getUserChoice();
        scanner.nextLine();
        switch(choice) {
            case 1:
                System.out.println("Enter the ID of the product to remove. (Please refer to the list of products on top)");

                int productId = getUserChoice();
                DeleteData deleteData = new DeleteData(connection);
                deleteData.deleteProduct(productId);
                break;
            case 2:
                System.out.println("Enter the Warehouse Name to delete: ");
                String warehouseName = scanner.nextLine();
                DeleteData deleteData2 = new DeleteData(connection);
                deleteData2.deleteWarehouse(warehouseName);
                Stocks.getTotalStockForAllProducts(connection);
                break;
            case 3:
                System.out.println("Enter which Review to delete: "); 
                int reviewId = getUserChoice();
                DeleteData deleteData3 = new DeleteData(connection);
                deleteData3.deleteReviews(reviewId);
                break;

        }
    }

    public static void viewFunctions() throws SQLException, ClassNotFoundException{
        System.out.println("\nView Function Menu:");
        System.out.println("1. Show Average Rating Score For A Product");
        System.out.println("2. Show Total inventory For A Product");
        System.out.println("3. Show Flagged Customers");
        System.out.println("4. Show Audit Logs");
        System.out.println("5. Back to Main Menu");

             int choice = getUserChoice();
             scanner.nextLine();
        switch (choice) {
            case 1:
                System.out.println("Enter a Product's id You'd like to see the reviews for: ");
                int productid = scanner.nextInt();
                DisplayFunctions displayFunctions = new DisplayFunctions(connection);
                displayFunctions.displayAverageReviewScore(productid); 
                break;
            case 2:
                Stocks.getTotalStockForAllProducts(connection);
                while(true) {
                    System.out.println("Do you want to display specific products of a category? YES/NO");
                    String answer = scanner.nextLine();
                
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
                        String category_choice = scanner.nextLine();
                        DisplayProducts.displayProductsByCategory(connection, category_choice);
                    }
                    else if(answer.equals("NO")) {
                        displayMainMenu();
                        break;
                    }
                    else {
                        System.out.println("Invalid choice. Please enter YES or NO.");
                    }
                }
                break;
            case 3:
                DisplayFunctions displayFunctions3 = new DisplayFunctions(connection);
                displayFunctions3.displayFlaggedReviews(connection);
                break;
            case 4:
                viewLogs();
                break;
            case 5:

                break;
                default:
                System.out.println("Invalid choice. Please try again.");
                viewFunctions();
        }
    }

    public static void viewLogs() throws SQLException, ClassNotFoundException{
        System.out.println("\nView Function Menu:");
        System.out.println("1. View Product Audit Log");
        System.out.println("2. View Address Audit Log");
        System.out.println("3. View City Audit Log");
        System.out.println("4. View Stores Audit Log");
        System.out.println("5. View WareHouse Products Audit Log");
        System.out.println("6. View Customers Audit Log");
        System.out.println("7. View Orders Audit Log");
        System.out.println("8. View Reviews Audit Log");
        System.out.println("9. Back to Main Menu");


        int choice = getUserChoice();
             scanner.nextLine();
        switch (choice){
            case 1:
            DisplayFunctions.displayAuditLogs(connection, "Products");
                break;
            case 2:
            DisplayFunctions.displayAuditLogs(connection, "Project_Address");
                break;
            case 3:
            DisplayFunctions.displayAuditLogs(connection, "Project_City");
                break;
            case 4:
            DisplayFunctions.displayAuditLogs(connection, "Stores");
                break;
            case 5:
            DisplayFunctions.displayAuditLogs(connection, "Warehouse_Products");
                break;
            case 6:
            DisplayFunctions.displayAuditLogs(connection, "Project_Customers");
                break;
            case 7:
            DisplayFunctions.displayAuditLogs(connection, "Project_Orders");
                break;
            case 8:
            DisplayFunctions.displayAuditLogs(connection, "Reviews");
                break;
            case 9:
                    displayMainMenu();
                break;
                default:
                System.out.println("Invalid choice. Please try again.");
                viewLogs();
        
        }
    }
    
}

