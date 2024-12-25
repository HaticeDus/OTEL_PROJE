<%-- 
    Document   : otel_page_reservation
    Created on : 23 Ara 2023, 17:19:26
    Author     : Monster
--%>

<!--otel_page.jsp FORM İLE  hotel_room_type ve max_person_capacity  bilgilerini aldım--> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="otel_model_classes.HotelMergeRooms" %>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Form Sayfası</title>
</head>
<body>
    <%@ include file="navbar.jsp" %>
<div style='margin: 2%;border: 1px solid #20c997;padding: 2%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3);  margin-bottom: 5%;'>

    <%
        //SESSION da aldım
        int hotelID_session=user_session.getHotelID();
       //URL'DEN BİLGİLERİ AL
              String hotel_room_type = request.getParameter("hotel_room_type");
              int hotelRoomtype= (hotel_room_type != null && !hotel_room_type.isEmpty()) ? Integer.parseInt(hotel_room_type) : 0;
              user_session.setHotel_room_type(hotelRoomtype); //SESSİONA URL'DEN GELEN ODA TYPE KAYDETTİM
              String max_person_capacityStr = request.getParameter("max_person_capacity");
              int maxPersonCapacity = (max_person_capacityStr != null && !max_person_capacityStr.isEmpty()) ? Integer.parseInt(max_person_capacityStr) : 0;
              
              String hotel_name = request.getParameter("hotel_name");
              String hotel_room_img=" ";
    %>

    <h3 style="margin-inline-start: 1%; margin-bottom:  2%;" id="Rooms"> Seçilen Oda</h3>

    <%
         HotelMergeRooms hotelMergeRooms = new HotelMergeRooms(); // sınıfın nesnesini oluşturdum 
          List<Map<String, Object>> hotelRoomsList = hotelMergeRooms.getAllHotelRoomsByHotelID(hotelID_session);
         
           if(hotelRoomsList !=null && !hotelRoomsList.isEmpty())
           {
               for(Map<String, Object> hotelRoom: hotelRoomsList)
               {
                 int hotel_ID= (int) hotelRoom.get("Hotel_hotelID");
                 int roomType= (int) hotelRoom.get("Room_Type_room_typeID"); 
                 
                 Object imageUrlObject = hotelRoom.get("hotel_rooms_img_url");
                 hotel_room_img = (imageUrlObject != null) ? imageUrlObject.toString() : "";

                 
              if( (hotel_ID== hotelID_session)  && (roomType==hotelRoomtype))
                  {
    %>

    <h5 style="margin-inline-start: 1%; margin-bottom:  2%;"><%=hotel_name%></h5>

    <div class="card mb-3" style="max-width: 100%;">
        <div class="row g-0">
            <div class="col-md-4">
                <img src="<%=hotelRoom.get("hotel_rooms_img_url")%>" class="img-fluid rounded-start" alt="...">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%=hotelRoom.get("hotel_room_name")%></h5>
                    <p class="card-text"> <%= hotelRoom.get("room_description") %></p>
                    <div style="    margin-block-start: 10%;  margin-bottom: 2%;">
                        <p class="card-text"><strong>Kişi Başı Tek gecelik konaklama Fiyatı: <%= hotelRoom.get("room_price") %>TL</strong></p>
                        <p class="card-text" style="color: #ff0018">Max Kişi Kapasitesi: <%= hotelRoom.get("max_person_capacity")%></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%
        double roomPrice = ((Number) hotelRoom.get("room_price")).doubleValue();
        user_session.setRoom_price(roomPrice); //SESSİONA KAYDETTİM
     }
    }
 }else{
    out.println("hotelRoomsList Boş!");
    }
    %>

    <hr>

    <!--FORM KISMI-->

    <div class="container  justify-content-center align-items-center my-5" style=" left: 25%; border: 1px solid #dc3545; max-width: auto; padding: 2%; border-radius: 1%; ;box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);  font-size: large;">
        <h5 style=" text-align: center; margin: 10px;">Lütfen Oda için Gerekli Olan Bilgileri Girin </h5> 
        <hr>
        <form method="POST" action="otel_page_reservation_1.jsp">
            <div class="row" style="margin: 5%">

                <div class="col-md-4">
                    <div class="d-flex align-items-center">
                        <select class="form-select" aria-label="Default select example" id="roomNumberSelect" name="room_number" required>
                            <option selected disabled value="">Oda sayısı seç</option>
                            <% for (int i = 1; i <= 5; i++) { %>
                            <option value="<%=i%>"><%=i%></option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <!--DATAPICKER PART-->
                <div class="col-md-4">
                    <div class="row">
                        <!--<div class="col-sm-6">-->
                        <div class="row form-group">
                            <label for="date" class="col-sm-4 col-form-label">Giriş tarihi: </label>
                            <div class="col-sm-6">
                                <div class="input-group date" id="datepicker_in">
                                    <input type="date" id="date" class="form-control" name="check_in_date" required>
                                </div>
                            </div>
                        </div>
                        <!--</div>-->
                    </div>
                </div>

                <div class="col-md-4">
                    <!--<div class="col-sm-6">-->
                    <div class="row form-group">
                        <label for="date" class="col-sm-4 col-form-label">Çıkış tarihi: </label>
                        <div class="col-sm-6">
                            <div class="input-group date" id="datepicker_out">
                                <input type="date" id="date" class="form-control" name="check_out_date" required>
                            </div>
                        </div>
                    </div>
                    <!--</div>-->
                </div>
            </div>
            <input type="hidden" name="max_person_capacity" value="<%= maxPersonCapacity %>">
             <!--<input type="hidden" name="hotel_room_img" value="<%= hotel_room_img %>">-->
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn btn-outline-danger" style="width: 50%;">Odayı Ara </button>
                </div>

        </form>
    </div>

</div>

<%@ include file="footer.jsp" %>
</body>
</html>
