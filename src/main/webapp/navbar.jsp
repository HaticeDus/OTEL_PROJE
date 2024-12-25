<%-- 
    Document   : navbar
    Created on : 25 Kas 2023, 16:44:55
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="otel_model_classes.Customer" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
                <title>navbar.jsp</title>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                </head>

                <body class="p-0 m-0 border-0 bd-example m-0 border-0">

                    <nav class="navbar navbar-expand-lg" style="background-color: #ffc707d6;">
                        <div class="container-fluid p-0" style="margin-left: 4%;">
                            <a class="navbar-brand" style="font-size: xx-large;" href="" >OTELL</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" style="font-size: larger;" href="HOME.jsp">Anasayfa</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" style="font-size: larger;"  href="#OtelPart">Oteller</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" style="font-size: larger;"  href="#CategoryPart">Kategoriler</a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <!-- Diğer menü öğeleri -->
                                    </li>
                                </ul>
                                <ul class="navbar-nav mb-2 mb-lg-0" style="margin-right: 1%">
                                    <%
           //out.println("User nesnesi: " + user); // Debug için user nesnesini kontrol et//burası her türlü değer geliyor 
           if (user.getCustomerNameSurname() == null) { %>
                                    <!-- Kullanıcı oturumu yoksa gösterilecek içerik -->
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" style="font-size: larger;" href="LOGIN.jsp">Giriş Yap <i class="bi bi-door-open-fill"></i></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" style="font-size: larger;" href="REGISTER.jsp">Kayıt Ol <i class="bi bi-person-plus-fill"></i></a>
                                    </li>
                                    <% } else { %>
                                    <!-- Kullanıcı oturumu varsa gösterilecek içerik -->
                                    <li>
                                        <a class="nav-link active d-flex align-items-center" aria-current="page" style="font-size: larger;" href="PROFILE.jsp">
                                            <span> <%= user.getCustomerNameSurname().toUpperCase() %></span>
                                            <i class="bi-person"></i>
                                        </a>
                                    </li>

                                    <li class="nav-item-logout">
                                        <a class="nav-link active" aria-current="page" style="font-size: larger;" href="LOGOUT.jsp">Çıkış Yap <i class="bi bi-box-arrow-right"></i></a>
                                    </li>
                                    <% } %>

                                </ul>
                            </div>
                        </div>
                    </nav>


                </body>
                </html>
