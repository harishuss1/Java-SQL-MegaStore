package database;

import java.util.InputMismatchException;
import java.util.Scanner;

/**
 * The Helpers class provides utility methods for user input.
 * @class
 */
public class Helpers {
    private static Scanner scanner = new Scanner(System.in);

    /**
     * Retrieves a valid integer input from the user.
     * @param {string} prompt - The message to prompt the user.
     * @returns {number} - The user-entered integer.
     */
    public static int getUserInputInt(String prompt) {
        int userInput = 0;
        boolean isValidInput = false;

        while (!isValidInput) {
            try {
                System.out.print(prompt);
                userInput = scanner.nextInt();
                isValidInput = true;
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a valid integer.");
                scanner.next(); // Clear the invalid input from the buffer
            }
        }

        return userInput;
    }

    /**
     * Retrieves a valid double input from the user.
     * @param {string} prompt - The message to prompt the user.
     * @returns {number} - The user-entered double.
     */
    public static double getUserInputDouble(String prompt) {
        double userInput = 0;
        boolean isValidInput = false;

        while (!isValidInput) {
            try {
                System.out.print(prompt);
                userInput = scanner.nextDouble();
                isValidInput = true;
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a valid double.");
                scanner.next(); // Clear the invalid input from the buffer
            }
        }

        return userInput;
    }

    /**
     * Retrieves a valid string input from the user.
     * @param {string} prompt - The message to prompt the user.
     * @returns {string} - The user-entered string.
     */
    public static String getUserInputString(String prompt) {
        System.out.print(prompt);
        return scanner.next();
    }

    /**
     * Retrieves a positive integer input from the user.
     * @param {string} prompt - The message to prompt the user.
     * @returns {number} - The user-entered positive integer.
     */
    public static int getPositiveIntInput(String prompt) {
        int userInput = 0;
        boolean isValidInput = false;

        while (!isValidInput) {
            try {
                System.out.print(prompt);
                userInput = scanner.nextInt();

                if (userInput > 0) {
                    isValidInput = true;
                } else {
                    System.out.println("Please enter a positive integer.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a positive integer.");
                scanner.next(); // Clear the invalid input from the buffer
            }
        }

        return userInput;
    }

}
