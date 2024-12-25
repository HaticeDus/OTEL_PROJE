/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

/**
 *
 * @author Monster
 */
public class Customer {

    private Integer customerID; //customerID
    private String customerNameSurname; //customer_name_surname
    private String customerEmail; // customer_email
    private String customerTel; // customer_tel
    private String customerAdress; // customer_adress
    private String gender; // gender
    private String dateOfBirth; // date_of_birth

    //------------------------------------------------------------------
        public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }
//------------------------------------------------------------------

    public String getCustomerNameSurname() {
        return customerNameSurname;
    }

    public void setCustomerNameSurname(String customerNameSurname) {
        this.customerNameSurname = customerNameSurname;
    }
//---------------------------------------------------------------------

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
//------------------------------------------------------------------

    public String getCustomerTel() {
        return customerTel;
    }

    public void setCustomerTel(String customerTel) {
        this.customerTel = customerTel;
    }
//------------------------------------------------------------------

    public String getCustomerAdress() {
        return customerAdress;
    }

    public void setCustomerAdress(String customerAdress) {
        this.customerAdress = customerAdress;
    }
//------------------------------------------------------------------

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
//------------------------------------------------------------------

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

}
