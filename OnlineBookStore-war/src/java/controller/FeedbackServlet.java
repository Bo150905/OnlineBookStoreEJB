package controller;

import bean.FeedbackFacade;
import entities.Feedback;
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
import java.util.Date;
import java.util.List;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Feedback> feedbacks = feedbackFacade.findApproved();

        request.setAttribute("feedbacks", feedbacks);

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("msg") != null) {
            request.setAttribute("msg", session.getAttribute("msg"));
            session.removeAttribute("msg"); // xóa để không bị hiển thị lại
        }

        RequestDispatcher rd = request.getRequestDispatcher("feedback.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (message == null || message.trim().isEmpty()) {
            session.setAttribute("msg", "⚠️ Message cannot be empty!");
            response.sendRedirect("feedback");
            return;
        }

        if ((user == null) && (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty())) {
            session.setAttribute("msg", "⚠️ Name and Email are required!");
            response.sendRedirect("feedback");
            return;
        }

        Feedback fb = new Feedback();
        fb.setMessage(message.trim());
        fb.setCreatedAt(new Date());
        fb.setStatus("pending");

        if (user != null) {
            fb.setUserId(user.getUserId());
            fb.setName(user.getFullName());
            fb.setEmail(user.getEmail());
        } else {
            fb.setName(name.trim());
            fb.setEmail(email.trim());
        }

        feedbackFacade.create(fb);

        session.setAttribute("msg", "✅ Thank you for your feedback! We will review it soon.");
        response.sendRedirect("feedback");
    }
}
