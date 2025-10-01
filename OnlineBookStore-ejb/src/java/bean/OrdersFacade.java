/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import entities.Orders;
import entities.Users;
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
public class OrdersFacade extends AbstractFacade<Orders> {

    @PersistenceContext(unitName = "OnlineBookStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrdersFacade() {
        super(Orders.class);
    }

    public List<Orders> findByUser(Users user) {
        return em.createQuery(
                "SELECT o FROM Orders o WHERE o.userId = :user ORDER BY o.orderDate DESC",
                Orders.class
        )
                .setParameter("user", user)
                .getResultList();
    }

    public long countOrders() {
        return em.createQuery("SELECT COUNT(o) FROM Orders o", Long.class)
                .getSingleResult();
    }

    public BigDecimal sumByStatus(String status) {
        return em.createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Orders o WHERE o.status = :status",
                BigDecimal.class)
                .setParameter("status", status)
                .getSingleResult();
    }

    public BigDecimal sumByPaymentStatus(String paymentStatus) {
        return em.createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Orders o WHERE o.paymentStatus = :paymentStatus",
                BigDecimal.class)
                .setParameter("paymentStatus", paymentStatus)
                .getSingleResult();
    }

    @Override
    public void edit(Orders entity) {
        em.merge(entity);
        em.flush();
    }

    public void flushAndRefresh(Orders order) {
        em.flush();
        em.refresh(order);
    }

}
