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
//OTEL_FILTRE.jsp İÇİN YAZDIM
public class AllHotelsAndAllRooms {

    public List<Map<String, Object>> getHotelRoomsData() {
        List<Map<String, Object>> resultList = new ArrayList<>();
        String query = "SELECT "
                + "hr.hotel_roomsID, hr.Hotel_hotelID, h.hotel_name, h.City_cityID, "
                + "hr.Room_Type_room_typeID, hr.hotel_room_name, hr.hotel_room_number, "
                + "hr.hotel_rooms_img_url, hr.room_price, hr.max_person_capacity, "
                + "hr.availability_start_date, hr.availability_end_date "
                + "FROM hotel_rooms hr "
                + "INNER JOIN hotel h ON hr.Hotel_hotelID = h.hotelID";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> resultMap = new HashMap<>();
                resultMap.put("hotel_roomsID", rs.getInt("hotel_roomsID"));
                resultMap.put("Hotel_hotelID", rs.getInt("Hotel_hotelID"));
                resultMap.put("hotel_name", rs.getString("hotel_name"));
                resultMap.put("City_cityID", rs.getInt("City_cityID"));
                resultMap.put("Room_Type_room_typeID", rs.getInt("Room_Type_room_typeID"));
                resultMap.put("hotel_room_name", rs.getString("hotel_room_name"));
                resultMap.put("hotel_room_number", rs.getInt("hotel_room_number"));
                resultMap.put("hotel_rooms_img_url", rs.getString("hotel_rooms_img_url"));
                resultMap.put("room_price", rs.getDouble("room_price"));
                resultMap.put("max_person_capacity", rs.getInt("max_person_capacity"));
                resultMap.put("availability_start_date", rs.getDate("availability_start_date"));
                resultMap.put("availability_end_date", rs.getDate("availability_end_date"));

                resultList.add(resultMap);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultList;
    }

