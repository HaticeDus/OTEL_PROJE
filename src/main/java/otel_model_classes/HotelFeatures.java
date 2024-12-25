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
public class HotelFeatures {

    public List<Map<String, Object>> getFeatures() {
        List<Map<String, Object>> featureDataList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM feature";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> featureData = new HashMap<>();
                featureData.put("featureID", resultSet.getInt("featureID"));
                featureData.put("feature_name", resultSet.getString("feature_name"));
                featureDataList.add(featureData);
            }
        } catch (SQLException e) {
        }

        return featureDataList;
    }
}
