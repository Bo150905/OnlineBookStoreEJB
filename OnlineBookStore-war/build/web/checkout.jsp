<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Checkout</title>
        <link rel="stylesheet" href="assets/css/style.css">
        <script>
            function validateCheckoutForm() {
                const address = document.querySelector("input[name='address']");
                const phone = document.querySelector("input[name='phone']");
                const note = document.querySelector("textarea[name='note']");

                if (address.value.trim().length < 5) {
                    alert("Address must be at least 5 characters.");
                    address.focus();
                    return false;
                }

                const phonePattern = /^[0-9]{9,11}$/;
                if (!phonePattern.test(phone.value.trim())) {
                    alert("Phone number must be 9-11 digits.");
                    phone.focus();
                    return false;
                }

                if (note.value.length > 200) {
                    alert("Note must be less than 200 characters.");
                    note.focus();
                    return false;
                }

                return true;
            }
        </script>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <main class="checkout-container">
            <h2>Checkout</h2>

            <c:if test="${not empty cartItems}">
                <div class="checkout-summary">
                    <h3>Order Summary</h3>
                    <ul>
                        <c:set var="totalPrice" value="0" />
                        <c:forEach var="item" items="${cartItems}">
                            <li>
                                ${item.bookId.title} (x${item.quantity}) - 
                                Rs. ${item.bookId.price * item.quantity}/-
                            </li>
                            <c:set var="totalPrice" value="${totalPrice + (item.bookId.price * item.quantity)}" />
                        </c:forEach>
                    </ul>
                    <h3>Total: Rs. ${totalPrice}/-</h3>
                </div>

                <form action="checkout" method="post" class="checkout-form" onsubmit="return validateCheckoutForm()">
                    <label>Shipping Address:</label>
                    <input type="text" name="address" required minlength="5" placeholder="Enter your address" />

                    <label>Phone Number:</label>
                    <input type="text" name="phone" required pattern="[0-9]{9,11}" placeholder="9-11 digits" />

                    <label>Note:</label>
                    <textarea name="note" maxlength="200" placeholder="Optional note (max 200 chars)"></textarea>

                    <label>Payment Method:</label>
                    <select name="paymentMethod" required>
                        <option value="">-- Select Payment --</option>
                        <option value="COD">Cash on Delivery</option>
                        <option value="BankTransfer">Bank Transfer</option>
                        <option value="CreditCard">Credit Card</option>
                    </select>

                    <button type="submit" class="btn-checkout">Place Order</button>
                </form>
            </c:if>

            <c:if test="${empty cartItems}">
                <p>Your cart is empty. <a href="books">Shop now</a></p>
            </c:if>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>
