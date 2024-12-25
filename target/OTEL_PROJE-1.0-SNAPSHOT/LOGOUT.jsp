<%-- 
    Document   : LOGOUT
    Created on : 11 Ara 2023, 22:10:37
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
        // Oturumu sonlandırma işlemi
        session.invalidate(); // Oturumu sonlandır
        response.sendRedirect("HOME.jsp"); // Ana sayfaya yönlendir
    %>
</body>
</html>
