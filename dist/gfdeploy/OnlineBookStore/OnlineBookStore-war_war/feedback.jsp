<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <main class="feedback-container">
        <h2 class="section-title">Contact Us!</h2>
        
        <c:if test="${not empty sessionScope.msg}">
            <div class="alert success">
                ${sessionScope.msg}
            </div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <!-- Feedback Form -->
        <form action="feedback" method="post" class="feedback-form">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="message">Message</label>
            <textarea id="message" name="message" rows="5" required></textarea>

            <button type="submit" class="btn">Submit</button>
        </form>

        <!-- Feedback List -->
        <h2 class="section-title">Your Feedback</h2>
        <c:if test="${empty feedbacks}">
            <p class="no-feedback">No feedback available yet.</p>
        </c:if>

        <c:if test="${not empty feedbacks}">
            <div class="feedback-list">
                <c:forEach var="fb" items="${feedbacks}">
                    <div class="feedback-item">
                        <p class="feedback-msg">"${fb.message}"</p>
                        <p class="feedback-user">- ${fb.name} (${fb.email})</p>
                        <p class="feedback-date">${fb.createdAt}</p>

                        <c:choose>
                            <c:when test="${not empty fb.reply}">
                                <p class="feedback-reply"><strong>Admin reply:</strong> ${fb.reply}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="feedback-reply pending"><em>⏳ Waiting for admin reply...</em></p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
