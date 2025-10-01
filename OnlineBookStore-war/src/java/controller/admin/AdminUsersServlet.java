package controller.admin;

import bean.UsersFacade;
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

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    @EJB
    private UsersFacade usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        // Kiểm tra quyền admin
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");

        // Delete
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Users u = usersFacade.find(id);
            if (u != null) {
                usersFacade.remove(u);
            }
            response.sendRedirect("users");
            return;
        }

        // List + Search
        List<Users> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = usersFacade.search(keyword.trim());
        } else {
            list = usersFacade.findAll();
        }
        request.setAttribute("users", list);

        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-users.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            Users u = new Users();
            u.setUsername(request.getParameter("username"));
            u.setFullName(request.getParameter("fullName"));
            u.setEmail(request.getParameter("email"));
            u.setPassword(request.getParameter("password")); // TODO: mã hóa password
            u.setRole(request.getParameter("role"));
            u.setStatus(request.getParameter("status") != null);

            usersFacade.create(u);
        }

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Users u = usersFacade.find(id);

            if (u != null) {
                u.setUsername(request.getParameter("username"));
                u.setFullName(request.getParameter("fullName"));
                u.setEmail(request.getParameter("email"));
                u.setRole(request.getParameter("role"));
                u.setStatus(request.getParameter("status") != null);

                usersFacade.edit(u);
            }
        }

        response.sendRedirect("users");
    }
}
