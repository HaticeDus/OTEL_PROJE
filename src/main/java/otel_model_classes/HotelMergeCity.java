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
public class HotelMergeCity {

    public List<Map<String, Object>> getCities() {

        List<Map<String, Object>> cityDataList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM city";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Map<String, Object> cityData = new HashMap<>();
                cityData.put("cityID", resultSet.getInt("cityID")); //map e kayıt
                cityData.put("city_name", resultSet.getString("city_name"));
                cityDataList.add(cityData); //key-value çiftlerini map liste kaydettim
            }
        } catch (SQLException e) {
            //e.printStackTrace();
        }

        return cityDataList;
    }

    public String getCityNameByID(String cityID) {
        String cityName = "";

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT city_name FROM city WHERE cityID = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, cityID);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                cityName = resultSet.getString("city_name");
            }
        } catch (SQLException e) {
            // Hata yönetimi burada
        }

        return cityName;
    }

}
