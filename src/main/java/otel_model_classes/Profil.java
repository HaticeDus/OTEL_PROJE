/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Monster
 */
public class Profil {

    private static final String UPDATE_CUSTOMER = "UPDATE customer SET customer_name_surname = ?, customer_email = ?, customer_tel = ?, customer_adress = ?, gender = ?, date_of_birth = ? WHERE customerID = ?";
    private static final String GET_RESERVATIONS_BY_CUSTOMER_ID = "SELECT * FROM reservation WHERE Customer_customerID = ?";

    //UPDATE METHODU
    public boolean updateCustomer(int customerId, String newNameSurname, String newEmail, String newTel, String newAddress, String newGender, String newDateOfBirth) {
        boolean rowUpdated = false;
        try (Connection connection = DatabaseConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CUSTOMER)) {

            preparedStatement.setString(1, newNameSurname);
            preparedStatement.setString(2, newEmail);
            preparedStatement.setString(3, newTel);
            preparedStatement.setString(4, newAddress);
            preparedStatement.setString(5, newGender);
            preparedStatement.setString(6, newDateOfBirth);
            preparedStatement.setInt(7, customerId);

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    //customerId ile REZERVASYON LİSTESİ GELSİN
    public List<Map<String, Object>> getReservationsByCustomerId(int customerId) {
        List<Map<String, Object>> reservations = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(GET_RESERVATIONS_BY_CUSTOMER_ID)) {

            preparedStatement.setInt(1, customerId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Map<String, Object> reservationData = new HashMap<>();

                    // reservationData.put("reservationID", resultSet.getInt("reservationID"));
                    //  reservationData.put("Customer_customerID", resultSet.getInt("Customer_customerID"));
                    reservationData.put("Hotel_hotelID", resultSet.getInt("Hotel_hotelID"));
                    reservationData.put("check_in_date", resultSet.getDate("check_in_date"));
                    reservationData.put("check_out_date", resultSet.getDate("check_out_date"));
                    reservationData.put("adult_count", resultSet.getInt("adult_count"));
                    reservationData.put("child_count", resultSet.getInt("child_count"));
                    //    reservationData.put("hotel_rewiev", resultSet.getString("hotel_rewiev"));
                    // reservationData.put("hotel_rating", resultSet.getInt("hotel_rating"));
                    reservationData.put("total_price", resultSet.getDouble("total_price"));
                    // reservationData.put("hotel_roomsID", resultSet.getInt("hotel_roomsID"));
                    reservationData.put("reservation_date", resultSet.getTimestamp("reservation_date"));
                    reservations.add(reservationData);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reservations;
    }
}
