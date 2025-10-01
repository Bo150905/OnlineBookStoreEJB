<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Book Store</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <main class="container">
            <div class="book-grid">
                <c:choose>
                    <c:when test="${not empty books}">
                        <c:forEach var="book" items="${books}">
                            <div class="book-card">
                                <c:choose>
                                    <c:when test="${not empty book.coverImage}">
                                        <a href="bookDetail?id=${book.bookId}">
                                            <img src="assets/images/${book.coverImage}" alt="${book.title}">
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="bookDetail?id=${book.bookId}">
                                            <img src="assets/images/default-book.png" alt="No Image">
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <h3>
                                    <a href="bookDetail?id=${book.bookId}" class="book-link">
                                        ${book.title}
                                    </a>
                                </h3>
                                <p class="author">by ${book.author}</p>
                                <p class="price">${book.price} $</p>

                                <form action="cart" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit">Add to Cart</button>
                                </form>

                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>No books available.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>
