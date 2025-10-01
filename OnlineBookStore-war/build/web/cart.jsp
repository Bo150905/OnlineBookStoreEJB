<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <main class="cart-container">
            <h2>Your Shopping Cart</h2>

            <c:if test="${empty cartItems}">
                <p>Your cart is empty</p>
            </c:if>

            <c:if test="${not empty cartItems}">
                <div class="cart-items">
                    <c:set var="totalPrice" value="0" scope="page" />

                    <c:forEach var="item" items="${cartItems}">
                        <c:set var="totalPrice" value="${totalPrice + (item.bookId.price * item.quantity)}" scope="page" />

                        <div class="cart-card">
                            <img src="assets/images/${item.bookId.coverImage}" 
                                 alt="${item.bookId.title}" class="cart-img"/>

                            <h3>${item.bookId.title}</h3>
                            <p>Rs. ${item.bookId.price}/-</p>

                            <form action="cart" method="post" style="display:inline-block;">
                                <input type="hidden" name="cartId" value="${item.cartId}"/>
                                <input type="number" name="quantity" value="${item.quantity}" min="1"/>
                                <button type="submit" name="action" value="update" class="btn-update">Update</button>
                            </form>

                            <form action="cart" method="post" style="display:inline-block;">
                                <input type="hidden" name="cartId" value="${item.cartId}"/>
                                <button type="submit" name="action" value="delete" class="btn-delete">Remove</button>
                            </form>

                            <p>Total: Rs. ${item.bookId.price * item.quantity}/-</p>
                        </div>
                    </c:forEach>

                    <div class="cart-total">
                        <h3>Total Cart Price : Rs. ${totalPrice}/-</h3>

                        <form action="cart" method="post" style="display:inline;">
                            <button type="submit" name="action" value="clear" class="btn-delete">Delete All</button>
                        </form>

                        <a href="books" class="btn-continue">Continue Shopping</a>
                        <a href="checkout" class="btn-checkout">Checkout</a>
                    </div>
                </div>
            </c:if>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>
