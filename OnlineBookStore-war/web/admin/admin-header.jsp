<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

<div class="sidebar">
    <div class="logo">📚 Admin</div>

    <nav class="menu">
        <a href="${pageContext.request.contextPath}/admin/admin-dashboard" 
           class="${pageContext.request.requestURI.endsWith('/admin-dashboard') ? 'active' : ''}">
            <i class="fa fa-home"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/books" 
           class="${pageContext.request.requestURI.endsWith('/books') ? 'active' : ''}">
            <i class="fa fa-book"></i> Products
        </a>
        <a href="${pageContext.request.contextPath}/admin/categories" 
           class="${pageContext.request.requestURI.endsWith('/categories') ? 'active' : ''}">
            <i class="fa fa-list"></i> Categories
        </a>
        <a href="${pageContext.request.contextPath}/admin/orders" 
           class="${pageContext.request.requestURI.endsWith('/orders') ? 'active' : ''}">
            <i class="fa fa-shopping-cart"></i> Orders
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" 
           class="${pageContext.request.requestURI.endsWith('/users') ? 'active' : ''}">
            <i class="fa fa-users"></i> Users
        </a>
        <a href="${pageContext.request.contextPath}/admin/messages" 
           class="${pageContext.request.requestURI.endsWith('/messages') ? 'active' : ''}">
            <i class="fa fa-envelope"></i> Messages
        </a>
    </nav>

    <div class="user" id="userMenu">
        <span><i class="fa fa-user"></i> ${sessionScope.user.username}</span>
        <i class="fa fa-caret-down"></i>
        <div class="user-dropdown">
            <p><strong>${sessionScope.user.username}</strong></p>
            <p>${sessionScope.user.email}</p>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                <i class="fa fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</div>

<div class="topbar"></div>

<script>
    const userMenu = document.getElementById("userMenu");
    userMenu.addEventListener("click", (e) => {
        e.stopPropagation();
        userMenu.classList.toggle("open");
    });
    document.addEventListener("click", () => {
        userMenu.classList.remove("open");
    });
</script>
