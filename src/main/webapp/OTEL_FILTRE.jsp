<%-- 
    Document   : OTEL_FILTRE
    Created on : 15 Ara 2023, 20:29:14
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="otel_model_classes.AllHotelsAndAllRooms" %>
<%@ page import="otel_model_classes.HotelMergeCity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashSet" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> <!--user_session 2.session nesnesi oturum boyunca bilgileri kaydediyor-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Oteller ve Odalar</title>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <%
          //FORMDAN GELEN VERİLERİ SESSİONA KAYDET
         String roomNumber = request.getParameter("room_number");
            int roomNumberInt=0;
        if (roomNumber != null && !roomNumber.isEmpty()) 
                 {
                    roomNumberInt = Integer.parseInt(roomNumber);
                   user_session.setRoomNumber(roomNumberInt);
                }     
             //---------------------------------------------------------
                 
          String selectedCity = request.getParameter("selectedCity");
          if (selectedCity != null && !selectedCity.isEmpty()) 
            {
               int cityID = Integer.parseInt(selectedCity);
               user_session.setSelectedCityID(cityID);
            }
          HotelMergeCity hotelMergeCity = new HotelMergeCity();
         String cityName = hotelMergeCity.getCityNameByID(selectedCity); //şehir ismini aldım
       //-----------------------------------------------------------
     
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
        
        if(differenceInDays>30 ){
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
    }
    %>

    <!-------------------------------------------------------------------------------------------------------------------------------------------->
<div class="container" >
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card border-warning mb-3 mx-auto" style="width: 100%; margin:1%;">
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

<div style='margin: 2%;border: 1px solid #20c997;padding: 1%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3); margin-bottom: 20%;'>
    <h2><%=cityName%> için Uygun Odalar ve Oteller</h2>

    <%
          AllHotelsAndAllRooms hotelData = new AllHotelsAndAllRooms();
            List<Map<String, Object>> filteredRoomsList = hotelData.getFilteredRooms(roomNumberInt,selectedCity, checkInDate, checkOutDate);
             Object lastHotelID = null;// otel kontrol
    %>


    <%if (filteredRoomsList != null && !filteredRoomsList.isEmpty()) {  %>


    <% 
    HashSet<Object> displayedHotels = new HashSet<>();
    for (Map<String, Object> rooms : filteredRoomsList) {
        Object hotelID = rooms.get("Hotel_hotelID");
        if (!displayedHotels.contains(hotelID)) {
            displayedHotels.add(hotelID);

    %>
    <div class="card mb-3" style="max-width: 540px;">
        <div class="row g-0">
            <div class="col-md-6">
                <img src="<%=rooms.get("hotel_image")%>" class="img-fluid rounded-start" alt="...">
            </div>
            <div class="col-md-6">

                <form action="OTEL_PAGE_FILTRE.jsp" method="post">
                    <input type="hidden" name="hotelID" value="<%= rooms.get("Hotel_hotelID") %>">
                        <input type="hidden" name="hotel" value="<%= rooms.get("hotel_name") %>">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="submit" class="btn btn-outline-success" style="width: 100%; margin: 3%; margin-block-start: 25%;">
                                   <!--<a href="OTEL_PAGE_FILTRE.jsp?hotelID=<%= rooms.get("Hotel_hotelID") %>&hotel=<%= rooms.get("hotel_name") %>" class="col" style="flex: 0 0 auto; margin: 3px;">-->
                                    <!--<div class="card-body">-->
                                    <%=rooms.get("hotel_name")%>
                                    <!--<h5 class="card-title"></h5>-->
                                    <!--</div>-->
                                    <!--</a>-->
                                </button>
                            </div>
                            </form>



                            </div>
                            </div>
                            </div>

                            <% }
}%>
                            <% }else { %>
                            <div class="card text-bg-danger mb-3" style="max-width: 100%;">
                                <h4 class="card-body">Maalesef, Uygun oda bulunamadı!</h4>
                            </div>
                            <% } %>


                            </div>
                            <%@ include file="footer.jsp" %>
                            </body>
                            </html>
