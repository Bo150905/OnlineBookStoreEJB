<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
    <head>
        <title>My Orders</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <main class="orders-wrapper">
            <h2 class="orders-title">Placed Orders</h2>

            <c:if test="${empty orders}">
                <p class="no-orders">You have no orders yet. <a href="books">Shop now</a></p>
            </c:if>

            <div class="orders-container">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">
                        <h3>Order #${order.orderId}</h3>
                        <p><span>Placed On:</span> 
                            <fmt:formatDate value="${order.orderDate}" pattern="dd-MMM-yyyy"/>
                        </p>
                        <p><span>Name:</span> ${order.userId.fullName}</p>
                        <p><span>Phone:</span> ${order.phone}</p>
                        <p><span>Email:</span> ${order.userId.email}</p>
                        <p><span>Address:</span> ${order.shippingAddress}</p>
                        <p><span>Payment Method:</span> ${order.paymentMethod}</p>
                        <p><span>Total Amount:</span> 
                            $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2"/>
                        </p>

                        <p><span>Payment Status:</span> 
                            <span class="status ${order.paymentStatus}">${order.paymentStatus}</span>
                        </p>
                        <p><span>Order Status:</span> 
                            <span class="status ${order.status}">${order.status}</span>
                        </p>
                        <c:if test="${not empty order.trackingNumber}">
                            <p><span>Tracking #:</span> ${order.trackingNumber}</p>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>
