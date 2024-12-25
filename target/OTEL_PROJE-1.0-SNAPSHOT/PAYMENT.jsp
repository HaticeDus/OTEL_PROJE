<%-- 
    Document   : PAYMENT
    Created on : 18 Ara 2023, 01:12:15
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@page import="otel_model_classes.Reservation" %>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 
<%--<jsp:useBean id="user" class="otel_model_classes.Customer" scope="session"/>--%> <!--zaten navbarda var-->

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ödeme Sayfası</title>
</head>
<body>
    <%@ include file="navbar.jsp" %>
<div style='margin: 2%;border: 1px solid #20c997;padding: 2%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3);  margin-bottom:25%;'>
    <h3>ÖDEME İŞLEMLERİ</h3>

    <%
         boolean isSuccess = false;
          Reservation reservation = new Reservation();
          List<Map<String, String>> roomDetailsList = (List<Map<String, String>>) user_session.getRoomDetailsList();
          
          
         
       int customerID = 0;
      if (user.getCustomerID() != null && user.getCustomerID() != 0) 
      {
           customerID = user.getCustomerID();
           int hotelID = 0;
            Integer sessionHotelID = user_session.getHotelID(); // Integer tipinde bir değişken kullanmalısınız, int değil

           if (sessionHotelID != null && !sessionHotelID.equals(0)) 
           {
               hotelID = sessionHotelID; 
            } else 
            {
                 out.println("Otel Seçilmemiş !<br><br>");
            }
        
          if (roomDetailsList != null) // oda sayısı kadar döner
          {
          String[] roomPriceArray =  (String[]) user_session.getRoomPriceArray(); // sessiondan alıyorum
          int k=0;
          
              for (Map<String, String> roomDetails : roomDetailsList) 
              {  
                String checkInDate = roomDetails.get("checkInDate") != null ? roomDetails.get("checkInDate") : "Giriş Tarihi Seçilmemiş ";
                String checkOutDate = roomDetails.get("checkOutDate") != null ? roomDetails.get("checkOutDate") : "Çıkış Tarihi Seçilmemiş";
                String personNumber = roomDetails.get("person_number") != null ? roomDetails.get("person_number") : "Kişi Sayısı Seçilmemiş";
                String childNumber = roomDetails.get("child_number") != null ? roomDetails.get("child_number") : "Çocuk Sayısı Seçilmemiş";
                String totalPrice =roomPriceArray[k]; 
                k++;
                String roomID = roomDetails.get("roomID") != null ? roomDetails.get("roomID") : "Oda Seçilmemiş!";
                
//                 out.println("customerID: " + customerID);
//                 out.println("hotelID:  " + hotelID);
//                 out.println("checkInDate: " + checkInDate);
//                 out.println("checkOutDate: " + checkOutDate);
//                 out.println(", Person Number: " + personNumber);
//                 out.println(", Child Number: " + childNumber);
//                 out.println(", totalPrice: " + totalPrice);
//                 out.println(", roomID: " + roomID);
//                 out.println("<br>");
                 
                 //FOR İÇİNDE DATABASE'E GÖNDERİYORUM!
                 int personNumberInt = Integer.parseInt(personNumber);
                 int childNumberInt = Integer.parseInt(childNumber);
                 double totalPriceDouble = Double.parseDouble(totalPrice);
                 int roomIDInt = Integer.parseInt(roomID);
                            
                isSuccess = reservation.addReservation(customerID, hotelID, checkInDate, checkOutDate, personNumberInt, childNumberInt, totalPriceDouble, roomIDInt);
                     if (isSuccess) {
                             //out.println("Rezervasyon başarıyla yapıldı.");
                      } else {
                            out.println("Rezervasyon sırasında bir hata oluştu.");
                      }
                 }
            } 
            else 
            {
                out.println("Kayıtlı Oda detayı Bulunmadı!");
             }
    
        } 
        else 
         {
    %>
    <div class="card text-bg-danger mb-3" style="max-width: 100%;">
        <h4 class="card-body">Rezervasyon için Lütfen Kaydolun veya Hesabınız ile Giriş Yapın !</h4>
    </div>
    <%
         }
           //--------------REZERVASYON MESAJI KULLANICIYA  1 KEZ DÖNSÜN-------------------------
          if (isSuccess)
                     {
                session.removeAttribute("user_session"); //REZERVASYON ALINDIKTAN SONRA SESSİONU TEMİZLE
    %>
    <div class="card text-bg-success mb-3" style="max-width: 50%;">
        <h4 class="card-body">Rezervasyon Başarıyla Yapıldı.</h4>
    </div>
    <%
                           
     } else {
    %>
    <div class="card text-bg-danger mb-3" style="max-width: 100%;">
        <h4 class="card-body">Maalesef, Rezervasyon İşlemi Gerçekleşmedi!</h4>
    </div>
    <%
    }
    %>


</div>
<%@ include file="footer.jsp" %>
</body>
</html>
