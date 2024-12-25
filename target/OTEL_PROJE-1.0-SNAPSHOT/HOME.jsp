<%-- 
    Document   : HOME
    Created on : 25 Kas 2023, 14:12:36
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="otel_model_classes.HotelMergeCity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="user_session" class="otel_model_classes.UserSession" scope="session"/> 
<!--user_session 2.session nesnesi oturum boyunca bilgileri kaydediyor-->

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
            <title>Anasayfa</title>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
            <style>
                .container {
                    opacity: 0.5; /* Varsayılan değer */
                    transition: opacity 0.3s ease; /* Opaklık değişimi için geçiş efekti */
                }
                .container:hover {
                    opacity: 1; /* Üzerine gelindiğinde tamamen opak */
                }
            </style>
            </head>
            <body  class="p-0 m-0 border-0 bd-example m-0 border-0">
                <%@ include file="navbar.jsp" %>
                <%
                                        HotelMergeCity hotelCity= new HotelMergeCity();
                                        List<Map<String, Object>>cityList = hotelCity.getCities(); // classtaki map türündeki listemi çektim
                %>
            <div class="container  justify-content-center align-items-center my-5" style="top:3%; position: absolute; left: 25%; border: 1px solid #dc3545; max-width: 50%; padding: 2%; border-radius: 4%;box-shadow: 5px 5px 15px 5px rgba(0, 0, 0, 2.3);background-color: #000000a3;color: floralwhite; font-size: large;">
                <h4 style=" text-align: center; margin: 30px;">Nereye Gidiyorsun ?</h4> 
                <div class="row">
                    <div class="row form-group">
                        <form method="POST" action="OTEL_FILTRE.jsp">
                            <div class="row">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center">
                                            <h6 class="pt-2 pb-2 me-3">Oda Sayısı Seç:</h6>
                                            <select class="form-select" aria-label="Default select example" id="roomNumberSelect" name="room_number" required>
                                                <option selected disabled value="">Oda sayısı</option>
                                                <% for (int i = 1; i <= 5; i++) { %>
                                                <option value="<%=i%>"><%=i%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                    <!--CITY PART-->
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center">
                                            <h6 class="pt-2 pb-2 me-3">Şehir seç:</h6>
                                            <select name="selectedCity" class="form-select" aria-label="Default select example" required>
                                                <option selected disabled value="">Şehir</option>
                                                <% for (Map<String, Object> city : cityList) { %>
                                                <option value="<%=city.get("cityID")%>"><%=city.get("city_name")%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div> 
                                </div>
                                <!--DATAPICKER PART-->
                                <div class="form-floating mb-4">
                                    <h6 class="pt-4 pb-2">Tarihini seç</h6>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="row form-group">
                                                <label for="date" class="col-sm-4 col-form-label">Giriş tarihi: </label>
                                                <div class="col-sm-6">
                                                    <div class="input-group date" id="datepicker_in">
                                                        <input type="date" id="date" class="form-control" name="check_in_date" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="row form-group">
                                                <label for="date" class="col-sm-4 col-form-label">Çıkış tarihi: </label>
                                                <div class="col-sm-6">
                                                    <div class="input-group date" id="datepicker_out">
                                                        <input type="date" id="date" class="form-control" name="check_out_date" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <button type="submit" class="btn btn-outline-danger" style="width: 50%;">Bilgilerimi Kaydet ve Otel Bul</button>
                                </div>
                        </form>
                    </div>
                </div>
            </div>
            </div>
            <%@include file="home_carousel.jsp"%>
            <%@ include file="footer.jsp" %>
            </body>
            </html>
