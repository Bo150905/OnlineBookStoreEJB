<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
</head>
<body>

<c:if test="${not empty error}">
    <div class="message">
        <span>${error}</span>
        <i class="fa-solid fa-xmark" onclick="this.parentElement.remove();"></i>
    </div>
</c:if>

<div class="box">
    <span class="borderline"></span>
    <form action="register" method="post">
        <h2>Register</h2>

        <div class="inputbox">
            <input type="text" name="fullName" required="required">
            <span>Full Name</span>
            <i></i>
        </div>

        <div class="inputbox">
            <input type="email" name="email" required="required">
            <span>Email</span>
            <i></i>
        </div>

        <div class="inputbox">
            <input type="text" name="username" required="required">
            <span>Username</span>
            <i></i>
        </div>

        <div class="inputbox">
            <input type="password" name="password" required="required">
            <span>Password</span>
            <i></i>
        </div>

        <div class="inputbox">
            <input type="password" name="cpassword" required="required">
            <span>Confirm Password</span>
            <i></i>
        </div>

        <div class="links">
            <a href="home">Back to Home</a>
            <a href="login.jsp">Login</a>
        </div>

        <input type="submit" value="Register Now" name="submit">
    </form>
</div>

<script src="https://kit.fontawesome.com/eedbcd0c96.js" crossorigin="anonymous"></script>
</body>
</html>
