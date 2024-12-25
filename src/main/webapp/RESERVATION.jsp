<%-- 
    Document   : RESERVATION
    Created on : 9 Ara 2023, 15:47:19
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page language="java" isErrorPage="true" %>
<%@page import="otel_model_classes.AllHotelsAndAllRooms" %>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Form Sayfası</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function getSelectedChildCount(childCount, roomCount) {
                const j = parseInt(roomCount);
                const childYearDiv = document.getElementById(`childYearDiv`);
                const inputElement = document.querySelector('input[name="children_year_' + j + '"]');
                const intChildCount = parseInt(childCount);

                if (intChildCount === 0) {
                    childYearDiv.style.display = "none";
                    inputElement.setAttribute("disabled", true);
                } else {
                    childYearDiv.style.display = "block";
                    inputElement.removeAttribute("disabled");
                    const j = parseInt(roomCount);
                    updatePattern(intChildCount, j);
                }
            }
//-----------------------------------------------------------------------------------------------------------------------
            function updatePattern(childCount, roomCount) {
                const intChildCount = parseInt(childCount);
                const j = parseInt(roomCount);
                const inputElement = document.querySelector('input[name="children_year_' + j + '"]');

                for (let i = 1; i <= intChildCount; i++) {
                    if (inputElement !== null) {
                        const pattern = '([0-9]{4}-){' + (i - 1) + '}[0-9]{4}';
                        inputElement.setAttribute('pattern', pattern);
                    } else {
                        console.error('Input element not found for ' + i);
                    }
                }
            }
