<%-- 
    Document   : home_carousel
    Created on : 13 Ara 2023, 17:26:11
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="otel_model_classes.HotelMergeImages" %>
<%@ page import="otel_model_classes.HotelMergeCategory"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
            <title>home_carousel</title>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>


            <style>
                /* Bu stil carousel içindeki resimlerin yüksekliğini belirler */
                .carousel-item img {
                    width: 100%;
                    height: 768px;
                    object-fit: cover;
                }
            </style>
            </head>
            <body>
            <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel" style="display: flex; align-items: center; justify-content: center; margin-bottom: 3%; z-index: -3;">
                <div class="carousel-inner" style=" height: fit-content;">
                    
                    <div class="carousel-item  ">
                        <img src=" img/hotel_room_2-wallpaper-1920x1080.jpg"    alt="img02">
                    </div>
                    <div class="carousel-item  ">
                        <img src=" img/banner2.jpg"    alt="img02">
                    </div>

                    <div class="carousel-item ">
                        <img src="img/beautiful_coast-wallpaper-1152x768.jpg"    alt="img1">
                    </div>

                    <div class="carousel-item ">
                        <img src="img/hotel_room-wallpaper-1152x768.jpg"   alt="img3">
                    </div>

                    <div class="carousel-item ">
                        <img src=" img/maldive_islands_resort-wallpaper-1152x768.jpg"   alt="img4">
                    </div>

                    <div class="carousel-item  ">
                        <img src="img/santorini_hotel-wallpaper-1152x768.jpg" alt="img5">
                    </div>
                    <div class="carousel-item " >
                        <img src=" img/swimming_pool_hotel_relax-wallpaper-1152x768.jpg"  alt="img6">
                    </div>

                    <div class="carousel-item " >
                        <img src=" img/water_bungalows_in_maldives_resort-wallpaper-1152x768.jpg"  alt="img6">
                    </div>

                    <div class="carousel-item  ">
                        <img src=" img/luxury_hotel-wallpaper-1152x768.jpg"    alt="img0">
                    </div>
                    
                    <div class="carousel-item active ">
                        <img src=" img/banner3.jpg"    alt="img03">
                    </div>
                </div>
            </div>


            <!--OTEL CATEGORİ CAROSEL PART -->
            <%
             HotelMergeCategory hotelCategory= new HotelMergeCategory(); //class nesnesi
             List<Map<String, Object>> hotelCategoryList=hotelCategory.getAllCategories(); //dönen listeyi atadım
            %>

            <h4 style="margin-inline-start: 5%;  margin-block-start: 5%;" id="CategoryPart">Kategoriler</h4>

            <div id="carouselExample" class="carousel slide" style="width: 95%; margin: 0 auto; box-shadow: 5px 5px 15px 5px rgba(0, 0, 0, 0.05);">
                <div class="carousel-inner" style="display: flex; overflow-x: scroll; ">
                    <% for (int i = 0; i < hotelCategoryList.size(); i++) { %>

                    <form action="HOME.jsp" method="post" style="margin-right: 10px;">
                        <input type="hidden" name="category" value="<%= hotelCategoryList.get(i).get("categoryID") %>">
                            <input type="hidden" name="name" value="<%= hotelCategoryList.get(i).get("category_name") %>">
                                <div style="display: flex; justify-content: center; align-items: center;">
                                    <button type="submit" class="btn btn-outline-success" style="width: 100%; margin: 3%; margin-block-start: 25%;">
                                        <!--<a href="HOME.jsp?category=<%= hotelCategoryList.get(i).get("categoryID") %>&name=<%= hotelCategoryList.get(i).get("category_name") %>" class="col" style="flex: 0 0 auto; margin: 3px;">-->
                                        <!--<div class="card" style="max-width: 18rem; border-radius: 3%;">-->

                                        <img src="<%= hotelCategoryList.get(i).get("category_img") %>" alt="Image" style="object-fit: cover; width: 300px; height: 150px;">
                                            <!--<div class="card-body">-->
                                            <%= hotelCategoryList.get(i).get("category_name") %>
                                            <!--<h6 class="card-title"></h6>-->
                                            <!--</div>-->
                                            <!--</div>-->
                                            <!-- </a>-->

                                    </button>
                                </div>
                                </form>

                                <% } %>        
                                </div>
                                <!--                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                                                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                                    <span class="visually-hidden">Previous</span>
                                                                </button>
                                                                <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                                                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                                    <span class="visually-hidden">Next</span>
                                                                </button>-->
                                </div>
                                <!--OTEL CARD PART-->

                                <%
                                        HotelMergeImages hotelMergeImg = new HotelMergeImages(); // nesne oluşturdum 
                                       List<Map<String, Object>> hotelDataList = hotelMergeImg.getHotelsAndCategories(); // hotelDataList' ne classta üretilen hotelDataList atadım
                                %>

                                <%
                                     String getCategoryID = request.getParameter("category");
                                     String getCategoryName = request.getParameter("name");
                 
                                     if(getCategoryID!=null && !getCategoryID.isEmpty()) //KULLANICI OTEL KATEGORİSİ İÇİN SEÇİM YAPTIĞINDA LİSTELE
                                      {
                                           int categoryID = Integer.parseInt(getCategoryID);
                                %>

                                <h4 style="margin-inline-start: 9%;  margin-block-start: 5%;">Kategori: <%= getCategoryName%></h4>
                                <div class="row row-cols-1 row-cols-md-4 g-4" style="padding: 3%; border: 1px solid #20c997; box-shadow: 2px 5px 28px rgb(0 0 0 / 30%); width: 82%; margin: 0 auto; margin-bottom: 3%;">
                                    <% for (Map<String, Object> hotelData : hotelDataList) { %>
                                    <% int hotelCategoryID = (Integer) hotelData.get("categoryID"); %>
                                    <% if (hotelCategoryID != 0 && hotelCategoryID == categoryID) { %>
                                    <div class="col-md-3 mb-4">
                                        <div class="card h-100">
                                            <% String firstImage = (String) hotelData.get("first_image");
                    if (firstImage != null && !firstImage.isEmpty()) { %>
                                            <img src="<%= firstImage %>" class="card-img-top" alt="imgHotel">
                                                <% } %>
                                                <form action="otel_page.jsp" method="post">
                                                    <input type="hidden" name="hotelID" value="<%= hotelData.get("hotelID") %>">
                                                        <input type="hidden" name="hotel" value="<%= hotelData.get("hotel_name") %>">
                                                            <div style="display: flex; justify-content: center; align-items: center;">
                                                                <button type="submit" class="btn btn-outline-success" style="width: 100%; margin: 3%;">
                                                                    <!--<div class="card-body">-->
                                                                    <%= hotelData.get("hotel_name") %>
                                                                    <!--<h5 class="card-title"></h5>-->
                                                                    <!--</div>-->
                                                                </button>
                                                            </div>
                                                            </form>
                                                            </div>
                                                            </div>
                                                            <% } %>
                                                            <% } %>
                                                            </div>
                                                            <% } else { //sadece otelleri listeliyor%> 
                                                            <%@ include file="otel_card_part.jsp" %> 
                                                            <%}%>

                                                            </body>
                                                            </html>
