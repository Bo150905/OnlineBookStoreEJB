/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import entities.Books;
import entities.OrderItems;
import entities.Orders;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Admin
 */
@Stateless
public class OrderItemsFacade extends AbstractFacade<OrderItems> {

    @PersistenceContext(unitName = "OnlineBookStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderItemsFacade() {
        super(OrderItems.class);
    }

    public void createOrderItem(Orders order, Books book, int quantity, BigDecimal price) {
        OrderItems item = new OrderItems();
        item.setOrderId(order);
        item.setBookId(book);
        item.setQuantity(quantity);
        item.setPrice(price);
        em.persist(item);
    }

    public List<OrderItems> findByOrder(Orders order) {
        return em.createNamedQuery("OrderItems.findByOrder", OrderItems.class)
                .setParameter("order", order)
                .getResultList();
    }

}
