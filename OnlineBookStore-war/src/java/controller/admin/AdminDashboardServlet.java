package controller.admin;

import bean.BooksFacade;
import bean.OrdersFacade;
import bean.UsersFacade;
import bean.FeedbackFacade;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @EJB
    private BooksFacade booksFacade;

    @EJB
    private OrdersFacade ordersFacade;

    @EJB
    private UsersFacade usersFacade;

    @EJB
    private FeedbackFacade feedbackFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null
                || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        BigDecimal pendingPayments   = ordersFacade.sumByStatus("pending");
        BigDecimal completedPayments = ordersFacade.sumByStatus("confirmed");

        long ordersCount   = ordersFacade.countOrders();
        long booksCount    = booksFacade.countBooks();
        long usersCount    = usersFacade.countUsers();
        long adminsCount   = usersFacade.countAdmins();
        long totalAccounts = usersFacade.countAccounts();
        long newMessages   = feedbackFacade.countNewMessages();

        request.setAttribute("pendingPayments", pendingPayments);
        request.setAttribute("completedPayments", completedPayments);
        request.setAttribute("ordersCount", ordersCount);
        request.setAttribute("booksCount", booksCount);
        request.setAttribute("usersCount", usersCount);
        request.setAttribute("adminsCount", adminsCount);
        request.setAttribute("totalAccounts", totalAccounts);
        request.setAttribute("newMessages", newMessages);

        request.getRequestDispatcher("/admin/admin-dashboard.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
