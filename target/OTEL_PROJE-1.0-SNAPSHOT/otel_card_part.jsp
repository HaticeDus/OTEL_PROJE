<%-- 
    Document   : otel_card_jsp
    Created on : 1 Ara 2023, 15:22:26
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="otel_model_classes.HotelMergeImages" %>
<%@ page import="otel_model_classes.HotelFeatures" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/>--%> 
<!--HOME.jsp'de zaten var oraya çağırdığım için dublicate ahatsı veriyor-->
<!DOCTYPE html>
<!--BURADA SADECE OTELLERİ LİSTELİYORUM/ HOME.jsp'de kategorilere göre listeliyor-->
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
            <title>otel_card_part</title>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
            </head>

            <body>
            <div class="row" >

                <div class="col-md-2" >
                    <!---------------------------------------------------FEATURE KISMI-------------------------------------------------------->

                    <% 
                        HotelFeatures featureObj=new HotelFeatures();
                       List<Map<String, Object>> featureList = featureObj.getFeatures();
                    %>

                    <h4 class="list-group-item d-flex justify-content-center" style="margin-block-start: 32%; margin-bottom: -23%;  margin-inline-start: 28%;">Otel Filtreler</h4>  


                    <ul class="list-group" style="margin-block-start: 30%; margin-left: 13%; margin-right: -22%; height: 26%; overflow-y: auto;">

                        <% if (featureList != null && !featureList.isEmpty()) {
                            for (Map<String, Object> feature : featureList) {
                                int featureID = (int) feature.get("featureID");
                                String featureName = feature.get("feature_name").toString(); // Feature ismini al
                        %>

                        <li class="list-group-item d-flex justify-content-center">  
                            <button type="button" class="btn btn-outline-danger" style="width: 100%;" value=" <%=featureID%>"><%=featureName%></button>
                        </li>

                        <% 
                            }
                        %>
                    </ul>
                    <% } else { %>
                    <p>No features found.</p>
                    <% } %>

                </div>

                <div class="col-md-10">
                    <!----------------------------------------------------------HOTEL--PART------------------------------------------------------------>
                    <%
                           HotelMergeImages hotelMergeImgs = new HotelMergeImages(); // nesne oluşturdum 
                          List<Map<String, Object>> hotelDataLists = hotelMergeImgs.getHotelsAndFirstImages(); // hotelDataList' ne classta üretilen hotelDataList atadım
                      
        if(hotelDataLists!=null && !hotelDataLists.isEmpty() ){
                    %>
                    <h3 style="margin-inline-start: 9%;  margin-block-start: 5%;" id="OtelPart">Oteller</h3>
                    <div class="row row-cols-1 row-cols-md-4 g-4"  style="    padding: 3%;  border: 1px solid #20c99; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); width: 90%; margin: 0 auto; margin-bottom: 3%; margin-top: 2%; border: 1px solid #dc3545;">
                        <% for (Map<String, Object> hotelDatas : hotelDataLists) { %>
                        <div class="col-md-3 mb-4">
                            <% user_session.setHotelID(Integer.parseInt(hotelDatas.get("hotelID").toString())); %>


                            <div class="card h-100" style="box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);">
                                <% String firstImage = (String) hotelDatas.get("first_image");
                if (firstImage != null && !firstImage.isEmpty()) { %>
                                <img src="<%= firstImage %>" class="card-img-top" alt="imgHotel">
                                    <% } %>
                                    <form action="otel_page.jsp" method="post">
                                        <input type="hidden" name="hotelID" value="<%= hotelDatas.get("hotelID") %>">
                                            <input type="hidden" name="hotel" value="<%= hotelDatas.get("hotel_name") %>">
                                                <div style="display: flex; justify-content: center; align-items: center;">
                                                    <button type="submit" class="btn btn-outline-success" style="width: 100%; margin: 3%;">
                                                        <!--<div class="card-body">-->
                                                            <!--<a href="otel_page.jsp?hotelID=<%= hotelDatas.get("hotelID") %>&hotel=<%= hotelDatas.get("hotel_name") %>" class="col" style="flex: 0 0 auto; margin: 3px;">-->
                                                        <%= hotelDatas.get("hotel_name") %>
                                                        <!--<h5 class="card-title"></h5>-->
                                                        <!--</a>-->
                                                        <!--</div>-->
                                                    </button>
                                                </div>
                                                </form>


                                                </div>
                                                </div>
                                                <% } %>
                                                </div>

                                                <% } else{       
                            out.println("hotelDataLists Boş");
                             }%>

                                                </div>
                                                </div>

                                                </body>
                                                </html>
