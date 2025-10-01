<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>BookStore - Home</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="home_cont">
            <div class="main_descrip">
                <h1>THE BOOKSHELF</h1>
                <p>Explore, Discover, and Buy Your Favorite Books</p>
                <button class="discover_btn" onclick="window.location.href = 'books'">
                    Discover More
                </button>
            </div>
        </section>

        <div class="book-grid">
            <c:choose>
                <c:when test="${not empty featuredBooks}">
                    <c:forEach var="book" items="${featuredBooks}">
                        <div class="book-card">
                            <a href="bookDetail?id=${book.bookId}">
                                <c:choose>
                                    <c:when test="${not empty book.coverImage}">
                                        <img src="assets/images/${book.coverImage}" alt="${book.title}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="assets/images/default-book.png" alt="No Image">
                                    </c:otherwise>
                                </c:choose>
                            </a>

                            <h3>
                                <a href="bookDetail?id=${book.bookId}">${book.title}</a>
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



        <section class="story_section">
            <div class="story_content">
                <img src="assets/images/about.jpg" alt="Our Story">
                <div class="story_text">
                    <h2>Discover Our Story</h2>
                    <p>
                        At BookStore, we are passionate about connecting readers with captivating stories,
                        inspiring ideas, and a world of knowledge. Our bookstore is more than just a place
                        to buy books; it's a haven for book enthusiasts, where the love for literature thrives.
                    </p>
                    <a href="about.jsp" class="btn red">Read More</a>
                </div>
            </div>
        </section>

        <section class="queries_section">
            <h2>Have Any Queries?</h2>
            <p>
                At BookStore, we value your satisfaction and strive to provide exceptional customer service.
                If you have any questions, concerns, or inquiries, our dedicated team is here to assist you
                every step of the way.
            </p>
            <a href="feedback.jsp" class="btn red">Contact Us</a>
        </section>

        <jsp:include page="footer.jsp" />
    </body>
</html>
