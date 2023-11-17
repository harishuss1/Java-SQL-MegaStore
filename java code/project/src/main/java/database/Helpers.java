package database;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Helpers {
    private static Scanner scanner = new Scanner(System.in);

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

    public static String getUserInputString(String prompt) {
        System.out.print(prompt);
        return scanner.next();
    }

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
