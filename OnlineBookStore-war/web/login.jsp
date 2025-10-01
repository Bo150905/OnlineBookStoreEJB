<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="assets/css/login.css">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      crossorigin="anonymous" referrerpolicy="no-referrer" />

<c:if test="${not empty error}">
    <div class="message">
        <span>${error}</span>
        <i class="fa-solid fa-xmark" onclick="this.parentElement.remove();"></i>
    </div>
</c:if>

<div class="login-container">
    <div class="box login_box">
        <span class="borderline"></span>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <h2>Login</h2>

            <div class="inputbox">
                <input type="email" name="email" required="required">
                <span>Email</span>
                <i></i>
            </div>

            <div class="inputbox">
                <input type="password" name="password" required="required">
                <span>Password</span>
                <i></i>
            </div>

            <div class="links">
                <a href="home">Back to Home</a>
                <a href="register.jsp">Sign Up</a>
            </div>

            <input type="submit" value="Login" name="submit">
        </form>
    </div>
</div>

<script src="https://kit.fontawesome.com/eedbcd0c96.js" crossorigin="anonymous"></script>
