<%-- 
    Document   : LOGIN
    Created on : 11 Ara 2023, 21:51:55
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="otel_model_classes.CustomerDataAccess" %>
<%@page import="otel_model_classes.Customer" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Giriş Yap</title>

</head>
<body style="margin: 0; padding: 0; background-image: url('img/banner3.jpg'); background-size: cover;">
    <%@ include file="navbar.jsp" %>

    <%
    String savedEmail = null; // Varsayılan olarak null değeri atayın
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("email")) {
                savedEmail = cookie.getValue();  // Cookie'nin değerini atayın
            }
        }
    }
    %>


<div style="margin-bottom: 12%">
    <div class="container d-flex justify-content-center align-items-center my-5" style="border: 1px solid #25c932b3; max-width: 40%;padding: 5%; border-radius: 10%;box-shadow: 5px 5px 15px 5px #000;background-color: #00000042; color: #fff;">

        <form method="POST" action="LOGIN.jsp"   style="width: 60%; margin: 5%;" id="loginForm">

            <h4 style="display: block; text-align: center; margin-bottom: 15%;">Giriş Yap</h4>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="nameSurname" name="nameSurname" placeholder="Ad soyad gir" maxlength="70" required>
                    <label for="nameSurname" class="form-label" style="color:#000;">Ad Soyad</label>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder=" " maxlength="255" required value="<%= (savedEmail != null) ? savedEmail : "" %>">
                    <label for="email" class="form-label" style="color:#000;">Email</label>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-success">Giriş Yap </button>
            </div>

        </form>
    </div>


    <!---------------------------------------------------------------------------------------------------------------------------->
    <div id="mainDiv">
        <%
           
            int control=-1;
          // Formdan gelen verileri al
           String nameSurname = request.getParameter("nameSurname");
           String email = request.getParameter("email");
           CustomerDataAccess customerDataAccess = new CustomerDataAccess();
           
           
           
           if((nameSurname!=null && !nameSurname.isEmpty()) && (email!=null && !email.isEmpty()))
           {
            
            boolean userExists = customerDataAccess.checkUserExistence(nameSurname, email); //bu kullanıcı db'de var mı
               if (userExists )
               {
                   control=1; 
               }
               else{
                     control=0; 
                }
            }
        %>
    </div>

    <!---------------------------------------------------------------------------------------------------------------------------->

    <div id="SuccessDiv">
        <%
        //Giriş başarılı ise 
        if (control==1 ) {
               
                  Customer customer = customerDataAccess.getCustomer(nameSurname, email); 
                  //sessiona kaydettim bulununan kullanıcının nesnesini
                       user.setCustomerID(customer.getCustomerID());
                       user.setCustomerNameSurname(customer.getCustomerNameSurname());
                       user.setCustomerEmail(customer.getCustomerEmail());
                       user.setCustomerTel(customer.getCustomerTel());
                       user.setCustomerAdress(customer.getCustomerAdress());
                       user.setGender(customer.getGender());
                       user.setDateOfBirth(customer.getDateOfBirth());
               
               
        //            Cookie nameSurnameCookie = new Cookie("nameSurname", nameSurname);
        //            nameSurnameCookie.setMaxAge(7 * 24 * 60 * 60); // 1 haftalık süre
        //            response.addCookie(nameSurnameCookie);

                    Cookie emailCookie = new Cookie("email", email);
                    emailCookie.setMaxAge(7 * 24 * 60 * 60); // 1 haftalık süre
                    response.addCookie(emailCookie);

        %>

        <div id="successToast" class="toast-container top-0 end-0 p-3">
            <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style="font-size: large;">
                <div class="toast-header" style="background-color: #66d96f;">
                    Giriş Başarılı
                </div>
                <div class="toast-body">
                    HOŞGELDİNİZ ! <span style="font-weight: 500;"><%= request.getParameter("nameSurname").toUpperCase() %></span>
                </div>
            </div>
        </div>

        <script>
            // Toast'ı 10 saniye sonra gizle ve success.jsp'ye yönlendir
            setTimeout(function () {
                window.location.href = 'HOME.jsp';
            }, 1000);
        </script>

    </div>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <div id="FailDiv">
        <%//GİRİŞ BAŞARISIZ İSE
        } else if(control==0){
        %>

        <div id="failToast" class="toast-container top-0 end-0 p-3">
            <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style="font-size: large;">
                <div class="toast-header" style="background-color: #ff2323;">
                    <strong class="me-auto">Giriş Başarısız</strong>  
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" style="background-color: #dee2e6;">
                    Bu Kullanıcı Adı ve Mail Ait Kayıt Bulunamadı!
                </div>
            </div>
        </div>
        <%
                          user. setCustomerID(null);
                          user.setCustomerNameSurname(null);
                          user.setCustomerEmail(null);
                          user.setCustomerTel(null);
                          user.setCustomerAdress(null);
                          user.setGender(null);
                          user.setDateOfBirth(null);
                      }
        %>
    </div>




</div>
<%@ include file="footer.jsp" %>
</body>
</html>
