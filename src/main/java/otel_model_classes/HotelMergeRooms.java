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
public class HotelMergeRooms {

    // otel_page KULLANDIM
    //TÜM hotel_rooms LİSTESİNİ GETİREN METHOD
    //istenilen otelin "oda türüne göre 1" adet odaları geliyor
    public List<Map<String, Object>> getAllHotelRoomsByHotelID(int hotelID) {
        List<Map<String, Object>> hotelRoomsList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM hotel_rooms AS hr1 WHERE (Room_Type_room_typeID, hotel_roomsID) IN ("
                    + "SELECT Room_Type_room_typeID, MIN(hotel_roomsID) "
                    + "FROM hotel_rooms AS hr2 "
                    + "WHERE hr1.Room_Type_room_typeID = hr2.Room_Type_room_typeID "
                    + "AND hr1.Hotel_hotelID = hr2.Hotel_hotelID "
                    + "AND hr1.Hotel_hotelID = ? "
                    + "GROUP BY Room_Type_room_typeID)";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, hotelID);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> hotelRoomData = new HashMap<>();
                hotelRoomData.put("hotel_roomsID", resultSet.getInt("hotel_roomsID"));
                hotelRoomData.put("Hotel_hotelID", resultSet.getInt("Hotel_hotelID"));
                hotelRoomData.put("Room_Type_room_typeID", resultSet.getInt("Room_Type_room_typeID"));
                hotelRoomData.put("hotel_room_name", resultSet.getString("hotel_room_name"));
                hotelRoomData.put("hotel_room_number", resultSet.getInt("hotel_room_number"));
                hotelRoomData.put("hotel_rooms_img_url", resultSet.getString("hotel_rooms_img_url"));
                hotelRoomData.put("room_price", resultSet.getBigDecimal("room_price"));
                hotelRoomData.put("max_person_capacity", resultSet.getInt("max_person_capacity"));
                hotelRoomData.put("room_description", resultSet.getString("room_description"));
                hotelRoomData.put("availability_start_date", resultSet.getDate("availability_start_date"));
                hotelRoomData.put("availability_end_date", resultSet.getDate("availability_end_date"));

                hotelRoomsList.add(hotelRoomData);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return hotelRoomsList;
    }

    //SON DEĞİŞİKLİKTEN SONRA BU METHODA GEREK YOK FAKAT KULLANIYORUM!!// otel_page'de KULLANDIM
    //TÜM LİSTEYİ ALIP ve SEÇİLEN OTEL ID'Sine göre oda listesini döndüren method
    public List<Map<String, Object>> getRoomsByHotelID(List<Map<String, Object>> hotelRoomsList, int selectedhotelID) {
        List<Map<String, Object>> selectedHotelRooms = new ArrayList<>();

        for (Map<String, Object> hotelRoom : hotelRoomsList) {
            int hotelIdFromList = (int) hotelRoom.get("Hotel_hotelID"); // hotelID'nin türüne göre dönüşüm yapabilirsiniz

            if (hotelIdFromList == selectedhotelID) {
                selectedHotelRooms.add(hotelRoom);
            }
        }

        return selectedHotelRooms;
    }

}
