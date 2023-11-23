package database;

import java.sql.*;

public class UpdateData {

    public static Object updateData;
    private Connection conn;

    public UpdateData(Connection conn) {
        this.conn = conn;
    }

    public void updateProduct(int productId, String productName, String productCategory) {
        try (CallableStatement callableStatement = conn.prepareCall("{call update_data.update_product(?, ?, ?)}")) {
            callableStatement.setInt(1, productId);
            callableStatement.setString(2, productName);
            callableStatement.setString(3, productCategory);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    public void updateWarehouse(int warehouseId, String warehouseName, int addressId, int cityId) {
        try (CallableStatement callableStatement = conn
                .prepareCall("{call update_data.update_warehouse(?, ?, ?, ?)}")) {
            callableStatement.setInt(1, warehouseId);
            callableStatement.setString(2, warehouseName);
            callableStatement.setInt(3, addressId);
            callableStatement.setInt(4, cityId);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    public void updateWarehouseProducts(int warehouseId, int productId, int quantity) {
        try (CallableStatement callableStatement = conn
                .prepareCall("{call update_data.update_warehouse_products(?, ?, ?)}")) {
            callableStatement.setInt(1, warehouseId);
            callableStatement.setInt(2, productId);
            callableStatement.setInt(3, quantity);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

    public void updateReviews(int reviewId) {
        try (CallableStatement callableStatement = conn
                .prepareCall("{call update_data.update_reviews(?)}")) {
            callableStatement.setInt(1, reviewId);
            callableStatement.execute();
            System.out.println("Procedure executed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing stored procedure.");
        }
    }

}
