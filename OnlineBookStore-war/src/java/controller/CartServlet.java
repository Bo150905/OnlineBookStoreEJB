package controller;

import bean.CartFacade;
import bean.BooksFacade;
import entities.Cart;
import entities.Users;
import entities.Books;
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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @EJB
    private CartFacade cartFacade;

    @EJB
    private BooksFacade booksFacade;

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

        int cartSize = cartItems.stream().mapToInt(Cart::getQuantity).sum();
        session.setAttribute("cartSize", cartSize);

        RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
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

        String action = request.getParameter("action");

        try {
            if (null != action) switch (action) {
                case "update":{
                    String cartIdStr = request.getParameter("cartId");
                    String qtyStr = request.getParameter("quantity");
                    if (cartIdStr != null && qtyStr != null) {
                        int cartId = Integer.parseInt(cartIdStr);
                        int qty = Integer.parseInt(qtyStr);
                        
                        Cart c = cartFacade.find(cartId);
                        if (c != null && c.getUserId().equals(user)) {
                            if (qty > 0) {
                                c.setQuantity(qty);
                                cartFacade.edit(c);
                            } else {
                                cartFacade.remove(c);
                            }
                        }
                    }       break;
                    }
                case "delete":{
                    String cartIdStr = request.getParameter("cartId");
                    if (cartIdStr != null) {
                        int cartId = Integer.parseInt(cartIdStr);
                        Cart c = cartFacade.find(cartId);
                        if (c != null && c.getUserId().equals(user)) {
                            cartFacade.remove(c);
                        }
                    }       break;
                    }
                case "clear":
                    List<Cart> cartItems = cartFacade.findByUser(user);
                    for (Cart c : cartItems) {
                        cartFacade.remove(c);
                    }   break;
                case "add":{
                    String bookIdStr = request.getParameter("bookId");
                    String qtyStr = request.getParameter("quantity");
                    if (bookIdStr != null && qtyStr != null) {
                        int bookId = Integer.parseInt(bookIdStr);
                        int qty = Integer.parseInt(qtyStr);
                        
                        Books book = booksFacade.find(bookId);
                        if (book != null) {
                            Cart c = cartFacade.findByUserAndBook(user, book);
                            if (c != null) {
                                c.setQuantity(c.getQuantity() + qty);
                                cartFacade.edit(c);
                            } else {
                                Cart newCart = new Cart();
                                newCart.setUserId(user);
                                newCart.setBookId(book);
                                newCart.setQuantity(qty);
                                newCart.setCreatedAt(new Date());
                                cartFacade.create(newCart);
                            }
                        }
                    }       break;
                    }
                default:
                    break;
            }

        } catch (NumberFormatException e) {
        }

        response.sendRedirect("cart");
    }
}
