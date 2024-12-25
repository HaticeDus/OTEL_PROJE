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
import java.sql.*;

/**
 *
 * @author Monster
 */
public class HotelMergeCategory {

    public List<Map<String, Object>> HotelMergeCategory() {

        List<Map<String, Object>> hotelMergCatList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT h.hotelID, h.hotel_name, h.hotel_adress, h.hotel_description, c.categoryID, c.category_name"
                    + "FROM hotel h"
                    + "JOIN hotel_category hc ON h.hotelID = hc.Hotel_hotelID"
                    + "JOIN category c ON hc.Category_categoryID = c.categoryID";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> hotelCategory = new HashMap<>();

                hotelCategory.put("categoryID", resultSet.getInt("categoryID"));
                // hotelCategory.put("categoryName", resultSet.getString("category_name"));
                hotelCategory.put("hotelID", resultSet.getInt("hotelID"));
                //hotelCategory.put("hotel_name", resultSet.getString("hotel_name"));
                // hotelCategory.put("hotel_adress", resultSet.getString("hotel_adress"));
                // hotelCategory.put("hotel_description", resultSet.getString("hotel_description"));
                hotelCategory.put("cityID", resultSet.getInt("City_cityID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hotelMergCatList;
    }

    public List<Map<String, Object>> getAllCategories() {

        List<Map<String, Object>> categories = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM category";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> category = new HashMap<>();
                category.put("categoryID", resultSet.getInt("categoryID"));
                category.put("category_name", resultSet.getString("category_name"));
                category.put("category_img", resultSet.getString("category_img"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
}
