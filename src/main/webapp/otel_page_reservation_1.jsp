<%-- 
    Document   : otel_page_reservation_1
    Created on : 23 Ara 2023, 22:20:10
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashSet" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="otel_model_classes.AllHotelsAndAllRooms" %>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> <!--user_session 2.session nesnesi oturum boyunca bilgileri kaydediyor-->

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

    <!--<body style="margin: 0; padding: 0; background-image: url('img/hotel_room_2-wallpaper-1920x1080.jpg'); background-size: cover;">-->
    <body>
        <%@ include file="navbar.jsp" %>
        <%
               //FORMDAN GELEN VERİLERİ SESSİONA KAYDET
           
               String all_hotel_roomsIDs=" ";
               String max_person_capacityStr = request.getParameter("max_person_capacity");
               int maxPersonCapacity = (max_person_capacityStr != null && !max_person_capacityStr.isEmpty()) ? Integer.parseInt(max_person_capacityStr) : 0;
              // ----------------------------------------------------------------------------    
              String roomNumber = request.getParameter("room_number");
                int roomNumberInt=0;
                if (roomNumber != null && !roomNumber.isEmpty()) 
                  {
                        roomNumberInt = Integer.parseInt(roomNumber);
                       user_session.setRoomNumber(roomNumberInt);
                   }     
    
           String checkInDate = request.getParameter("check_in_date");
           String checkOutDate = request.getParameter("check_out_date");
        
        if (checkInDate != null && checkOutDate != null) {
    
           user_session.setCheck_in_date(checkInDate); 
           user_session.setCheck_out_date(checkOutDate); 
            // Tarihleri java.util.Date nesnelerine dönüştür
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn_Date = sdf.parse(checkInDate);
            Date checkOut_Date = sdf.parse(checkOutDate);

            // Tarih farkını hesapla
            long differenceInMillies = checkOut_Date.getTime() - checkIn_Date.getTime();
            long differenceInDays = differenceInMillies / (1000 * 60 * 60 * 24); //gün farkı
       
            int differenceInDaysInt = (int) differenceInDays; 
            user_session.setDay(differenceInDaysInt); //SESSIONA KAYDETTİM
        
            if(differenceInDays>30){
         
               request.setAttribute("errorMessage", "Hata: Gün sayısı 30 dan az olmalıdır!!");
               request.getRequestDispatcher("/ERROR_PAGE_AGE.jsp").forward(request, response);

        %>
        <!--<div class="toast-container top-0 end-0 p-3">
            <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style=" font-size: large;">
                <div class="toast-header" style="    background-color: #ff0018; color: wheat ">
                    Gün sayısı 30 dan az olmalıdır!
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>-->
        <%}else if(differenceInDays<0){
                  request.setAttribute("errorMessage", "Hata: Lütfen Giriş ve Çıkış Tarihlerinizi Kontrol ediniz!");
                   request.getRequestDispatcher("/ERROR_PAGE_AGE.jsp").forward(request, response);
             } 
        }%>

        <!-------------------------------------------------------------------------------------------------------------------------------------------->

    <div style='margin: 2% 15%;  padding: 2%; border-radius: 2%; box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3); margin-bottom: 20%; background-color: #ffffffd1;;'>

        <div class="container" >
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card border-warning mb-3 mx-auto" style="width: 100%; margin:3%;">
                        <div class="card-header">Seçiminiz:</div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h6 class="card-text">Seçilen Oda Sayısı:  <%= roomNumber %></h6>
                                <h6 class="card-text">Giriş Tarihi: <%= checkInDate %></h6>
                                <h6 class="card-text">Çıkış Tarihi: <%= checkOutDate %></h6>
                                <h6 class="card-text">Gün Sayısı:  <%= user_session.getDay() %></h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%

         AllHotelsAndAllRooms hotelData = new AllHotelsAndAllRooms();
         List<Map<String, Object>> controlRoomList = hotelData.controlHotelRoomsData(user_session.getHotelID(),  user_session.getHotel_room_type(), checkInDate, checkOutDate);
     
       if(controlRoomList!=null && !controlRoomList.isEmpty()){
            for(Map<String, Object>room : controlRoomList){
              int room_count= (int) room.get("room_count");
              //user_session.setRoomNumber(room_count); //SESİONA KAYDETTİM
              all_hotel_roomsIDs= (String) room.get("all_hotel_roomsIDs");
              user_session.setHotel_roomsID(all_hotel_roomsIDs); //SESSIONA KAYDETTİM 
              if(room_count>=roomNumberInt){%>
        <div class="card text-bg-success mb-3 " style="margin: 0% 25%; max-width: 50%; text-align: center">
            <h5 class="card-body" >İstenilen Tarihler Arasında Oda Mevcut </h5>
        </div>

        <!-----------------------------------------Kişi Bilgilerini Al FORM-------------------------------------------------------------------------->

        <form action="otel_page_reservation_2.jsp" method="POST" id="reservationForm"  style="margin: auto 25%; width: 50%;border: 1px solid #ccc; box-shadow: 2px 2px 5px #aaa; padding: 20px;">
            <% for (int j = 1; j <= roomNumberInt; j++) { %>
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

        <%} else{ %>
        <div class="card text-bg-danger mb-3" style="max-width: 100%;">
            <h4 class="card-body">Maalesef, Size Uygun Oda Bulunamadı!</h4>
        </div>

        <%}
            }
        } 
    else{ out.println("controlRoomList Boş!"); 
    }  %>

    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
