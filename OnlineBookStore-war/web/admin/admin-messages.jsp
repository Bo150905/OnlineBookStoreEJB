<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Admin - Messages</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>
    <style>
        .form-card { display: none; }
        .form-card.active { display: flex; }
    </style>
    <script>
        function openReplyForm(id, reply) {
            document.getElementById("feedbackId").value = id;
            document.getElementById("replyText").value = reply || "";
            document.getElementById("replyForm").classList.add("active");
        }
        function closeReplyForm() {
            document.getElementById("replyForm").classList.remove("active");
        }
    </script>
</head>
<body>
<jsp:include page="admin-header.jsp"/>

<div class="main-content">
    <h1 class="title">💬 Manage Messages</h1>

    <!-- Search -->
    <form method="get" action="${pageContext.request.contextPath}/admin/messages" class="search-form">
        <input type="text" name="keyword" placeholder="Search by name or email..." value="${param.keyword}">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- Messages List -->
    <div class="admin_box_container">
        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Sender</th>
                <th>Email</th>
                <th>Message</th>
                <th>Date</th>
                <th>Status</th>
                <th>Reply</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="m" items="${messages}">
                <tr>
                    <td>#${m.feedbackId}</td>
                    <td>${m.name}</td>
                    <td>${m.email}</td>
                    <td>${m.message}</td>
                    <td><fmt:formatDate value="${m.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${m.status == 'approved'}">✅ Approved</c:when>
                            <c:otherwise>⏳ Pending</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty m.reply}">
                            <div class="reply-box">💡 ${m.reply}</div>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${m.status != 'approved'}">
                            <a class="btn btn-success"
                               href="messages?action=approve&id=${m.feedbackId}"
                               onclick="return confirm('Approve this message?');">Approve</a>
                        </c:if>
                        <button class="btn btn-primary"
                                onclick="openReplyForm('${m.feedbackId}', '${m.reply}')">Reply</button>
                        <a class="btn btn-danger"
                           href="messages?action=delete&id=${m.feedbackId}"
                           onclick="return confirm('Delete this message?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Popup Reply Form -->
<div class="form-card" id="replyForm">
    <div class="form-content">
        <span style="float:right; cursor:pointer; font-size:18px; color:#999;" onclick="closeReplyForm()">✖</span>
        <h2>Reply to Feedback</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/messages">
            <input type="hidden" name="action" value="reply"/>
            <input type="hidden" id="feedbackId" name="id"/>

            <label for="replyText">Your Reply</label>
            <textarea id="replyText" name="reply" rows="4" required></textarea>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Send Reply</button>
                <button type="button" class="btn btn-secondary" onclick="closeReplyForm()">Cancel</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
