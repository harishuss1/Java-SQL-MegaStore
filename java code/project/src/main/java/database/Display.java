package database;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.InputMismatchException;
import java.util.Scanner;

//All the stuff related to Displaying information is here
public class Display {
    private static Scanner scanner = new Scanner(System.in);
    private static Connection connection;

    public static void main(String[] args) throws SQLException {
        // Assume the program starts here
        System.out.print("\033[H\033[2J");
        System.out.flush();
        Greet();
        displayLoginMenu();
    }

    public static void Greet() {
        System.out.println("⠀⠈⠛⠻⠶⣶⡄   SHOPPING...");
        System.out.println(" ⠀⠀⠀⠀⠀⠈⢻⣆⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⢻⡏⠉⠉⠉⠉⢹⡏⠉⠉⠉⠉⣿⠉⠉⠉⠉⠉⣹⠇");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠈⣿⣀⣀⣀⣀⣸⣧⣀⣀⣀⣀⣿⣄⣀⣀⣀⣠⡿");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠁⠀⠀⠀⣿⠃");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⣤⣤⣼⣧⣤⣤⣤⣤⣿⣤⣤⣤⣼⡏");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠀⢠⡿");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣷⠤⠼⠷⠤⠤⠤⠤⠿⠦⠤⠾⠃");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠁");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣷⢶⣶⠶⠶⠶⠶⠶⠶⣶⠶⣶⡶");
        System.out.println("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⣠⡿⠀⠀⠀⠀⠀⠀⢷⣄⣼⠇");
    }

    public static void displayLoginMenu() throws SQLException {
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
                Stocks.getTotalStockForAllProducts(connection);
                while (true) {
                    System.out.println("Do you want to display specific products of a category? YES/NO");
                    String answer = scanner.nextLine();

                    if (answer.equals("YES")) {
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
                    } else if (answer.equals("NO")) {
                        displayMainMenu();
                        break;
                    } else {
                        System.out.println("Invalid choice. Please enter YES or NO.");
                    }
                }

                break;
            case 2:
                System.out.println("Exiting the application. Goodbye!");
                break;
            default:
                System.out.println("Invalid choice. Please try again.");
                displayLoginMenu();
        }
    }

    public static void displayMainMenu() {
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
                // Call the method for viewing reports
                // For example: viewReports();
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

    public static void addData() {
        System.out.println("\nAdd Data Menu:");
        System.out.println("1. Add Product");
        System.out.println("2. Add Customer");
        System.out.println("3. Add Project Order");
        System.out.println("4. Add Review");
        System.out.println("5. Add Project Address");
        System.out.println("6. Add Warehouse");
        System.out.println("7. Add Warehouse Product");
        System.out.println("8. Add Order Audit Log");
        System.out.println("9. Add Login Audit Log");
        System.out.println("10. Add Stock Update Audit Log");
        System.out.println("11. Back to Main Menu");

        int choice = getUserChoice();

        switch (choice) {
            case 1:
                // Call the method to add a product
                // For example: addProduct();
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
                // Call the method to add an order audit log
                // For example: addOrderAuditLog();
                break;
            case 9:
                // Call the method to add a login audit log
                // For example: addLoginAuditLog();
                break;
            case 10:
                // Call the method to add a stock update audit log
                // For example: addStockUpdateAuditLog();
                break;
            case 11:
                // Go back to the main menu
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
        System.out.println("2. Remove Customer");
        System.out.println("3. Remove Warehouse");
        int choice = getUserChoice();
        scanner.nextLine();
        switch (choice) {
            case 1:
                System.out.println(
                        "Enter the ID of the product to remove. (Please refer to the list of products on top)");

                int productId = getUserChoice();
                DeleteData deleteData = new DeleteData(connection);
                deleteData.deleteProduct(productId);
                break;
            case 2:
                // call deleteData.deleteCustomer
                break;
            case 3:
                System.out.println("Enter the Warehouse Name to delete: ");
                String warehouseName = scanner.nextLine();
                DeleteData deleteData3 = new DeleteData(connection);
                deleteData3.deleteWarehouse(warehouseName);
                Stocks.getTotalStockForAllProducts(connection);
                break;

        }
    }
}
