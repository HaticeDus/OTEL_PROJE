<%-- 
    Document   : otel_page
    Created on : 2 Ara 2023, 12:57:41
    Author     : Monster
--%>
<!--OTELLERİ GÖRÜNTÜLEDİĞİM SAYFA-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="otel_model_classes.HotelMergeImages" %>
<%@ page import="otel_model_classes.HotelMergeRooms" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 

<!--otel_card_jsp'den seçildi-->

<!DOCTYPE html>
<% 
          String getUrlhotelName = request.getParameter("hotel");
          String getUrlhotelID = request.getParameter("hotelID");
            int getUrlhotelID_int = 0; 
           if (getUrlhotelID != null && !getUrlhotelID.isEmpty()) {
                getUrlhotelID_int = Integer.parseInt(getUrlhotelID); 
                user_session.setHotelID(getUrlhotelID_int); //SESSİONA KAYDETTİM
            }else{ //eğer sayfa yenilendiğinde null gelirse sessiondan bilgiyi al
                 getUrlhotelID_int=user_session.getHotelID();
    }
         
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%=getUrlhotelName%></title> 

</head>



<body  class="p-0 m-0 border-0 bd-example m-0 border-0">
    <%@ include file="navbar.jsp" %>

<div style='margin: 2%;border: 1px solid #20c997;padding: 1%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3); '>

    <%
         HotelMergeImages hotelMergeImgs = new HotelMergeImages(); // nesne oluşturdum 
         List<Map<String, Object>> hotelDataLists = hotelMergeImgs.getHotelsAndAllImages(); // hotelDataList' ne classta üretilen hotelDataList atadım/Tüm resimler
         //--------------SEÇİLEN OTELİ GETİRME İŞLEMİ---------------------------------
         Map<String, Object> selectedHotel= hotelMergeImgs.getHotelByID(hotelDataLists,getUrlhotelID_int); //seçilen otelin nesne şeklinde aldım
         if (selectedHotel != null) {
         List<String> hotelImages = (List<String>) selectedHotel.get("hotel_images"); // seçilen otelin resim listesi
         //-------------------------------------------------------
          Object cityIDObj = selectedHotel.get("cityID");
          int cityID = 0; 
        
        if (cityIDObj != null) {
            cityID = (int) cityIDObj;
            user_session.setSelectedCityID(cityID); // SESSİONA KAYDETTIM
        }
    %>

    <nav aria-label="breadcrumb"  style="margin-inline-start: 1%;  margin-block-start: 4%; ">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"> <a href="#Otel"> <span style="color:red"><%=getUrlhotelName%></span></a></li>
            <li class="breadcrumb-item"><a href="#Rooms"><span style="color:red">Odalar</span></a></li>
        </ol>
    </nav>

    <h2 style="margin-inline-start: 1%;  margin-block-start: 4%;"> <%=getUrlhotelName%></h2>
    <div class="divflexme" id="Otel" style="display: flex; justify-content: space-between;">
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

    <!-----------------------------------------------------HOTEL ROOM PART------------------------------------------------------------------------------------------------ -->     

    <%
     HotelMergeRooms hotelMergeRooms = new HotelMergeRooms(); // sınıfın nesnesini oluşturdum 
     List<Map<String, Object>> hotelRoomsList = hotelMergeRooms.getAllHotelRoomsByHotelID(getUrlhotelID_int); // methoddan listeyi aldım
     //--------------SEÇİLEN OTELİN ODALARINI GETİRME İŞLEMİ---------------------------------
    List<Map<String, Object>> selectedHotelRooms = hotelMergeRooms.getRoomsByHotelID(hotelRoomsList,getUrlhotelID_int );
    %>           

    <h2 style="margin-inline-start: 1%; margin-bottom:  2%;" id="Rooms"> Odalar</h2>
    <%
    if (!selectedHotelRooms.isEmpty()) {
      for (Map<String, Object> room : selectedHotelRooms) {
    %>
    <div class="accordion accordion-flush" id="accordionFlushExample">
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    <strong><%= room.get("hotel_room_name") %></strong>  
                </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                <div class="accordion-body">
                    <div class="card mb-3" style="max-width: auto;">
                        <div class="row g-0">
                            <div class="col-md-4">
                                <img src="<%=room.get("hotel_rooms_img_url")%>" class="img-fluid rounded-start" alt="...">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title"><%= room.get("hotel_room_name") %></h5>
                                    <p class="card-text"> <%= room.get("room_description") %></p>
                                    <div style="    margin-block-start: 10%;  margin-bottom: 2%;">
                                        <p class="card-text"><strong>Kişi Başı Tek gecelik konaklama Fiyatı: <%= room.get("room_price") %>TL</strong></p>
                                        <p class="card-text" style="color: #ff0018">Max Kişi Kapasitesi: <%= room.get("max_person_capacity")%></p>
                                    </div>
                                    <!--<a href="otel_page_reservation.jsp?hotel_roomsID=<%=room.get("hotel_roomsID")%>" class="btn btn-success">Rezervasyon Yap</a>-->
                                    <form id="reservationForm" action="otel_page_reservation.jsp" method="POST">
                                        <input type="hidden" name="hotel_room_type" value="<%= room.get("Room_Type_room_typeID") %>">
                                            <input type="hidden" name="max_person_capacity" value="<%= room.get("max_person_capacity") %>">
                                                <input type="hidden" name="hotel_name" value="<%=getUrlhotelName%>">
                                                    <button type="submit" class="btn btn-success">Rezervasyon Yap</button>
                                                    </form>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
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
