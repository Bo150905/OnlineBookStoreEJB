<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin - Books</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>
        <style>
            .form-card {
                display: none;
            }
            .form-card.active {
                display: flex;
            } /* popup form hiển thị khi active */
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
            <h1 class="title">Manage Books</h1>

            <!-- Form Add/Edit (popup) -->
            <div id="bookForm" class="form-card">
                <div class="form-content">
                    <span style="float:right; cursor:pointer; font-size:18px; color:#999;" onclick="hideForm()">✖</span>
                    <h2 id="formTitle">Add Product</h2>
                    <form method="post" action="${pageContext.request.contextPath}/admin/books" 
                          enctype="multipart/form-data" class="admin-form">
                        <input type="hidden" name="id" id="bookId"/>

                        <input type="text" name="title" id="title" placeholder="Enter Book Title" required/>
                        <input type="text" name="author" id="author" placeholder="Enter Author" required/>
                        <textarea name="description" id="description" placeholder="Enter Description"></textarea>
                        <input type="number" step="0.01" name="price" id="price" placeholder="Enter Book Price" required/>
                        <input type="number" name="stock" id="stock" placeholder="Enter Stock Quantity" required/>

                        <select name="categoryId" id="categoryId" required>
                            <option value="">-- Select Category --</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.categoryId}">${c.name}</option>
                            </c:forEach>
                        </select>

                        <input type="file" name="coverImage"/>
                        <div id="previewContainer" class="preview-img" style="display:none;">
                            <img id="previewImg" src="" width="120"/>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary" id="submitBtn">Add Product</button>
                            <button type="button" class="btn btn-danger" onclick="hideForm()">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Search Form -->
            <form class="search-form" method="get" action="${pageContext.request.contextPath}/admin/books">
                <input type="text" name="keyword" placeholder="Search by title or author..."
                       value="${param.keyword}"/>
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <!-- Book List -->
            <div class="admin_box_container">
                <div class="header-flex">
                    <h2 class="title">Book List</h2>
                    <!-- Nút Add đặt cạnh tiêu đề -->
                    <button class="btn btn-success" onclick="showAddForm()">+ Add Book</button>
                </div>

                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cover</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Category</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${books}">
                            <tr>
                                <td>${b.bookId}</td>
                                <td>
                                    <c:if test="${not empty b.coverImage}">
                                        <img src="${pageContext.request.contextPath}/assets/images/${b.coverImage}"
                                             alt="${b.title}" width="60" height="80"
                                             style="object-fit:cover; border-radius:6px;"/>
                                    </c:if>
                                </td>
                                <td>${b.title}</td>
                                <td>${b.author}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:length(b.description) > 100}">
                                            ${fn:substring(b.description, 0, 100)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${b.description}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>$ ${b.price}</td>
                                <td>${b.stock}</td>
                                <td>
                                    <c:if test="${not empty b.categoryId}">
                                        ${b.categoryId.name}
                                    </c:if>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-primary"
                                            onclick="showUpdateForm('${b.bookId}', '${b.title}', '${b.author}',
                            '${fn:escapeXml(b.description)}', '${b.price}', '${b.stock}',
                            '${b.categoryId != null ? b.categoryId.categoryId : ""}',
                            '${b.coverImage}')">
                                        Edit
                                    </button>
                                    <a class="btn btn-danger"
                                       href="${pageContext.request.contextPath}/admin/books?action=delete&id=${b.bookId}"
                                       onclick="return confirm('Delete this book?');">
                                        Delete
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function showAddForm() {
                document.getElementById("bookForm").classList.add("active");
                document.getElementById("formTitle").innerText = "Add Product";
                document.getElementById("submitBtn").innerText = "Add Product";

                document.getElementById("bookId").value = "";
                document.getElementById("title").value = "";
                document.getElementById("author").value = "";
                document.getElementById("description").value = "";
                document.getElementById("price").value = "";
                document.getElementById("stock").value = "";
                document.getElementById("categoryId").value = "";
                document.getElementById("previewContainer").style.display = "none";
            }

            function showUpdateForm(id, title, author, description, price, stock, categoryId, coverImage) {
                document.getElementById("bookForm").classList.add("active");
                document.getElementById("formTitle").innerText = "Edit Book";
                document.getElementById("submitBtn").innerText = "Update Book";

                document.getElementById("bookId").value = id;
                document.getElementById("title").value = title;
                document.getElementById("author").value = author;
                document.getElementById("description").value = description;
                document.getElementById("price").value = price;
                document.getElementById("stock").value = stock;
                document.getElementById("categoryId").value = categoryId;

                if (coverImage) {
                    document.getElementById("previewImg").src = "${pageContext.request.contextPath}/assets/images/" + coverImage;
                    document.getElementById("previewContainer").style.display = "block";
                } else {
                    document.getElementById("previewContainer").style.display = "none";
                }
            }

            function hideForm() {
                document.getElementById("bookForm").classList.remove("active");
            }
        </script>
    </body>
</html>
