<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin - Categories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>
    <script>
        function openForm(isEdit = false, id = '', name = '') {
            const form = document.getElementById("categoryForm");
            const title = document.getElementById("formTitle");
            const submitBtn = document.getElementById("submitBtn");

            if (isEdit) {
                title.innerText = "Edit Category";
                submitBtn.innerText = "Update";
                document.getElementById("categoryId").value = id;
                document.getElementById("name").value = name;
            } else {
                title.innerText = "Add Category";
                submitBtn.innerText = "Add";
                document.getElementById("categoryId").value = "";
                document.getElementById("name").value = "";
            }

            form.classList.add("active");
        }

        function closeForm() {
            document.getElementById("categoryForm").classList.remove("active");
        }
    </script>
</head>
<body>
<jsp:include page="admin-header.jsp"/>

<div class="main-content">
    <h1 class="title">📂 Manage Categories</h1>

    <!-- Form popup -->
    <div class="form-card" id="categoryForm">
        <div class="form-content">
            <span style="float:right; cursor:pointer; font-size:18px; color:#999;" onclick="closeForm()">✖</span>
            <h2 id="formTitle">Add Category</h2>
            <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                <input type="hidden" id="categoryId" name="id"/>

                <label for="name">Category Name</label>
                <input type="text" id="name" name="name" required/>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="submitBtn">Add</button>
                    <button type="button" class="btn btn-secondary" onclick="closeForm()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Search form -->
    <form action="${pageContext.request.contextPath}/admin/categories" method="get" class="search-form">
        <input type="text" name="keyword" placeholder="Search category..." value="${param.keyword}"/>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- Danh sách category -->
    <div class="admin_box_container">
        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:10px;">
            <h2 style="margin:0;">Category List</h2>
            <!-- Nút mở form Add ngay bên trên bảng -->
            <button class="btn btn-success" onclick="openForm(false)">+ Add Category</button>
        </div>

        <table class="admin-table">
            <colgroup>
                <col style="width:10%">
                <col style="width:70%">
                <col style="width:20%">
            </colgroup>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${categories}">
                <tr>
                    <td>${c.categoryId}</td>
                    <td>${c.name}</td>
                    <td>
                        <button type="button" class="btn btn-primary"
                                onclick="openForm(true, '${c.categoryId}', '${c.name}')">Edit</button>
                        <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.categoryId}" 
                           class="btn btn-danger"
                           onclick="return confirm('Delete this category?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
