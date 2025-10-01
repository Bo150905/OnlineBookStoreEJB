package controller;

import bean.OrdersFacade;
import entities.Orders;
import entities.Users;
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

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    @EJB
    private OrdersFacade ordersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {

            List<Orders> orders = ordersFacade.findByUser(user);

            request.setAttribute("orders", orders);

            RequestDispatcher rd = request.getRequestDispatcher("orders.jsp");
            rd.forward(request, response);

        } catch (ServletException | IOException e) {
            session.setAttribute("error", "Unable to load orders: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}
