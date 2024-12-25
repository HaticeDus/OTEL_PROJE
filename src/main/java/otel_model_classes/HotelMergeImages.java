/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

/**
 *
 * @author Monster
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HotelMergeImages {

    //TÜM RESİMLERİN DÖNDÜĞÜ METHOD
    public List<Map<String, Object>> getHotelsAndAllImages() {

        List<Map<String, Object>> hotelDataList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {

            String query = "SELECT h.hotelID, h.hotel_name, h.hotel_adress, h.hotel_description, h.City_cityID, hi.hotel_img_url FROM hotel h LEFT JOIN hotel_images hi ON h.hotelID = hi.Hotel_hotelID";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            Map<Integer, List<String>> hotelImagesMap = new HashMap<>(); // Otel ID'sine göre resimleri tutacak map
            //bir otele ait bir sürü resim olduğundan
            while (resultSet.next()) {
                int hotelID = resultSet.getInt("hotelID");
                String imageUrl = resultSet.getString("hotel_img_url");

                // Otel ID'sine göre resimleri eşleştirme
                if (!hotelImagesMap.containsKey(hotelID)) {
                    hotelImagesMap.put(hotelID, new ArrayList<>());
                }
                hotelImagesMap.get(hotelID).add(imageUrl); //otel ıd ye göre resim listesini ekle 

                // Diğer otel bilgilerini alarak bir diziye ekleme
                Map<String, Object> hotelData = new HashMap<>();
                hotelData.put("hotelID", hotelID);
                hotelData.put("hotel_name", resultSet.getString("hotel_name"));
                hotelData.put("hotel_adress", resultSet.getString("hotel_adress"));
                hotelData.put("hotel_description", resultSet.getString("hotel_description"));
                hotelData.put("cityID", resultSet.getInt("City_cityID"));

                hotelDataList.add(hotelData);
            }

            // Her otelin resimlerini ekleyerek Merge Listeyi oluştur
            for (Map<String, Object> hotelData : hotelDataList) {
                int hotelID = (int) hotelData.get("hotelID");
                if (hotelImagesMap.containsKey(hotelID)) {
                    hotelData.put("hotel_images", hotelImagesMap.get(hotelID));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return hotelDataList;
    }

    //EŞLEŞEN hotelID İÇİN OTEL NESNESİ DÖNDÜREN METHOD
    public Map<String, Object> getHotelByID(List<Map<String, Object>> hotelDataLists, int hotelID) {
        for (Map<String, Object> hotel : hotelDataLists) {
            int currentHotelID = (int) hotel.get("hotelID");
            if (currentHotelID == hotelID) {
                return hotel; // Eşleşen oteli buldum, nesneyi geri döndür
            }
        }
        return null; // Eşleşen otel bulunamadıysa
    }

    //SADECE İLK RESİMLERİN DÖNDÜĞÜ METHOD
    public List<Map<String, Object>> getHotelsAndFirstImages() {

        List<Map<String, Object>> hotelDataList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT "
                    + "    h.hotelID, "
                    + "    h.hotel_name, "
                    + "    h.hotel_adress, "
                    + "    h.hotel_description, "
                    + "    h.City_cityID, "
                    + "    hi.hotel_img_url AS first_image "
                    + "FROM "
                    + "    hotel h "
                    + "LEFT JOIN "
                    + "    hotel_images hi ON h.hotelID = hi.Hotel_hotelID "
                    + "WHERE "
                    + "    hi.hotel_imagesID = ( "
                    + "        SELECT MIN(sub.hotel_imagesID) "
                    + "        FROM hotel_images sub "
                    + "        WHERE sub.Hotel_hotelID = h.hotelID "
                    + "    );";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            Map<Integer, String> hotelFirstImageMap = new HashMap<>(); // Sadece ilk resmi tutacak map

            while (resultSet.next()) {
                int hotelID = resultSet.getInt("hotelID");
                String imageUrl = resultSet.getString("first_image");

                // Otele ait ilk resmi ekleme
                if (!hotelFirstImageMap.containsKey(hotelID)) {
                    hotelFirstImageMap.put(hotelID, imageUrl);
                }

                // Diğer otel bilgilerini alarak bir diziye ekleme
                Map<String, Object> hotelData = new HashMap<>();
                hotelData.put("hotelID", hotelID);
                hotelData.put("hotel_name", resultSet.getString("hotel_name"));
                hotelData.put("hotel_adress", resultSet.getString("hotel_adress"));
                hotelData.put("hotel_description", resultSet.getString("hotel_description"));
                hotelData.put("cityID", resultSet.getInt("City_cityID"));
                hotelDataList.add(hotelData);
            }
            // Her otelin ilk resmini ekleyerek Merge Listeyi oluştur
            for (Map<String, Object> hotelData : hotelDataList) {
                int hotelID = (int) hotelData.get("hotelID");
                if (hotelFirstImageMap.containsKey(hotelID)) {
                    hotelData.put("first_image", hotelFirstImageMap.get(hotelID));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hotelDataList;
    }

    //SADECE İLK RESİM ve  HOTEL MERGE CATEGORY // categoryID'ye göre  listelemek için
    public List<Map<String, Object>> getHotelsAndCategories() {

        List<Map<String, Object>> hotelDataList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT "
                    + "h.hotelID, "
                    + "h.hotel_name, "
                    + "h.hotel_adress, "
                    + "h.hotel_description, "
                    + "hi.hotel_img_url AS first_image, "
                    + "c.categoryID, "
                    + "c.category_name "
                    + "FROM "
                    + "hotel h "
                    + "LEFT JOIN "
                    + "hotel_images hi ON h.hotelID = hi.Hotel_hotelID "
                    + "INNER JOIN "
                    + "hotel_category hc ON h.hotelID = hc.Hotel_hotelID "
                    + "INNER JOIN "
                    + "category c ON hc.Category_categoryID = c.categoryID "
                    + "WHERE "
                    + "hi.hotel_imagesID = ( "
                    + "SELECT "
                    + "MIN(sub.hotel_imagesID) "
                    + "FROM "
                    + "hotel_images sub "
                    + "WHERE "
                    + "sub.Hotel_hotelID = h.hotelID "
                    + ")";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            Map<Integer, String> hotelFirstImageMap = new HashMap<>(); // Sadece ilk resmi tutacak map

            while (resultSet.next()) {
                int hotelID = resultSet.getInt("hotelID");
                String imageUrl = resultSet.getString("first_image");

                // Otele ait ilk resmi ekleme
                if (!hotelFirstImageMap.containsKey(hotelID)) {
                    hotelFirstImageMap.put(hotelID, imageUrl);
                }

                // Diğer otel bilgilerini alarak bir diziye ekleme
                Map<String, Object> hotelData = new HashMap<>();
                hotelData.put("hotelID", hotelID);
                hotelData.put("hotel_name", resultSet.getString("hotel_name"));
                hotelData.put("hotel_adress", resultSet.getString("hotel_adress"));
                hotelData.put("hotel_description", resultSet.getString("hotel_description"));
                hotelData.put("categoryID", resultSet.getInt("categoryID"));
                hotelData.put("category_name", resultSet.getString("category_name"));
                hotelDataList.add(hotelData);
            }

            // Her otelin ilk resmini ekleyerek Merge Listeyi oluştur
            for (Map<String, Object> hotelData : hotelDataList) {
                int hotelID = (int) hotelData.get("hotelID");
                if (hotelFirstImageMap.containsKey(hotelID)) {
                    hotelData.put("first_image", hotelFirstImageMap.get(hotelID));
                }
            }
        } catch (SQLException e) {

        }

        return hotelDataList;

    }

}
