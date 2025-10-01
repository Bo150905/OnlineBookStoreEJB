package controller.admin;

import bean.BooksFacade;
import bean.CategoriesFacade;
import entities.Books;
import entities.Categories;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/books")
@MultipartConfig
public class AdminBooksServlet extends HttpServlet {

    @EJB
    private BooksFacade booksFacade;

    @EJB
    private CategoriesFacade categoriesFacade; // ✅ thêm facade cho Categories

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

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Books book = booksFacade.find(id);
                request.setAttribute("book", book);
            }

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Books book = booksFacade.find(id);
                if (book != null) {
                    booksFacade.remove(book);
                }
                response.sendRedirect(request.getContextPath() + "/admin/books");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String keyword = request.getParameter("keyword");
        List<Books> books;
        if (keyword != null && !keyword.trim().isEmpty()) {
            books = booksFacade.search(keyword);
        } else {
            books = booksFacade.findAll();
        }

        // ✅ load categories
        List<Categories> categories = categoriesFacade.findAll();
        request.setAttribute("categories", categories);

        request.setAttribute("books", books);
        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-books.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");

        BigDecimal price = BigDecimal.ZERO;
        int stock = 0;
        try {
            if (priceStr != null && !priceStr.isEmpty()) {
                price = new BigDecimal(priceStr);
            }
            if (stockStr != null && !stockStr.isEmpty()) {
                stock = Integer.parseInt(stockStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Books book;
        if (idStr == null || idStr.isEmpty()) {
            book = new Books();
            book.setCreatedAt(new Date());
        } else {
            int id = Integer.parseInt(idStr);
            book = booksFacade.find(id);
        }

        book.setTitle(title);
        book.setAuthor(author);
        book.setDescription(description);
        book.setPrice(price);
        book.setStock(stock);

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            Categories category = categoriesFacade.find(Integer.parseInt(categoryIdStr));
            book.setCategoryId(category);
        }

        Part filePart = request.getPart("coverImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadDir = getServletContext().getRealPath("/assets/images");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File file = new File(dir, fileName);

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            book.setCoverImage(fileName);
        }

        if (book.getBookId() == null) {
            booksFacade.create(book);
        } else {
            booksFacade.edit(book);
        }

        response.sendRedirect(request.getContextPath() + "/admin/books");
    }
}
