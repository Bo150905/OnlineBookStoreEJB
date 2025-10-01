<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>BookStore</title>

        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <link rel="stylesheet" href="assets/css/home.css">
    </head>
    <body>
        <header class="user_header">
            <div class="header_1">
                <div class="user_flex">
                    <div class="logo_cont">
                        <img src="assets/images/book_logo.png" alt="logo">
                        <a href="${pageContext.request.contextPath}/home" class="book_logo">BookStore</a>
                    </div>

                    <nav class="navbar">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <a href="${pageContext.request.contextPath}/about.jsp">About</a>
                        <a href="${pageContext.request.contextPath}/books">Shop</a>
                        <a href="${pageContext.request.contextPath}/feedback">Contact</a>
                        <a href="${pageContext.request.contextPath}/orders">Orders</a>
                    </nav>

                    <div class="last_part">
                        <c:if test="${empty sessionScope.user}">
                            <div class="loginorreg">
                                <p><a href="${pageContext.request.contextPath}/login.jsp">Login</a> |
                                    <a href="${pageContext.request.contextPath}/register.jsp">Register</a></p>
                            </div>
                        </c:if>

                        <div class="icons">
                            <a href="${pageContext.request.contextPath}/search.jsp" class="fa-solid fa-magnifying-glass"></a>

                            <c:if test="${not empty sessionScope.user}">
                                <div class="fas fa-user" id="user_btn"></div>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/cart">
                                <i class="fas fa-shopping-cart"></i>
                                <span class="quantity">
                                    (${sessionScope.cartSize != null ? sessionScope.cartSize : 0})
                                </span>
                            </a>

                        </div>
                    </div>

                    <div class="menu-toggle"><i class="fa fa-bars"></i></div>

                    <c:if test="${not empty sessionScope.user}">
                        <div class="header_acc_box" id="user_box">
                            <p>Username: <span>${sessionScope.user.fullName}</span></p>
                            <p>Email: <span>${sessionScope.user.email}</span></p>
                            <a href="${pageContext.request.contextPath}/logout" class="delete-btn">Logout</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="mobile_menu">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/about.jsp">About</a>
                <a href="${pageContext.request.contextPath}/books">Shop</a>
                <a href="${pageContext.request.contextPath}/feedback">Contact</a>
                <a href="${pageContext.request.contextPath}/orders">Orders</a>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="#">Hello, ${sessionScope.user.fullName}</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
                        <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/search.jsp">Search</a>
                <a href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="quantity">
                        (${sessionScope.cartSize != null ? sessionScope.cartSize : 0})
                    </span>
                </a>

            </div>
        </header>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const userBtn = document.getElementById("user_btn");
                const userBox = document.getElementById("user_box");
                const menuToggle = document.querySelector(".menu-toggle");
                const mobileMenu = document.querySelector(".mobile_menu");

                if (userBtn && userBox) {
                    userBtn.addEventListener("click", () => {
                        userBox.classList.toggle("active");
                    });
                }

                if (menuToggle && mobileMenu) {
                    menuToggle.addEventListener("click", () => {
                        mobileMenu.classList.toggle("active");
                    });
                }
            });
        </script>
    </body>
</html>
