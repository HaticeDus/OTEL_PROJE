<%-- 
    Document   : OTEL_PAGE_FILTRE
    Created on : 16 Ara 2023, 17:10:47
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="otel_model_classes.AllHotelsAndAllRooms" %>
<%@ page import="otel_model_classes.HotelMergeImages" %>
<%@ page import="otel_model_classes.HotelMergeRooms" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 
<!DOCTYPE html>
<% 
    //URL'den Alınan Bilgiler 
          String getUrlhotelName = request.getParameter("hotel");
          String getUrlhotelID = request.getParameter("hotelID");
            int getUrlhotelID_int = 0; 
           if (getUrlhotelID != null && !getUrlhotelID.isEmpty()) {
                getUrlhotelID_int = Integer.parseInt(getUrlhotelID);   
            }else{ //eğer sayfa yenilendiğinde null gelirse sessiondan bilgiyi al
                 getUrlhotelID_int=user_session.getHotelID();
    }
         
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%=getUrlhotelName%></title>
</head>

<body>
    <%@ include file="navbar.jsp" %>

<div style='margin: 2%;border: 1px solid #20c997;padding: 1%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3);  '>

    <!---------------------------------------OTEL KISMI--------------------------------------------------------------->

    <%
            HotelMergeImages hotelMergeImgs = new HotelMergeImages(); // nesne oluşturdum 
            List<Map<String, Object>> hotelDataLists = hotelMergeImgs.getHotelsAndAllImages(); // hotelDataList' ne classta üretilen hotelDataList atadım/Tüm resimler
            //--------------SEÇİLEN OTELİ GETİRME İŞLEMİ---------------------------------
            Map<String, Object> selectedHotel= hotelMergeImgs.getHotelByID(hotelDataLists,getUrlhotelID_int); //seçilen otelin nesne şeklinde aldım
            if (selectedHotel != null) {
            List<String> hotelImages = (List<String>) selectedHotel.get("hotel_images"); // seçilen otelin resim listesi
   
    %>
    <h2 style="margin-inline-start: 1%;  margin-block-start: 4%;"> <%=getUrlhotelName%></h2>
    <div class="divflexme" style="display: flex; justify-content: space-between;">
        <div style="margin-bottom: 2%; width: 50%; margin-top: 1%; padding: 2%; ">
            <% 
                if (hotelImages != null && !hotelImages.isEmpty()) {
                String firstImageUrl = hotelImages.get(0); // İlk resmin URL'si alınıyor
            %>
            <div class="row">
                <div class="col" style="display: contents;">
                    <div class="col-md-10" style="box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.75); border-radius: 5px;"> <!-- 1. resmin grid hücresi, büyük boyutlu -->
                        <img src="<%= firstImageUrl %>" alt="hotelImg" style="width:101%; border-radius: 5px;">
                    </div>
                </div>
                <div class="col">
                    <div class="row"> </div>
                    <% for (int i = 1; i < hotelImages.size(); i++) { %>
                    <% String imageUrl = hotelImages.get(i); %>
                    <img src="<%= imageUrl %>" alt="hotelImg" style="width:142%; margin: 3%; box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.75); border-radius: 5px;">
                        <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <div class="card-container" style="margin-bottom: 5%;  width: 50%; margin-top: 1%; padding: 2%;">
            <div class=" justify-content-center">
                <div class="col-md-12">
                    <div class="card border-success mb-3" style="max-width: 800px;">
                        <div class="card-header"> Otel Bilgi</div>
                        <div class="card-body ">
                            <h5 class="card-title"><%=getUrlhotelName%>  Açıklama</h5>
                            <p class="card-text"><%=selectedHotel.get("hotel_description")%></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="card border-info mb-3" style="max-width: 800px;">
                        <div class="card-header">Otel Konum </div>
                        <div class="card-body">
                            <h5 class="card-title"><%=getUrlhotelName%>  Adres</h5>
                            <p class="card-text"><%=selectedHotel.get("hotel_adress")%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <%}%>

    <!------------------------KİŞİ VE COCUK FORM KISMI------------------------------------------------------------------>
    <%
        //SESSION'DAN BİLGİLERİ AL
       int room_number= (int) user_session.getRoomNumber(); 
       String check_in_date= user_session.getCheck_in_date();
       String check_out_date=user_session. getCheck_out_date();
    %>
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card border-warning mb-3 mx-auto" style="width: 100%; margin:1%;">
                <div class="card-header">Seçiminiz:</div>
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <h6 class="card-text">Seçilen Oda Sayısı:  <%= room_number %></h6>
                        <h6 class="card-text">Giriş Tarihi: <%=check_in_date%></h6>
                        <h6 class="card-text">Çıkış Tarihi: <%= check_out_date %></h6>
                        <h6 class="card-text">Gün Sayısı:  <%= user_session.getDay() %></h6>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-----------------------------------------MEVCUT ODALAR------------------------------------------------------------------>
    <hr>
    <h4>Sizin için Uygun Olan Odalar</h4> 
    <hr>
    <%
          int selectedCity_int= (int) user_session.getSelectedCityID();
          String selectedCity = String.valueOf(selectedCity_int);
          AllHotelsAndAllRooms hotelData = new AllHotelsAndAllRooms();
          List<Map<String, Object>> filteredRoomsList = hotelData.getFilteredRooms(user_session.getRoomNumber(),selectedCity, check_in_date, check_out_date);
    %>

    <%if (filteredRoomsList != null && !filteredRoomsList.isEmpty()) {  
          HashSet<Object> controlRoomTypes = new HashSet<>(); // aynı oda türünden 1 tane dönsün
    %>
    <% for (Map<String, Object> rooms : filteredRoomsList) { %>
    <% Object hotelID = rooms.get("Hotel_hotelID"); %>
    <%  if (!controlRoomTypes.contains(rooms.get("Room_Type_room_typeID")) && hotelID.equals(getUrlhotelID_int)){ 
              controlRoomTypes.add(rooms.get("Room_Type_room_typeID")); 
    %>

    <div class="card mb-3" style="max-width: 100%;">
        <div class="row g-0">
            <div class="col-md-4">
                <img src="<%=rooms.get("hotel_rooms_img_url")%>" class="img-fluid rounded-start" alt="...">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%=rooms.get("hotel_room_name")%></h5>
                    <p class="card-text"> <%= rooms.get("room_description") %></p>
                    <div style="    margin-block-start: 10%;  margin-bottom: 2%;">
                        <p class="card-text"><strong>Kişi Başı Tek gecelik konaklama Fiyatı: <%= rooms.get("room_price") %>TL</strong></p>
                        <p class="card-text" style="color: #ff0018">Max Kişi Kapasitesi: <%= rooms.get("max_person_capacity")%></p>
                    </div>
                    <!--<a href="RESERVATION.jsp?hotel_room_type=<%=rooms.get("Room_Type_room_typeID")%>&max_person_capacity=<%= rooms.get("max_person_capacity")%>" class="btn btn-success">Rezervasyon Yap</a>-->
                    <form id="reservationForm" action="RESERVATION.jsp" method="POST">
                        <input type="hidden" name="hotel_room_type" value="<%= rooms.get("Room_Type_room_typeID") %>">
                            <input type="hidden" name="max_person_capacity" value="<%= rooms.get("max_person_capacity") %>">
                                <button type="submit" class="btn btn-success">Rezervasyon Yap</button>
                                </form>


                                </div>
                                </div>
                                </div>
                                </div>
                                <% 
                                      }
                                    }
                                 }
                                %>

                                </div>
                                <%@ include file="footer.jsp" %>
                                </body>
                                </html>
