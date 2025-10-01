package controller;

import bean.UsersFacade;
import entities.Users;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @EJB
    private UsersFacade usersFacade;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form inputs
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");

        Users existingUser = usersFacade.findByUsername(username);
        if (existingUser != null) {
            request.setAttribute("error", "Username is already taken. Please choose another one.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Users user = new Users();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setRole("customer");
        user.setStatus(true);
        user.setCreatedAt(new Date());

        usersFacade.create(user);

        response.sendRedirect("login.jsp");
    }
}
