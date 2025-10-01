package controller;

import bean.BooksFacade;
import entities.Books;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @EJB
    private BooksFacade booksFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<Books> books = null;

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                books = booksFacade.searchByTitleOrAuthor(keyword);
            }
        } catch (Exception e) {
        }

        request.setAttribute("keyword", keyword);
        request.setAttribute("books", books);

        RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
        rd.forward(request, response);
    }
}
