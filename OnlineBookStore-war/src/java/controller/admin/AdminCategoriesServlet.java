package controller.admin;

import bean.CategoriesFacade;
import entities.Categories;
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

@WebServlet("/admin/categories")
public class AdminCategoriesServlet extends HttpServlet {

    @EJB
    private CategoriesFacade categoriesFacade;

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

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Categories c = categoriesFacade.find(id);
            request.setAttribute("category", c);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Categories c = categoriesFacade.find(id);
            if (c != null) categoriesFacade.remove(c);
            response.sendRedirect("categories");
            return;
        }

        // 🔎 Xử lý search
        String keyword = request.getParameter("keyword");
        List<Categories> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = categoriesFacade.searchByName(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else {
            list = categoriesFacade.findAll();
        }

        request.setAttribute("categories", list);

        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-categories.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");

        Categories c;
        if (idStr == null || idStr.isEmpty()) {
            c = new Categories();
        } else {
            c = categoriesFacade.find(Integer.valueOf(idStr));
        }

        c.setName(name);

        if (c.getCategoryId() == null) {
            categoriesFacade.create(c);
        } else {
            categoriesFacade.edit(c);
        }

        response.sendRedirect("categories");
    }
}
