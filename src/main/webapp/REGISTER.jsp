<%-- 
    Document   : REGISTER
    Created on : 23 Kas 2023, 23:17:33
    Author     : Monster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>

<%@page import="otel_model_classes.RegisterCustomer" %>
<!--2 kere importa gerek yok çünkü navbarda var!!!--><!--useBean session nesnesi -->
<%--<jsp:useBean id="user" class="otel_model_classes.Customer" scope="session"/>--%> 


<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
            <title>Kayıt Ol</title>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
            <!--             <link href="CSS/Register_style.css" rel="stylesheet">-->

            </head>


            <body style="margin: 0; padding: 0; background-image: url('img/banner2.jpg'); background-size: cover;">
                <%@ include file="navbar.jsp" %>
            <div style="margin-bottom: 10%">
                <div class="container d-flex justify-content-center align-items-center my-5" style="border: 1px solid #25c932b3; max-width: 35%; border-radius: 10%;box-shadow: 5px 5px 15px 5px #000;background-color: #00000042; color: #fff; ">

                    <form  method="POST" action="REGISTER.jsp"   style="width: 60%; margin: 5%;">

                        <h4 style="display: block; text-align: center; margin-bottom: 15%;">Kayıt Ol</h4>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="nameSurname" name="nameSurname" placeholder="Ad soyad gir" maxlength="70" required>
                                <label for="nameSurname" class="form-label"style="color:#000;">Ad Soyad</label>
                        </div>


                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email"  name="email"  placeholder=" " maxlength="255" required>
                                <label for="email" class="form-label" style="color:#000;">Email</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="tel" class="form-control" id="phone" name="phone" placeholder="5XXXXXXXXX" pattern="[0-9]{10}" maxlength="10" required>
                                <label for="phone" class="form-label" style="color:#000;">Telefon</label>
                        </div>


                        <div class="form-floating mb-3">
                            <textarea class="form-control" id="address"  name="address" rows="3" placeholder=" " required></textarea>
                            <label for="address" class="form-label"style="color:#000;">Adres</label>
                        </div>

                        <div class="form-floating mb-3 d-flex justify-content-center">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="inlineRadio1"  value="Kadın" required>
                                    <label class="form-check-label" for="inlineRadio1">Kadın</label>
                            </div>
                            <div class="form-check form-check-inline" style="margin-left: 25px">
                                <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="Erkek" required>
                                    <label class="form-check-label" for="inlineRadio2">Erkek</label>
                            </div>
                        </div>

                        <div class="form-floating mb-3"> 
                            <label for="dob" class="form-label" style="color:#000;"></label>
                            <select class="form-select" id="dob" name="dob" required>
                                <option value="" disabled selected>Doğum Yılını Seçin</option>
                                <% 
                                    int currentYear = java.time.Year.now().getValue(); // Şu anki yıl
                                    for (int year = 1943; year <= currentYear; year++) { %>
                                <option value="<%= year %>"><%= year %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="col-12 d-flex justify-content-center">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required="">
                                    <label class="form-check-label" for="invalidCheck">
                                        Şartları ve koşulları kabul ediyorum
                                    </label>
                                    <div class="invalid-feedback">
                                        Göndermeden önce kabul etmelisiniz.
                                    </div>
                            </div>
                        </div>
                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-success">Kayıt Ol</button>
                        </div>
                        <div class="text-center mt-4">
                            <a type="button" class="btn btn-warning" href="LOGIN.jsp">Zaten Hesabın varsa Giriş yap</a>
                        </div>
                    </form>

                </div>

                <%
            
                  // Formdan gelen verileri al
                   String nameSurname = request.getParameter("nameSurname");
                   String email = request.getParameter("email");
                   String address = request.getParameter("address");
                   String gender = request.getParameter("gender");
                   String dateOfBirth = request.getParameter("dob");
                    String phone = request.getParameter("phone");

                    
  if((nameSurname!=null && !nameSurname.isEmpty())&& (email!=null && !email.isEmpty())&&(address!=null && !address.isEmpty())&&(gender!=null && !gender.isEmpty())&& (dateOfBirth!=null && !dateOfBirth.isEmpty())&&(phone != null&& !phone.isEmpty()))
      {             
                                              
             RegisterCustomer customer = new RegisterCustomer();
                          //session kaydet -useBean nesnesine
                          user.setCustomerNameSurname(nameSurname);
                          user.setCustomerEmail(email);
                          user.setCustomerAdress(address);
                          user.setCustomerTel(phone);
                          user.setGender(gender);
                          user.setDateOfBirth(dateOfBirth);
                       
                
              int newCustomerID = customer.addCustomer(user); //yeni kullanıcıyı db'ye kaydettim/ kayıt başarılı ise yeni kullanıcının id dönsün
              user. setCustomerID(newCustomerID); //YENI OLUŞAN KULLANICININ ID SESSINA KAYDETTİM

           if (newCustomerID != -1) {
                %>
                <div class="toast-container top-0 end-0 p-3">
                    <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style="font-size: large;">
                        <div class="toast-header" style="background-color: #66d96f;">
                            Kayıt Başarılı
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
                <%
                } else {
                            //out.println("Kayıt ekleme başarısız!");
                             // Kayıt başarısız olduğunda oturum nesnesindeki bilgileri temizle
                %>

                <div class="toast-container top-0 end-0 p-3">
                    <div role="alert" aria-live="assertive" aria-atomic="true" class="toast fade show" data-bs-autohide="false" style="font-size: large;">
                        <div class="toast-header" style="background-color: #ff2323;">
                            <strong class="me-auto">Kayıt Başarısız</strong>  
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body" style="background-color: white;">
                            KAYIT BAŞARISIZ!
                        </div>
                    </div>
                </div>



                <%
                                  user.setCustomerNameSurname(null);
                                  user.setCustomerEmail(null);
                                  user.setCustomerTel(null);
                                  user.setCustomerAdress(null);
                                  user.setGender(null);
                                  user.setDateOfBirth(null);
                              }

 } //if toaster engelleme
                %>





            </div>
            <%@ include file="footer.jsp" %>
            </body>

            </html>

