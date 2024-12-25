<%-- 
    Document   : sessionRecordTEST
    Created on : 2 Ara 2023, 14:55:30
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 
<jsp:useBean id="user" class="otel_model_classes.Customer" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>SESSİON TEST</title>
</head>
<body>                

    <p><strong>KULLANICI SEÇİMİ</strong></p>
    <%
     
     out.println("<hr>(OTEL_FILTRE.jsp'de kaydettim)<br>veya( otel_page.jsp'de) <br> otel_page_reservation_1 <br>*kullanıcı nerden seçtiyse<br>");
     out.println("<br>"+"Seçilen Şehir: "+ user_session.getSelectedCityID());
     out.println("<br>"+"Seçilen Oda sayısı: "+ user_session.getRoomNumber());
     out.println("<br>"+"Giriş tarihi: "+ user_session.getCheck_in_date());
     out.println("<br>Çıkış tarihi: "+user_session.getCheck_out_date());
      out.println("<br>"+"Gün sayısı:  "+ user_session.getDay()+"<br><br><br><hr>");
     
     
    out.println("(RESERVATION.jsp'de kaydettim)veya( otel_page.jsp'de) <br>otel_page_reservation<br>");
     out.println("<br>"+"Seçilen Otel ID: "+ user_session.getHotelID());
     out.println("<br>"+"Seçilen Oda ID: "+ user_session.getHotel_roomsID());   
      out.println("<br>"+"Seçilen Oda Türü: "+ user_session.getHotel_room_type());   
     out.println("<br>"+"Seçilen Oda fiyatı:  "+ user_session.getRoom_price()+"<br><br><br><hr>");
        
        
  List<Map<String, String>> roomDetailsList = (List<Map<String, String>>) user_session.getRoomDetailsList();
out.println("(RESERVATION_1.jsp'de kaydettim)<br><br>");
if (roomDetailsList != null) {
for (Map<String, String> roomDetails : roomDetailsList) {
    out.println("checkInDate: " + roomDetails.get("checkInDate"));
    out.println("checkOutDate: " + roomDetails.get("checkOutDate"));
    out.println("Room Number: " + roomDetails.get("room_number"));
    out.println(", Person Number: " + roomDetails.get("person_number"));
    out.println(", Child Number: " + roomDetails.get("child_number"));
  //  out.println(", totalPrice: " + roomDetails.get("totalPrice")); //null hatası veriyor
    out.println(", roomID: " + roomDetails.get("roomID"));

  if (roomDetails.containsKey("child_number") && roomDetails.get("child_number") != null) {
        int childCount = Integer.parseInt(roomDetails.get("child_number"));
        for (int i = 1; i <= childCount; i++) {
            String childYear = roomDetails.get("child_year_" + i);
            out.println(", Child " + i + " Year: " + childYear);
        }
    }
    out.println("<br>");
}
} else {
out.println("Room details list is empty or null.<br>");
}

 String[] roomPriceArray = (String[]) user_session.getRoomPriceArray();
if (roomPriceArray != null) {
    for (int i = 0; i < roomPriceArray.length; i++) {
        out.println("<br>Oda " + (i + 1) + ": " + roomPriceArray[i]);
    }
} else {
    out.println("roomPriceArray is null");
}





  out.println("<br>Toplam Tutar:  " + user_session.getTotalPrice());
    %>



    <br><br><br><br><hr>
<div>
    <p><strong>OTURUMU YAPAN KULLANICI</strong></p>
    <div>
        <p>User ID:  <%= user.getCustomerID() %></p>
        <p>Ad Soyad: <%= user.getCustomerNameSurname() %></p>
        <p>E-posta: <%= user.getCustomerEmail() %></p>
        <p>Telefon: <%= user.getCustomerTel() %></p>
        <p>Adres: <%= user.getCustomerAdress() %></p>
        <p>Cinsiyet: <%= user.getGender() %></p>
        <p>Doğum Tarihi: <%= user.getDateOfBirth() %></p>
        <!-- Diğer kullanıcı bilgileri buraya eklenebilir -->
    </div>
</div>
<br><br>



</body>
</html>
