<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<jsp:include page="/admin/admin-header.jsp"/>

<div class="main-content">
    <h1 class="title">Admin Dashboard</h1>

    <div class="chart-container" style="margin-top: 20px; background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.08);">
        <canvas id="overallChart"></canvas>
    </div>
</div>

<script>
    const ctx = document.getElementById('overallChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                'Pending Payments',
                'Completed Payments',
                'Total Orders',
                'Total Books',
                'Users',
                'Admins',
                'Total Accounts',
                'New Messages'
            ],
            datasets: [{
                label: 'Statistics',
                data: [
                    ${pendingPayments},
                    ${completedPayments},
                    ${ordersCount},
                    ${booksCount},
                    ${usersCount},
                    ${adminsCount},
                    ${totalAccounts},
                    ${newMessages}
                ],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(255, 159, 64, 0.7)',
                    'rgba(153, 102, 255, 0.7)',
                    'rgba(0, 128, 128, 0.7)',
                    'rgba(50, 50, 50, 0.7)',
                    'rgba(255, 205, 86, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(0, 128, 128, 1)',
                    'rgba(50, 50, 50, 1)',
                    'rgba(255, 205, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>