    //KULLANICI BİLGİLERİNE GÖRE OTELLER VE ODALARI GETİRİYOR
    public List<Map<String, Object>> getFilteredRooms(int roomNumber, String selectedCity, String checkInDate, String checkOutDate) {
        List<Map<String, Object>> resultList = new ArrayList<>();

        String query = "SELECT "
                + "hr.hotel_roomsID, hr.Hotel_hotelID, h.hotel_name, h.City_cityID, "
                + "h.hotel_image, "
                + "hr.Room_Type_room_typeID, hr.hotel_room_name, hr.hotel_room_number, hr.room_description, "
                + "hr.hotel_rooms_img_url, hr.room_price, hr.max_person_capacity, "
                + "hr.availability_start_date, hr.availability_end_date "
                + "FROM hotel_rooms hr "
                + "INNER JOIN hotel h ON hr.Hotel_hotelID = h.hotelID "
                + "WHERE h.City_cityID = ? "
                + "AND hr.availability_start_date <= ? "
                + "AND hr.availability_end_date >= ? "
                + "AND (hr.Hotel_hotelID, hr.Room_Type_room_typeID) IN ("
                + "    SELECT Hotel_hotelID, Room_Type_room_typeID "
                + "    FROM hotel_rooms "
                + "    WHERE availability_start_date <= ? "
                + "    AND availability_end_date >= ? "
                + "    GROUP BY Hotel_hotelID, Room_Type_room_typeID "
                + "    HAVING COUNT(*) >= ?"
                + ")";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, selectedCity);
            preparedStatement.setString(2, checkInDate);
            preparedStatement.setString(3, checkOutDate);
            preparedStatement.setString(4, checkInDate);
            preparedStatement.setString(5, checkOutDate);
            preparedStatement.setInt(6, roomNumber);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> resultMap = new HashMap<>();
                    resultMap.put("hotel_roomsID", rs.getInt("hotel_roomsID"));
                    resultMap.put("Hotel_hotelID", rs.getInt("Hotel_hotelID"));
                    resultMap.put("hotel_name", rs.getString("hotel_name"));
                    resultMap.put("City_cityID", rs.getInt("City_cityID"));
                    resultMap.put("hotel_image", rs.getString("hotel_image"));
                    resultMap.put("Room_Type_room_typeID", rs.getInt("Room_Type_room_typeID"));
                    resultMap.put("hotel_room_name", rs.getString("hotel_room_name"));
                    resultMap.put("hotel_room_number", rs.getInt("hotel_room_number"));
                    resultMap.put("room_description", rs.getString("room_description"));
                    resultMap.put("hotel_rooms_img_url", rs.getString("hotel_rooms_img_url"));
                    resultMap.put("room_price", rs.getDouble("room_price"));
                    resultMap.put("max_person_capacity", rs.getInt("max_person_capacity"));
                    resultMap.put("availability_start_date", rs.getDate("availability_start_date"));
                    resultMap.put("availability_end_date", rs.getDate("availability_end_date"));
                    resultList.add(resultMap);
                }
            }
        } catch (SQLException e) {

        }
        return resultList;
    }

    // BURADA  bir oteldeki aynı tür oda sayısına göre   all_hotel_roomsIDs veriyor  otel odalarının ıd leri geliyor
    public List<Map<String, Object>> getRoomsByAvailabilityAndCount(int cityID, String startDate, String endDate, int minRoomCount) {
        List<Map<String, Object>> resultList = new ArrayList<>();

        String query = "SELECT "
                + "hr.Room_Type_room_typeID, hr.Hotel_hotelID, GROUP_CONCAT(hr.hotel_roomsID) AS all_hotel_roomsIDs, COUNT(*) AS room_count "
                + "FROM hotel_rooms hr "
                + "JOIN hotel h ON hr.Hotel_hotelID = h.hotelID "
                + "WHERE h.City_cityID = ? "
                + "AND hr.availability_start_date <= ? "
                + "AND hr.availability_end_date >= ? "
                + "GROUP BY hr.Room_Type_room_typeID, hr.Hotel_hotelID "
                + "HAVING COUNT(*) >= ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, cityID);
            preparedStatement.setString(2, startDate);
            preparedStatement.setString(3, endDate);
            preparedStatement.setInt(4, minRoomCount);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> resultMap = new HashMap<>();
                    resultMap.put("Room_Type_room_typeID", rs.getInt("Room_Type_room_typeID"));
                    resultMap.put("Hotel_hotelID", rs.getInt("Hotel_hotelID"));
                    resultMap.put("all_hotel_roomsIDs", rs.getString("all_hotel_roomsIDs"));
                    resultMap.put("room_count", rs.getInt("room_count"));
                    resultList.add(resultMap);
                }
            }
        } catch (SQLException e) {

        }
        return resultList;
    }

//    (otel_page_reservation_1'de) ilgili verileri methoda vererek roomIdler geldi
    public List<Map<String, Object>> controlHotelRoomsData(int hotelID, int roomTypeID, String startDate, String endDate) {
        List<Map<String, Object>> resultList = new ArrayList<>();

        String query = "SELECT COUNT(*) AS room_count, GROUP_CONCAT(hotel_roomsID) AS all_hotel_roomsIDs "
                + "FROM hotel_rooms "
                + "WHERE Hotel_hotelID = ? "
                + "AND Room_Type_room_typeID = ? "
                + "AND availability_start_date <= ? "
                + "AND availability_end_date >= ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, hotelID);
            preparedStatement.setInt(2, roomTypeID);
            preparedStatement.setString(3, startDate);
            preparedStatement.setString(4, endDate);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> resultMap = new HashMap<>();

                    resultMap.put("room_count", rs.getInt("room_count"));
                    resultMap.put("all_hotel_roomsIDs", rs.getString("all_hotel_roomsIDs"));
                    resultList.add(resultMap);
                }
            }
        } catch (SQLException e) {
        }

        return resultList;
    }

}
