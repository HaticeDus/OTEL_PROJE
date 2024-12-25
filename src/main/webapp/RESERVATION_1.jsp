<%-- 
    Document   : RESERVATION_1
    Created on : 17 Ara 2023, 02:58:41
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.time.LocalDate" %>
<%@page import="java.time.Period"%>
<%@ page import="java.time.Year" %>
<%@page import="otel_model_classes.AllHotelsAndAllRooms" %>

<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
        <title>Tutar Sayfası</title>
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
    <div style='margin: 2%;border: 1px solid #20c997;padding: 2%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3);  margin-bottom: 10%;'>
        <%
                             
                                        AllHotelsAndAllRooms hotelData = new AllHotelsAndAllRooms();
                                        List<Map<String, Object>> roomList = hotelData.getRoomsByAvailabilityAndCount(user_session.getSelectedCityID(),user_session.getCheck_in_date(), user_session.getCheck_out_date(), user_session.getRoomNumber());
                            
                                         String allRoomIDs=" ";
                                  
                                         for (Map<String, Object> room : roomList) 
                                         {                     
                                            //out.println("Room Type ID: " + room.get("Room_Type_room_typeID") + "<br>");
                                            //out.println("Hotel ID: " + room.get("Hotel_hotelID") + "<br>");
                                            //out.println("Room Count: " + room.get("room_count") + "<br>");
                                            allRoomIDs=room.get("all_hotel_roomsIDs").toString();
                                           // out.println("All Hotel Room IDs: " + room.get("all_hotel_roomsIDs") + "<br>");
                                            //out.println(allRoomIDs);
                                          }
                                   
                                          String[] roomIDsArray = allRoomIDs.split(",");
                                              for (String roomID : roomIDsArray) 
                                              {
                                                 // out.println("Room ID: " + roomID + "<br>");
                                              }
        %>

        <%
              int currentYear = Year.now().getValue(); // Şu anki yılı al
             //SESSION'DAN BİLGİLERİ AL
                int room_number= (int) user_session.getRoomNumber(); 
                String check_in_date= user_session.getCheck_in_date();
                String check_out_date=user_session. getCheck_out_date();
                //--------------------------------------------------------------------------------
                double Total = 0.0;
                double totalPrices = 0.0;
                 String[] roomPriceArray = new String[room_number]; //oda sayısı kadar dönecek 
                 int k=0;
                 //---------------------------------------------------------------------------------           
                             
               List<Map<String, String>> roomCustomerInfoList = new ArrayList<>();
               
               LocalDate currentDate = LocalDate.now();
           
            for (int j = 1; j <= room_number; j++) {
        
                String personNumber = request.getParameter("person_number_" + j);
                String childNumber = request.getParameter("child_number_" + j);
               String childrenYearParam = request.getParameter("children_year_" + j);
              String[] childrenDOB = new String[0]; 
              
              if (childrenYearParam != null) {
               childrenDOB = childrenYearParam.split("-");
            } else {
//               request.setAttribute("errorMessage", "Hata : Çocuk Doğum Yılları Bulunamadı");
//                request.getRequestDispatcher("/ERROR_PAGE_AGE.jsp").forward(request, response);
            }

//---------------------------------------ÇOCUK YIL LİSTE------------------------------------------------------------------------------------------------------------                
                 if (childrenDOB != null) {
                      for (String dob : childrenDOB) {
                       try {
                               int childYear = Integer.parseInt(dob);
                                int yearDifference = currentYear - childYear;
                if (yearDifference > 12 || yearDifference< 0) {
                    request.setAttribute("errorMessage", "Hata: Girilen Yıl: " + dob + " <br> Çocuk yaşı 0 ile 12 arasında olmalıdır.");
                    // Hata oluştuğunda bir attribute ("errorMessage") ayarla
                    request.getRequestDispatcher("/ERROR_PAGE_AGE.jsp").forward(request, response);
                    // Hata sayfasına yönlendir
                  
                }
            } catch (NumberFormatException e) {
//                request.setAttribute("errorMessage", "Hata : Geçersiz tarih formatı " + dob);
//                request.getRequestDispatcher("/ERROR_PAGE_AGE.jsp").forward(request, response);
            }
        }
    }
// ------------------------------------------------------------------------------------------------------------------------------------------------------
                Map<String, String> roomCustomerInfoMap = new HashMap<>();
                roomCustomerInfoMap.put("checkInDate", user_session.getCheck_in_date());
                roomCustomerInfoMap.put("checkOutDate", user_session. getCheck_out_date());
                roomCustomerInfoMap.put("room_number", String.valueOf(j));
                roomCustomerInfoMap.put("person_number", personNumber);
                roomCustomerInfoMap.put("child_number", childNumber); // her oda için çocuk sayısı
               // roomCustomerInfoMap.put("totalPrice", room_priceArray[j-1]); // tek tek oda fiyatları // BUNU PAYMENTDA AL NULL HATASI VERİYOR
                roomCustomerInfoMap.put("roomID", roomIDsArray[j-1]); // room ID leri kaydettim sessiona 
                for(int i=0; i<childrenDOB.length; i++)
                     {
                             roomCustomerInfoMap.put("child_year_"+(i+1), childrenDOB[i]);
                      }
                roomCustomerInfoList.add(roomCustomerInfoMap); //listeye ekledik formdan alınan bilgileri
            } 
          
          user_session.setRoomDetailsList(roomCustomerInfoList); //useBean ile SESSION'a kaydettim
      
    //    SESSİON'DAN BU LİSTEYİ AL
      List<Map<String, String>> roomDetailsList = (List<Map<String, String>>) user_session.getRoomDetailsList();
        %>

        <div class="row">
            <!----------------LEFT--------------------------->
            <div class="col-md-6">
                <div class="row justify-content-center">
                    <div class="col-md-12">
                        <div class="card border-warning mb-3 mx-auto" style="width: 100%; margin:1%;">
                            <div class="card-header">Seçiminiz</div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <h6 class="card-text">Seçilen Oda Sayısı:  <%= room_number %></h6>
                                    <h6 class="card-text">Giriş Tarihi: <%=check_in_date%></h6>
                                    <h6 class="card-text">Çıkış Tarihi: <%= check_out_date %></h6>
                                    <h6 class="card-text">Gün Sayısı:  <%= user_session.getDay() %></h6>
                                </div>
                            </div>
                        </div>
                        <div class="card border-info mb-3 mx-auto" style="width: 100%; margin:1%;">
                            <div class="card-header">Oda'da kalacak Kişi Bilgileriniz</div>
                            <div class="card-body">

                                <%
                                     if (roomDetailsList != null) 
                                     {
                                       for (Map<String, String> roomDetails : roomDetailsList) 
                                        {
                                %>
                                <h6 class="card-text">Oda <%=  roomDetails.get("room_number") %> :</h6><hr>
                                <h6 class="card-text">Seçilen Yetişkin Sayısı: <strong><%=  roomDetails.get("person_number") %></strong></h6>
                                <h6 class="card-text">Seçilen Çocuk Sayısı: <strong><%=roomDetails.get("child_number") %></strong></h6>
                                <!--COCUK INFO  LİSTESİ-->
                                <%
                                       int childYearInt=0;
                                        int age =0;
                                      if (roomDetails.containsKey("child_number") && roomDetails.get("child_number") != null) 
                                      {
                                            int childCount = Integer.parseInt(roomDetails.get("child_number"));
                                            for (int i = 1; i <= childCount; i++) 
                                            {
                                              String childYear = roomDetails.get("child_year_" + i);
                                               if (childYear != null && !childYear.isEmpty()) 
                                               {
                                               childYearInt = Integer.parseInt(childYear);
                                               age = currentDate.getYear() - childYearInt;
                                               }
                                %>
                                <h6 class="card-text"><%=i%>. Çocuk Doğum Tarihi: <%=childYear %>, <strong>Yaşı: <%=age %></strong></h6>
                                <%
                                           }
                                       }
                                         out.println("<br>");
                                    }
                                  }
                                 else 
                                   {
                                           out.println("Lütfen Oda'da konaklayabilmeniz için Bilgilerinizi Girin!.");
                                   }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!----------------RIGHT--------------------------->
            <div class="col-md-6">
                <div class="row justify-content-center">
                    <div class="col-md-12">

                        <div class="card border-danger mb-3 mx-auto" style="width: 100%; margin:1%;">
                            <div class="card-header">Hesaplanan Fiyat</div>
                            <div class="card-body ">
                                <p class="card-text">Seçtiğiniz Oda için,<strong> Kişi Başı Tek gecelik konaklama Fiyatı: <%= user_session.getRoom_price() %>TL</strong></p>
                                <p class="card-text" style="color: red">
                                <i class="bi bi-exclamation-triangle-fill text-warning"></i>
                                0-6 yaş ücretsiz, 6-12 yaş için oda fiyatı üzerinden %50 çocuk indirimi uygulanır.
                                </p>
                                <hr>
                                <%
                                //-------------------ERKEN REZERVASYON İNDİRİMİ------------------------------------------
                                
                                  LocalDate current_date = LocalDate.now(); // Şu anki tarih
                                  LocalDate checkInDate = LocalDate.parse(check_in_date); // Örnek olarak 22 Mayıs 2024 tarihi

                                  Period period = Period.between(current_date, checkInDate); // Farkı hesapla
                                  int ayFarki = period.getMonths(); // Ay farkını al
                                  double indirimOrani=1;
                                 //out.println("Mevcut tarih ile check_in_date arasındaki ay farkı: " + ayFarki);
                                  if(ayFarki!=0){
                                  indirimOrani = (100 - ayFarki) / 100.0;
                                %>

                                <p class="card-text" style="color: blue">
                                <i class="bi bi-exclamation-triangle-fill text-warning"></i>
                                Her Oda Fiyatı Üzerinden Erken Rezervasyon İndiriminiz:  <strong>%<%=ayFarki%></strong>
                                </p>

                                <%
                                    }
                                %>
                                <hr>
                                <%
                              int childYearInt=0;
                              int age=0;
                              
                              if (roomDetailsList != null) 
                              {
                                for (Map<String, String> roomDetails2 : roomDetailsList) // oda sayısı kadar dönecek 
                                 {
                                 double personPrices = 0.0;
                                 String personNumberStr = roomDetails2.get("person_number");
                                   if (personNumberStr != null && !personNumberStr.isEmpty()) 
                                   {
                                        int person_number = Integer.parseInt(personNumberStr);
                                        personPrices = person_number * user_session.getRoom_price();
                                   }
                                %>
                                <h6 class="card-text">Oda <%=  roomDetails2.get("room_number") %> :</h6><hr>

                                <%
                                    double totalChildPrice = 0.0; // Her oda için Toplam çocuk fiyatını tutacak 
                                      if (roomDetails2.containsKey("child_number") && roomDetails2.get("child_number") != null) 
                                      {
                                            int childCount = Integer.parseInt(roomDetails2.get("child_number"));
                                            for (int i = 1; i <= childCount; i++) 
                                            {
                                              String childYear = roomDetails2.get("child_year_" + i);
                                             if (childYear != null && !childYear.isEmpty()) 
                                             {
                                                    childYearInt = Integer.parseInt(childYear);
                                                     age = currentDate.getYear() - childYearInt;
                                             }
                                              
                                              
                                              
                                              if (age >= 6 && age < 12)// Yaş aralığı 6 ile 12 arasında ise %50 indirim yap
                                   {
                                      double roomPrice = user_session.getRoom_price();
                                      double childPrice = roomPrice * 0.5; // %50 indirim
                                       totalChildPrice += childPrice;
                                %>
                                <h6 class="card-text"><%=i%>.Çocuk Yaşı<strong>: <%=age %></strong> için Fiyat: <span style="color: red"><%=childPrice%> TL</span></h6>
                                <%
                                      
                                   } 
                                  else if (age < 6)  // Yaş 6'dan küçükse ücretsiz
                                   {
                                %>
                                <h6 class="card-text"><%=i%>.Çocuk Yaşı<strong>: <%=age %></strong> için <span style="color: red">Ücretsiz</span></h6> 
                                <%
                                   }
                          }
                  }
                                    totalPrices=(totalChildPrice+personPrices)*user_session.getDay()*indirimOrani; //tek oda için
                                     roomPriceArray[k] = String.valueOf(totalPrices); //oda fiyatlarını tek tek diziye atadım
                                     k++;
                                    Total+=totalPrices;
                                    user_session.setTotalPrice(Total);//SESSIONA KAYDET
                                    user_session.setRoomPriceArray(roomPriceArray); //SESSIONA KAYDETTİM
                                %>
                                <br><h6 class="card-text"><strong><%=roomDetails2.get("child_number")%> </strong>Adet Çocuk için Tek Gecelik Konaklama Fiyatı: <span style="color: red"><%=totalChildPrice%> TL</span></h6>
                                <h6 class="card-text"> <strong><%=  roomDetails2.get("person_number") %></strong> Adet Yetişkin için Tek Gecelik Konaklama Fiyatı: <span style="color: red"><%=personPrices%> TL</span>  </h6><br>
                                <h6 class="card-text"> Oda <%=  roomDetails2.get("room_number") %> için <strong><%=user_session.getDay()%> Gecelik Toplam Konaklama Fiyatı: <span style="color: red"><%=totalPrices%> TL</span> </strong> </h6><br><br>
                                <%
                                   
                                    }
                                %>
                                <h4 class="card-text"><%=user_session.getDay()%> Gecelik Toplam Tutar: <strong><%=Total%> TL</strong></h4>
                                <%
                                   }
                                  else 
                                    {
                                            out.println("Lütfen Oda'da konaklayabilmeniz için Bilgilerinizi Girin!.");
                                    }
                                %>
                            </div>
                            <a class="btn btn-outline-danger" href="PAYMENT.jsp" role="button" style="margin: 5%">Rezervasyonu Yap</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
