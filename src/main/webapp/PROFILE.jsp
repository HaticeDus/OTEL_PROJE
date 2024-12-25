<%-- 
    Document   : PROFILE
    Created on : 12 Ara 2023, 00:34:55
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%@ page import="otel_model_classes.Profil" %>
<%@ page import="otel_model_classes.Hotel" %>
<%--<jsp:useBean id="user" class="otel_model_classes.Customer" scope="session"/>--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profil</title>
</head>
<!--<body style="margin: 0; padding: 0; background-image: url('img/santorini_hotel-wallpaper-1152x768.jpg'); background-size: cover; ">-->
<body>
    <%@ include file="navbar.jsp" %>
<div style='margin: 5%;border-radius: 2%;box-shadow: 1px 3px 7px 0px #6c757d; margin-bottom: 8%;'>

    <div class="row">
        <!----------------LEFT--------------------------->
        <div class="col-sm-6">


            <h3 style=" display: block; text-align: center; margin-block: 5%;">Profilim</h3>
            <hr>
            <div class="container d-flex justify-content-center align-items-center my-5" style="padding:5%; border: 1px solid #dc3545; max-width: 80%; border-radius:2%; box-shadow: 3px 3px 3px 3px #00000030; background-color: #ffffffc2;">

                <form method=POST   action=PROFILE.jsp  style="width: 100%; margin: 5%; " >

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="nameSurname"  name="newNameSurname" value="<%= user.getCustomerNameSurname() %>"  maxlength="70" required>
                            <label for="nameSurname" class="form-label" style="color:#000;">Ad Soyad</label>
                    </div>


                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email"  name="newEmail"  value="<%= user.getCustomerEmail() %>" maxlength="255" required>
                            <label for="email" class="form-label" style="color:#000;">Email</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="tel" class="form-control" id="phone"  name="newTel" value="<%= user.getCustomerTel() %>"   placeholder="5XXXXXXXXX" pattern="[0-9]{10}" maxlength="10" required>
                            <label for="phone" class="form-label" style="color:#000;">Telefon</label>
                    </div>

                    <div class="form-floating mb-3">
                        <textarea class="form-control" id="address"  name="newAddress" rows="3" placeholder=" " required><%= user.getCustomerAdress() %></textarea>
                        <label for="address" class="form-label" style="color:#000;">Adres</label>
                    </div>

                    <div class="form-floating mb-3 d-flex justify-content-center">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="newGender" id="inlineRadio1" value="Kadın" <% if (user.getGender() != null && user.getGender().equals("Kadın")) { %>checked<% } %> required>

                                <label class="form-check-label" for="inlineRadio1">Kadın</label>
                        </div>
                        <div class="form-check form-check-inline" style="margin-left: 25px">
                            <input class="form-check-input" type="radio" name="newGender" id="inlineRadio2" value="Erkek" <% if (user.getGender() != null && user.getGender().equals("Erkek")) { %>checked<% } %> required>
                                <label class="form-check-label" for="inlineRadio2">Erkek</label>
                        </div>
                    </div>

                    <div class="form-floating mb-3"> 
                        <label for="dob" class="form-label" style="color:#000; margin-top: -2%">Doğum Yılı</label>
                        <select class="form-select"   id="dob" name="newDateOfBirth" required>
                            <option  value="<%= user.getDateOfBirth() %>"  selected><%= user.getDateOfBirth() %></option>
                            <% 
                                int currentYear = java.time.Year.now().getValue(); // Şu anki yıl
                                for (int year = 1943; year <= currentYear; year++) { %>
                            <option value="<%= year %>"><%= year %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-success">Güncelle</button>
                    </div>

                </form>
            </div>

            <%
            // Kullanıcının güncel bilgilerini al
            String newNameSurname = request.getParameter("newNameSurname");
            String newEmail = request.getParameter("newEmail");
            String newTel = request.getParameter("newTel");
            String newAddress = request.getParameter("newAddress");
            String newGender = request.getParameter("newGender");
            String newDateOfBirth = request.getParameter("newDateOfBirth");

            // Profil sınıfı üzerinden güncelleme işlemi yap
            Profil profil = new Profil();
    // if (request.getMethod().equalsIgnoreCase("POST")) { // Form submit edilmiş mi kontrolü
            
//     if((newNameSurname!=null &&newNameSurname.isEmpty())&& 
//     (newEmail!=null &&newEmail.isEmpty())&&
//     (newTel!=null &&newTel.isEmpty())&&
//     (newAddress!=null &&newAddress.isEmpty())&&
//     (newGender!=null &&newGender.isEmpty())&&
//     (newDateOfBirth!=null &&newDateOfBirth.isEmpty()))
//     {
         
     boolean updated = profil.updateCustomer(user.getCustomerID(), newNameSurname, newEmail, newTel, newAddress, newGender, newDateOfBirth);
   
            if (updated) 
            {
            %>

            <div class="toast-container top-0 end-0 p-3">
                <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style="font-size: large;">
                    <div class="toast-header" style="background-color: #66d96f;">
                        Başarılı
                        <button type="button" style="margin-inline-start: auto;" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">
                        Profil bilgileri başarıyla güncellendi!
                    </div>
                </div>
            </div>

            <%
                              //yeni girilenleri set et
                               user.setCustomerNameSurname(newNameSurname);
                               user.setCustomerEmail(newEmail);
                               user.setCustomerTel(newTel);
                               user.setCustomerAdress(newAddress);
                               user.setGender(newGender);
                               user.setDateOfBirth(newDateOfBirth);
       
                   
            }     else {
               // out.println("Bilgileri güncelleme sırasında bir hata oluştu.");
            %>

            <div class="toast-container top-0 end-0 p-3">
                <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style="font-size: large;">
                    <div class="toast-header" style="background-color: #ff2323;">
                        <strong class="me-auto">Hata</strong>  
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body" style="background-color: white;">
                        Bilgileri güncelleme sırasında bir hata oluştu.
                    </div>
                </div>
            </div>
            <%}
//} // IF
//} //POST IF
            %>
        </div>




        <!----------------RIGHT--------------------------->
        <div class="col-sm-6">
            <h3 style="display: block; text-align: center;  margin-block: 5%;">Rezervasyonlarım</h3>
            <hr>

            <%
                Hotel hotel =new Hotel();
                List<Map<String, Object>>hotelList=hotel.getAllHotels();
            %>

            <%
               int hotelID=0;
             List<Map<String, Object>> reservationList = profil.getReservationsByCustomerId(user.getCustomerID()); 
             
                if(reservationList!=null && !reservationList.isEmpty() )
                {
                   for (Map<String, Object> reservationData : reservationList) 
                   {
                     hotelID = (int) reservationData.get("Hotel_hotelID");
            %>
            <div class="container d-flex justify-content-center align-items-center my-5">
                <div class="card border-info mb-3 text-center"  style="max-width: 100%; margin-top: 1%;padding: 3%; box-shadow: 3px 3px 3px 3px #00000030; background-color: #ffffffc2;">
                    <div class="card-header">Rezervasyon Bilgileri</div>
                    <div class="card-body">
                        <ul class="list-group">
                            <li class="list-group-item"><strong>Rezervasyonun oluşturulma zamanı:</strong> <%= reservationData.get("reservation_date") %></li>
                            <li class="list-group-item"><strong>Check-in Tarihi:</strong> <%= reservationData.get("check_in_date") %></li>
                            <li class="list-group-item"><strong>Check-out Tarihi:</strong> <%= reservationData.get("check_out_date") %></li>
                            <li class="list-group-item"><strong>Yetişkin Sayısı:</strong> <%= reservationData.get("adult_count") %></li>
                            <li class="list-group-item"><strong>Çocuk Sayısı:</strong> <%= reservationData.get("child_count") %></li>
                            <li class="list-group-item"><strong>Tutar:</strong> <%= reservationData.get("total_price") %> TL</li>
                        </ul>
                        <%         
                          if(hotelList!=null && !hotelList.isEmpty() )
                            {
                                for(Map<String, Object> hotelData: hotelList)
                                {     
                                     int currentHotelID = (int) hotelData.get("hotelID");
                                  if (currentHotelID == hotelID){
                        %>
                        <div class="card border-warning mb-3" style="max-width: 100%;margin-top: 5%;">
                            <div class="card-header">Rezervasyon Yapılan Otelin Bilgileri</div>
                            <div class="card-body">
                                <ul class="list-group">
                                    <li class="list-group-item"><strong>Otel Adı:</strong> <%= hotelData.get("hotel_name") %></li>
                                    <li class="list-group-item"><strong>Adresi:</strong> <%= hotelData.get("hotel_adress") %></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                   }
                  }
               }else{
                       out.println("hotelList Boş!");
                      }
                  }
                }
              else{
            %>
            <div class="card border-warning mb-3" style="max-width: 90%;">
                <h4 class="card-body">Rezarvasyon Kaydınız Bulunmamaktadır.</h4>
            </div>
            <%}%>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
