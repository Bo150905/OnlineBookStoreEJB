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

@WebServlet("/bookDetail")
public class BookDetailServlet extends HttpServlet {

    @EJB
    private BooksFacade booksFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        Books book = null;

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                book = booksFacade.find(id);
            } catch (NumberFormatException e) {
                book = null;
            }
        }

        request.setAttribute("book", book);
        RequestDispatcher rd = request.getRequestDispatcher("bookDetail.jsp");
        rd.forward(request, response);
    }
}
