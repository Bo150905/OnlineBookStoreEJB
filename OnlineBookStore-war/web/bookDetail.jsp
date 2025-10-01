<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${book.title} - Book Detail</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<jsp:include page="header.jsp" />

<main class="book-detail-container">
    <c:choose>
        <c:when test="${not empty book}">
            <div class="book-detail">
                <div class="book-image">
                    <c:choose>
                        <c:when test="${not empty book.coverImage}">
                            <img src="assets/images/${book.coverImage}" alt="${book.title}">
                        </c:when>
                        <c:otherwise>
                            <img src="assets/images/default-book.png" alt="No Image">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="book-info">
                    <h2>${book.title}</h2>
                    <p class="author">by ${book.author}</p>
                    <p class="price">${book.price} VND</p>
                    <p class="description">${book.description}</p>

                    <form action="cart" method="post" class="add-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="bookId" value="${book.bookId}">
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1">
                        <button type="submit">Add to Cart</button>
                    </form>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <p class="not-found">❌ Book not found!</p>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="footer.jsp" />
</body>
</html>
