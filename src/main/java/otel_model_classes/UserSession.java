/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package otel_model_classes;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Monster
 */
public class UserSession {

    private String check_in_date;
    private String check_out_date;
    private int day;
    private int selectedCityID;
    private int roomNumber;
    private String hotel_roomsID;
    private int hotelID;
    private double room_price;
    private double totalPrice;
    private int hotel_room_type;
    private String[] roomPriceArray;

    private List<Map<String, String>> roomDetailsList;

    public List<Map<String, String>> getRoomDetailsList() {
        return roomDetailsList;
    }

    public void setRoomDetailsList(List<Map<String, String>> roomDetailsList) {
        this.roomDetailsList = roomDetailsList;
    }

    /**
     * @return the check_in_date
     */
    public String getCheck_in_date() {
        return check_in_date;
    }

    /**
     * @param check_in_date the check_in_date to set
     */
    public void setCheck_in_date(String check_in_date) {
        this.check_in_date = check_in_date;
    }

    /**
     * @return the check_out_date
     */
    public String getCheck_out_date() {
        return check_out_date;
    }

    /**
     * @param check_out_date the check_out_date to set
     */
    public void setCheck_out_date(String check_out_date) {
        this.check_out_date = check_out_date;
    }

    /**
     * @return the hotel_roomsID
     */
    public String getHotel_roomsID() {
        return hotel_roomsID;
    }

    /**
     * @param hotel_roomsID the hotel_roomsID to set
     */
    public void setHotel_roomsID(String hotel_roomsID) {
        this.hotel_roomsID = hotel_roomsID;
    }

    /**
     * @return the hotelID
     */
    public int getHotelID() {
        return hotelID;
    }

    /**
     * @param hotelID the hotelID to set
     */
    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    /**
     * @return the selectedCityID
     */
    public int getSelectedCityID() {
        return selectedCityID;
    }

    /**
     * @param selectedCityID the selectedCityID to set
     */
    public void setSelectedCityID(int selectedCityID) {
        this.selectedCityID = selectedCityID;
    }

    /**
     * @return the roomNumber
     */
    public int getRoomNumber() {
        return roomNumber;
    }

    /**
     * @param roomNumber the roomNumber to set
     */
    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    /**
     * @return the room_price
     */
    public double getRoom_price() {
        return room_price;
    }

    /**
     * @param room_price the room_price to set
     */
    public void setRoom_price(double room_price) {
        this.room_price = room_price;
    }

    /**
     * @return the day
     */
    public int getDay() {
        return day;
    }

    /**
     * @param day the day to set
     */
    public void setDay(int day) {
        this.day = day;
    }

    /**
     * @return the totalPrice
     */
    public double getTotalPrice() {
        return totalPrice;
    }

    /**
     * @param totalPrice the totalPrice to set
     */
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    /**
     * @return the hotel_room_type
     */
    public int getHotel_room_type() {
        return hotel_room_type;
    }

    /**
     * @param hotel_room_type the hotel_room_type to set
     */
    public void setHotel_room_type(int hotel_room_type) {
        this.hotel_room_type = hotel_room_type;
    }

    /**
     * @return the roomPriceArray
     */
    public String[] getRoomPriceArray() {
        return roomPriceArray;
    }

    /**
     * @param roomPriceArray the roomPriceArray to set
     */
    public void setRoomPriceArray(String[] roomPriceArray) {
        this.roomPriceArray = roomPriceArray;
    }
}
