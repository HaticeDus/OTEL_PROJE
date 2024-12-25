<%-- 
    Document   : ERROR_PAGE_AGE
    Created on : 24 Ara 2023, 15:17:00
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Hata Sayfası</title>
</head>
<body>
    <%@ include file="navbar.jsp" %>
<div style='margin: 2%;border: 1px solid #20c997;padding: 2%;border-radius: 2%;box-shadow: 1px 3px 7px 0px rgba(0, 0, 0, 2.3);  margin-bottom: 25%;'>
    <h1>Hata Oluştu!</h1>

    <div class="card text-bg-danger mb-3" style="max-width: auto;">
        <div class="card-header"><h4><%= request.getAttribute("errorMessage") %></h4></div>
    </div>


</div>

<%@ include file="footer.jsp" %>
</body>
</html>
