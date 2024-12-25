/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Monster
 */
public class Reservation {

    public boolean addReservation(int customerID, int hotelID, String checkInDate, String checkOutDate, int adultCount, int childCount, double totalPrice, int roomID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean isSuccess = false;

        try {
            conn = DatabaseConnection.getConnection();
            String insertQuery = "INSERT INTO reservation (Customer_customerID, Hotel_hotelID, check_in_date, check_out_date, adult_count, child_count, total_price, hotel_roomsID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertQuery);

            stmt.setInt(1, customerID);
            stmt.setInt(2, hotelID);
            stmt.setString(3, checkInDate);
            stmt.setString(4, checkOutDate);
            stmt.setInt(5, adultCount);
            stmt.setInt(6, childCount);
            stmt.setDouble(7, totalPrice);
            stmt.setInt(8, roomID);

            int rowsAffected = stmt.executeUpdate();

            // Veri eklendi mi kontrol edin
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isSuccess;
    }
}
