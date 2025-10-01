<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Users</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>
    <style>
        .form-card { display: none; }
        .form-card.active { display: flex; }
        .header-flex {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="admin-header.jsp"/>

<div class="main-content">
    <h1 class="title">👤 Manage Users</h1>

    <!-- Form Add/Edit -->
    <div id="userForm" class="form-card">
        <div class="form-content">
            <span style="float:right; cursor:pointer; font-size:18px; color:#999;" onclick="hideForm()">✖</span>
            <h2 id="formTitle">Add User</h2>
            <form method="post" action="${pageContext.request.contextPath}/admin/users" class="admin-form">
                <input type="hidden" name="action" id="formAction" value="create">
                <input type="hidden" name="id" id="userId"/>

                <input type="text" name="username" id="username" placeholder="Enter Username" required/>
                <input type="text" name="fullName" id="fullName" placeholder="Enter Full Name" required/>
                <input type="email" name="email" id="email" placeholder="Enter Email" required/>
                <input type="password" name="password" id="password" placeholder="Enter Password"/>

                <select name="role" id="role">
                    <option value="customer">User</option>
                    <option value="admin">Admin</option>
                </select>

                <label class="checkbox">
                    <input type="checkbox" name="status" id="status"/> Active
                </label>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="submitBtn">Save</button>
                    <button type="button" class="btn btn-danger" onclick="hideForm()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Search Form -->
    <form method="get" action="${pageContext.request.contextPath}/admin/users" class="search-form">
        <input type="text" name="keyword" placeholder="Search by name, username, or email..."
               value="${param.keyword}">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- User List -->
    <div class="admin_box_container">
        <div class="header-flex">
            <h2 class="title">User List</h2>
            <button class="btn btn-success" onclick="showAddForm()">+ Add User</button>
        </div>

        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Username</th>
                <th>Name</th>
                <th>Role</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td>#${u.userId}</td>
                    <td>${u.email}</td>
                    <td>${u.username}</td>
                    <td>${u.fullName}</td>
                    <td>${u.role}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.status}"><span class="status active">Active</span></c:when>
                            <c:otherwise><span class="status inactive">Inactive</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary"
                                onclick="showUpdateForm('${u.userId}', '${u.username}', '${u.fullName}', '${u.email}', '${u.role}', '${u.status}')">
                            Edit
                        </button>
                        <a class="btn btn-danger"
                           href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.userId}"
                           onclick="return confirm('Delete user ${u.email}?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function showAddForm() {
        document.getElementById("userForm").classList.add("active");
        document.getElementById("formTitle").innerText = "Add User";
        document.getElementById("formAction").value = "create";
        document.getElementById("submitBtn").innerText = "Add User";

        document.getElementById("userId").value = "";
        document.getElementById("username").value = "";
        document.getElementById("fullName").value = "";
        document.getElementById("email").value = "";
        document.getElementById("password").value = "";
        document.getElementById("role").value = "customer";
        document.getElementById("status").checked = false;
    }

    function showUpdateForm(id, username, fullName, email, role, status) {
        document.getElementById("userForm").classList.add("active");
        document.getElementById("formTitle").innerText = "Edit User";
        document.getElementById("formAction").value = "update";
        document.getElementById("submitBtn").innerText = "Update User";

        document.getElementById("userId").value = id;
        document.getElementById("username").value = username;
        document.getElementById("fullName").value = fullName;
        document.getElementById("email").value = email;
        document.getElementById("password").value = "";
        document.getElementById("role").value = role;
        document.getElementById("status").checked = (status === 'true' || status === '1');
    }

    function hideForm() {
        document.getElementById("userForm").classList.remove("active");
    }
</script>
</body>
</html>
