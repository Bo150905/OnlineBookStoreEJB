<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin - Orders</title>
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
    <h1 class="title">📦 Manage Orders</h1>

    <!-- Search -->
    <form method="get" action="${pageContext.request.contextPath}/admin/orders" class="search-form">
        <input type="text" name="keyword" placeholder="Search by user email or ID..."
               value="${param.keyword}">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- Order List -->
    <div class="admin_box_container">
        <div class="header-flex">
            <h2>Orders List</h2>
        </div>

        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>User</th>
                <th>Total</th>
                <th>Status</th>
                <th>Payment</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="o" items="${orders}">
                <tr>
                    <td>#${o.orderId}</td>
                    <td>${o.userId.email}</td>
                    <td>$ ${o.totalAmount}</td>
                    <td>${o.status}</td>
                    <td>${o.paymentStatus}</td>
                    <td>${o.shippingAddress}</td>
                    <td>${o.phone}</td>
                    <td>
                        <button type="button" class="btn btn-primary"
                                onclick="openEditModal('${o.orderId}', '${o.status}', '${o.paymentStatus}', '${o.shippingAddress}', '${o.phone}')">
                            Edit
                        </button>
                        <a class="btn btn-danger"
                           href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${o.orderId}"
                           onclick="return confirm('Delete order #${o.orderId}?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Edit Order Modal -->
<div id="editModal" class="form-card">
    <div class="form-content">
        <span class="close-btn" onclick="closeEditModal()">✖</span>
        <h2>Edit Order</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="admin-form">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editOrderId" name="id">

            <label>Status</label>
            <select id="editStatus" name="status">
                <option value="pending">Pending</option>
                <option value="confirmed">Confirmed</option>
                <option value="cancelled">Cancelled</option>
            </select>

            <label>Payment Status</label>
            <select id="editPayment" name="payment_status">
                <option value="unpaid">Unpaid</option>
                <option value="paid">Paid</option>
            </select>

            <label>Address</label>
            <input type="text" id="editAddress" name="shippingAddress" required>

            <label>Phone</label>
            <input type="text" id="editPhone" name="phone" required>

            <div class="form-actions">
                <button type="submit" class="btn btn-success">Save</button>
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditModal(id, status, payment, address, phone) {
        document.getElementById("editOrderId").value = id;
        document.getElementById("editStatus").value = status;
        document.getElementById("editPayment").value = payment;
        document.getElementById("editAddress").value = address;
        document.getElementById("editPhone").value = phone;
        document.getElementById("editModal").classList.add("active");
    }
    function closeEditModal() {
        document.getElementById("editModal").classList.remove("active");
    }
</script>

</body>
</html>
