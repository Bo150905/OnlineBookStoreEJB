package controller;

import bean.CartFacade;
import bean.OrdersFacade;
import bean.OrderItemsFacade;
import entities.Cart;
import entities.Orders;
import entities.OrderItems;
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
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @EJB
    private CartFacade cartFacade;

    @EJB
    private OrdersFacade ordersFacade;

    @EJB
    private OrderItemsFacade orderItemsFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Cart> cartItems = cartFacade.findByUser(user);
        request.setAttribute("cartItems", cartItems);

        RequestDispatcher rd = request.getRequestDispatcher("checkout.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String note = request.getParameter("note");
            String paymentMethod = request.getParameter("paymentMethod");

            List<Cart> cartItems = cartFacade.findByUser(user);

            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            BigDecimal total = BigDecimal.ZERO;
            for (Cart c : cartItems) {
                BigDecimal price = c.getBookId().getPrice();
                BigDecimal qty = BigDecimal.valueOf(c.getQuantity());
                total = total.add(price.multiply(qty));
            }

            Orders order = new Orders();
            order.setUserId(user);
            order.setOrderDate(new Date());
            order.setTotalAmount(total);
            order.setStatus("pending");
            order.setShippingAddress(address);
            order.setPhone(phone);
            order.setNote(note);
            order.setPaymentMethod(paymentMethod);
            order.setPaymentStatus("unpaid");

            ordersFacade.create(order);
            for (Cart c : cartItems) {
                OrderItems item = new OrderItems();
                item.setOrderId(order);
                item.setBookId(c.getBookId());
                item.setQuantity(c.getQuantity());
                item.setPrice(c.getBookId().getPrice());

                BigDecimal itemTotal = c.getBookId().getPrice()
                        .multiply(BigDecimal.valueOf(c.getQuantity()));
                item.setTotal(itemTotal);

                System.out.println("DEBUG: OrderItem => "
                        + c.getBookId().getTitle() + " | qty=" + c.getQuantity()
                        + " | price=" + c.getBookId().getPrice()
                        + " | total=" + itemTotal);

                orderItemsFacade.create(item);

                c.getBookId().setStock(c.getBookId().getStock() - c.getQuantity());
            }

            for (Cart c : cartItems) {
                cartFacade.remove(c);
            }

            session.setAttribute("message", "Order placed successfully!");
            response.sendRedirect("order-success.jsp");

        } catch (IOException e) {
            session.setAttribute("error", "Checkout failed: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}
