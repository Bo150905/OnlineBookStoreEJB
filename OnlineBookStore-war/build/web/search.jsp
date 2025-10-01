<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Search Books</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <main class="search-page">

            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/search" method="get">
                    <input type="text" name="keyword" placeholder="Search by title or author..." value="${param.keyword}">
                    <button type="submit">Search</button>
                </form>
            </div>

            <div class="book-container">
                <c:choose>

                    <c:when test="${empty param.keyword}">
                        <p class="no-result">Please enter a keyword to search.</p>
                    </c:when>


                    <c:when test="${not empty param.keyword and empty books}">
                        <p class="no-result">
                            No books found for "<strong>${param.keyword}</strong>"
                        </p>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="book" items="${books}">
                            <div class="book-card">
                                <a href="${pageContext.request.contextPath}/bookDetail?id=${book.bookId}">
                                    <img src="${pageContext.request.contextPath}/assets/images/${book.coverImage}" alt="${book.title}">
                                </a>

                                <h3>
                                    <a href="${pageContext.request.contextPath}/bookDetail?id=${book.bookId}">
                                        ${book.title}
                                    </a>
                                </h3>

                                <p><strong>Author:</strong> ${book.author}</p>
                                <p><strong>Price:</strong> Rs. ${book.price}/-</p>

                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <input type="number" name="quantity" value="1" min="1" class="qty-input">
                                    <button type="submit" name="action" value="add">Add to Cart</button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

        </main>

        <jsp:include page="footer.jsp" />

    </body>
</html>
