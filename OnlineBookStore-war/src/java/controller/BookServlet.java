package controller;

import bean.BooksFacade;
import entities.Books;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookServlet", urlPatterns = {"/books", "/home", "/index"})
public class BookServlet extends HttpServlet {

    @EJB
    private BooksFacade booksFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath(); 
        String search = request.getParameter("search");
        List<Books> books;

        if (search != null && !search.trim().isEmpty()) {
            books = booksFacade.searchByKeyword(search);
            request.setAttribute("search", search);
        } else {
            books = booksFacade.findAll();
        }

        System.out.println("Books size (" + path + "): " + (books != null ? books.size() : "null"));

        if ("/books".equals(path)) {
            request.setAttribute("books", books);
            request.getRequestDispatcher("/books.jsp").forward(request, response);

        } else {
            List<Books> featuredBooks = books.size() > 10 ? books.subList(0, 10) : books;
            request.setAttribute("featuredBooks", featuredBooks);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
