package controller.admin;

import bean.FeedbackFacade;
import entities.Feedback;
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

@WebServlet("/admin/messages")
public class AdminMessageServlet extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action != null && idParam != null) {
            int id = Integer.parseInt(idParam);
            Feedback f = feedbackFacade.find(id);

            if (f != null) {
                switch (action) {
                    case "delete":
                        feedbackFacade.remove(f);
                        break;
                    case "approve":
                        f.setStatus("approved");
                        feedbackFacade.edit(f);
                        break;
                }
            }

            response.sendRedirect("messages");
            return;
        }

        String keyword = request.getParameter("keyword");
        List<Feedback> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            list = feedbackFacade.searchByKeyword(keyword);
        } else {
            list = feedbackFacade.findAll();
        }

        request.setAttribute("messages", list);

        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-messages.jsp");
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

        String action = request.getParameter("action");

        if ("reply".equals(action)) {
            String idParam = request.getParameter("id");
            String reply = request.getParameter("reply");

            if (idParam != null && reply != null && !reply.trim().isEmpty()) {
                int id = Integer.parseInt(idParam);
                Feedback f = feedbackFacade.find(id);

                if (f != null) {
                    f.setReply(reply);
                    feedbackFacade.edit(f);
                }
            }
        }

        response.sendRedirect("messages");
    }
}
