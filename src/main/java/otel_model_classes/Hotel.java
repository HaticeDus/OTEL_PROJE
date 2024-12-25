/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Monster
 */
public class Hotel {

    private static final String GET_ALL_HOTELS = "SELECT * FROM hotel";

    public List<Map<String, Object>> getAllHotels() {
        List<Map<String, Object>> hotels = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_HOTELS); ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Map<String, Object> hotel = new HashMap<>();
                hotel.put("hotelID", resultSet.getInt("hotelID"));
                hotel.put("hotel_name", resultSet.getString("hotel_name"));
                hotel.put("hotel_adress", resultSet.getString("hotel_adress"));
                hotel.put("hotel_description", resultSet.getString("hotel_description"));
                hotel.put("City_cityID", resultSet.getString("City_cityID"));
                hotel.put("hotel_image", resultSet.getString("hotel_image"));

                hotels.add(hotel);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return hotels;
    }

}
