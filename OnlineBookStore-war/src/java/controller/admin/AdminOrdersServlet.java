package controller.admin;

import bean.OrdersFacade;
import entities.Orders;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    @EJB
    private OrdersFacade ordersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // Xóa đơn hàng
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Orders o = ordersFacade.find(id);
                if (o != null) {
                    ordersFacade.remove(o);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        // Lấy danh sách orders
        List<Orders> list = ordersFacade.findAll();

        // Tìm kiếm theo ID hoặc email
        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            String kw = keyword.trim().toLowerCase();
            list = list.stream()
                    .filter(o -> String.valueOf(o.getOrderId()).contains(kw)
                            || (o.getUserId() != null && o.getUserId().getEmail().toLowerCase().contains(kw)))
                    .collect(Collectors.toList());
        }

        request.setAttribute("orders", list);

        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-orders.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String paymentStatus = request.getParameter("payment_status");

            Orders o = ordersFacade.find(id);
            if (o != null) {
                if (status != null && !status.isEmpty()) {
                    o.setStatus(status.trim());
                }
                if (paymentStatus != null && !paymentStatus.isEmpty()) {
                    o.setPaymentStatus(paymentStatus.trim());
                }
                ordersFacade.edit(o);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