//----------------------------------------------------------------------------------------------------------------------
        </script>
    </head>
    <body  class="p-0 m-0 border-0 bd-example m-0 border-0">
        <%@ include file="navbar.jsp" %>
    <div style='margin: 2%;border: 1px solid #20c997;padding: 2%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3);  margin-bottom: 5%;'>


        <div class="row">
            <!----------------LEFT--------------------------->
            <div class="col-md-6">
                <%
                 //SESSION'DAN BİLGİLERİ AL
                int room_number= (int) user_session.getRoomNumber(); 
                String check_in_date= user_session.getCheck_in_date();
                String check_out_date=user_session. getCheck_out_date();
                //URL'DEN BİLGİLERİ AL
              String room_type = request.getParameter("hotel_room_type");
              int hotelRoomtype= (room_type != null && !room_type.isEmpty()) ? Integer.parseInt(room_type) : 0;
              user_session.setHotel_room_type(hotelRoomtype); //SESSİONA URL'DEN GELEN ODA TYPE KAYDETTİM
              String max_person_capacityStr = request.getParameter("max_person_capacity");
              int maxPersonCapacity = (max_person_capacityStr != null && !max_person_capacityStr.isEmpty()) ? Integer.parseInt(max_person_capacityStr) : 0;
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
                <hr>
                <form action="RESERVATION_1.jsp" method="POST" id="reservationForm"  style="border: 1px solid #ccc; box-shadow: 2px 2px 5px #aaa; padding: 20px;">
                    <% for (int j = 1; j <= room_number; j++) { %>
                    <div class="row justify-content-center text-center">
                        <h5 class="pt-4 pb-2">Oda <%=j%></h5>
                        <div class="col">
                            <div class="mb-3 align-items-center">
                                <h6 class="pt-4 pb-2">Kişi Sayısı Seç</h6>
                                <select class="form-select" aria-label="Default select example" name="person_number_<%= j %>" required>
                                    <option selected disabled value="">Kişi Sayısı</option>
                                    <% for (int i = 1; i <= maxPersonCapacity; i++) { %>
                                    <option value="<%=i%>"><%=i%></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3 ">
                                <h6 class="pt-4 pb-2">Çocuk Sayısı Seç</h6>
                                <select class="form-select" aria-label="Default select example" name="child_number_<%= j %>" onchange="getSelectedChildCount(this.value,<%= j %>)" required>
                                    <option selected disabled value="">Çocuk Sayısı</option>
                                    <% for (int k = 0; k <= 4; k++) { %>
                                    <option value="<%=k%>"><%=k%></option>
                                    <% } %>
                                </select>
                                <span style="font-size: 12px; color: red">Çocuk sayılabilmesi için 13 yaşından küçük olmalı! </span>
                            </div>
                        </div>
                    </div>      
                    <!--VARSA ÇOCUKLARIN YAŞI-->
                    <div class="col" id="childYearDiv">
                        <div class="mb-3">
                            <button class="btn btn-outline-danger" id="liveAlertBtn" type="button" style="margin-bottom: 5%; width:100%" aria-expanded="false">
                                <span style="font-size: 14px;"> Çocukların doğum yıllarını aralarında "-" olacak şekilde sırasıyla giriniz</span>
                            </button>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" name="children_year_<%= j %>" placeholder="2012-2016-2015" required>
                                    <div class="invalid-feedback">Lütfen doğru formatı kullanın.</div>
                            </div>
                        </div>
                    </div>

                    <hr>
                    <% } %>
                    <input type="submit"  class="btn btn-outline-danger" style="width: 100%;" value="Bilgilerimi Kaydet">
                </form>
            </div>   

            <!----------------RIGHT--------------------------->
            <!--ODA BİLGİLERİ GELSİN-->
            <%
          int selectedCity_int= (int) user_session.getSelectedCityID();
          String selectedCity = String.valueOf(selectedCity_int);
      
          AllHotelsAndAllRooms hotelData = new AllHotelsAndAllRooms();
          List<Map<String, Object>> filteredRoomsList = hotelData.getFilteredRooms(user_session.getRoomNumber(),selectedCity, check_in_date, check_out_date);
            %>
            <div class="col-md-6">
                <div class="row justify-content-center">
                    <div class="col-md-12">
                        <div class="card border-warning mb-3 mx-auto" style="width: 80%; margin: 1%;">
                            <div class="card-header">Seçtiğiniz Oda</div>
                            <div class="card-body">
                                <% if (filteredRoomsList != null && !filteredRoomsList.isEmpty()) { 
                                   HashSet<Object> controlRoomTypes = new HashSet<>(); // aynı oda türünden 1 tane dönsün
                                %>
                                <% for (Map<String, Object> rooms : filteredRoomsList) { %>
                                <% Object hotelRoomType = rooms.get("Room_Type_room_typeID"); %>
                                <% if (!controlRoomTypes.contains(rooms.get("Room_Type_room_typeID")) && hotelRoomType.equals(hotelRoomtype)) { 
                                       controlRoomTypes.add(rooms.get("Room_Type_room_typeID")); 
                                %>
                                <div class="row g-0">
                                    <div class="col-md-2">
                                        <img src="<%= rooms.get("hotel_image") %>" class="img-fluid rounded-start" alt="Room Image">
                                    </div>
                                    <div class="col-md-10">
                                        <div class="card-body">
                                            <h5 class="card-title"><%= rooms.get("hotel_name") %></h5>
                                            <%
                                                    int hotelID = Integer.parseInt(rooms.get("Hotel_hotelID").toString());
                                                    user_session.setHotelID(hotelID); //SESSİONA KAYDETTİM
                                            %>
                                            <div style="margin-block-start: 1%; margin-bottom: 2%;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-center">
                                    <div class="card" style="width: 100%;">
                                        <div class="card-body">
                                            <h5 class="card-title"><%= rooms.get("hotel_room_name") %></h5>
                                        </div>
                                        <img src="<%= rooms.get("hotel_rooms_img_url") %>" class="card-img-top" alt="...">
                                            <br>
                                            <h5>Kişi Başı Tek Gecelik Konaklama Fiyatı: <%= rooms.get("room_price") %>TL</h5>
                                            <%
                                                  double roomPrice = ((Number) rooms.get("room_price")).doubleValue();
                                                  user_session.setRoom_price(roomPrice); //SESSİONA KAYDETTİM
                                            %>
                                    </div>
                                </div>
                                <% } %>
                                <% } %>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>

