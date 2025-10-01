<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<jsp:include page="header.jsp" />

<main class="order-success-container">
    <h2>🎉 Order Placed Successfully!</h2>

    <c:if test="${not empty sessionScope.message}">
        <p class="success-msg">${sessionScope.message}</p>
    </c:if>

    <div class="order-success-box">
        <p>Thank you for shopping with us.</p>
        <p>Your order has been placed and is being processed.</p>
    </div>

    <div class="order-success-actions">
        <a href="books" class="btn-continue">Continue Shopping</a>
        <a href="orders" class="btn-checkout">View My Orders</a>
    </div>
</main>

<jsp:include page="footer.jsp" />
</body>
</html>
