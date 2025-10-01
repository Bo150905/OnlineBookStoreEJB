<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>About Us - BookStore</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <section class="about-container">
            <div class="about-image">
                <img src="assets/images/about1.jpg" alt="BookStore">
            </div>
            <div class="about-text">
                <h2>Why Choose Us ?</h2>
                <p>
                    With our extensive collection of books spanning various genres, you'll find the perfect read 
                    to satisfy your cravings. Our knowledgeable staff of passionate book enthusiasts is always ready 
                    to offer personalized recommendations and guide you toward hidden gems.
                </p>
                <p>
                    We take pride in fostering an inclusive community, hosting engaging events, book clubs, and author 
                    meet-ups. Additionally, our seamless online presence allows you to browse, explore, and order books 
                    from the comfort of your home, ensuring secure transactions and timely deliveries.
                </p>
                <p>
                    At BookStore, customer satisfaction is paramount. We are dedicated to delivering exceptional service, 
                    promptly addressing any queries or concerns. Join us in celebrating the power of books to inspire, 
                    educate, and entertain. Let us be your trusted companion on your literary adventures.
                </p>
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
