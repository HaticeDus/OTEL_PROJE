/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Monster
 */
//REGISTER OLAN KULLANICILARI DATABASE'E EKLEYEN CLASS
public class RegisterCustomer {

    public int addCustomer(Customer customer) {

        //database de daha önce bu iki kayıda ait Customer bilgisi var mı
        boolean emailExists = isFieldExists("CustomerEmail", customer.getCustomerEmail());
        boolean nameSurnameExists = isFieldExists("CustomerNameSurname", customer.getCustomerNameSurname());

        if (emailExists && nameSurnameExists) {
            return -1; // Eğer her ikisi de varsa -1 döndür çünkü registerda -1'e eşit değilse else girecek
        } else {

            int newCustomerID = -1;
            try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO customer (customer_name_surname, customer_email, customer_tel, customer_adress, gender, date_of_birth) VALUES (?, ?, ?, ?, ?, ?)",
                    PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, customer.getCustomerNameSurname());
                stmt.setString(2, customer.getCustomerEmail());
                stmt.setString(3, customer.getCustomerTel());
                stmt.setString(4, customer.getCustomerAdress());
                stmt.setString(5, customer.getGender());
                stmt.setString(6, customer.getDateOfBirth());

                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            newCustomerID = generatedKeys.getInt(1);
                        }
                    }
                }
            } catch (SQLException e) {

                e.printStackTrace();

            }

            return newCustomerID;//kayıt başarılı olduğunda yeni kullanıcının ıd si dönsün dedim 

        }

    }

    // girilen değerlerin veritabanında var olup olmadığını kontrol ediyorum
    private boolean isFieldExists(String fieldName, String value) {
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM customer WHERE " + fieldName + " = ?")) {
            stmt.setString(1, value);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0; // Eğer alanın değeri bulunduysa true döner
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Alanın değeri bulunamadıysa veya bir hata oluştuysa false döner
    }

}
