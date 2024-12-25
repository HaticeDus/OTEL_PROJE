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
import java.util.List;

/**
 *
 * @author Monster
 */
//LOGIN İÇİN TÜM CUSTOMER BİLGİSİ ÇEKİLDİ
public class CustomerDataAccess {

    public boolean checkUserExistence(String nameSurname, String email) {
        // Veritabanında kullanıcının varlığını kontrol etmek için gerekli SQL sorgusunu oluştur
        // Burada nameSurname ve email değerlerini kullanarak gerekli sorguyu yap

        String sql = "SELECT COUNT(*) AS count FROM customer WHERE customer_name_surname = ? AND customer_email = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nameSurname);
            stmt.setString(2, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0; // Eğer kullanıcı varsa true döner
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Kullanıcı yoksa veya hata oluştuysa false dönüyor
    }

    public Customer getCustomer(String nameSurname, String email) {
        Customer customer = null;

        String sql = "SELECT * FROM customer WHERE customer_name_surname = ? AND customer_email = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nameSurname);
            stmt.setString(2, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setCustomerID(rs.getInt("customerID"));
                    customer.setCustomerNameSurname(rs.getString("customer_name_surname"));
                    customer.setCustomerEmail(rs.getString("customer_email"));
                    customer.setCustomerTel(rs.getString("customer_tel"));
                    customer.setCustomerAdress(rs.getString("customer_adress"));
                    customer.setGender(rs.getString("gender"));
                    customer.setDateOfBirth(rs.getString("date_of_birth"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer; //db'de var olan kullanıcının nesnesini döndür
    }

}
