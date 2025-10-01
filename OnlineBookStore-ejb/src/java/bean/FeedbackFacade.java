/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import entities.Feedback;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 *
 * @author Admin
 */
@Stateless
public class FeedbackFacade extends AbstractFacade<Feedback> {

    @PersistenceContext(unitName = "OnlineBookStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FeedbackFacade() {
        super(Feedback.class);
    }

    public List<Feedback> findApproved() {
        return em.createQuery("SELECT f FROM Feedback f WHERE f.status = :status ORDER BY f.createdAt DESC", Feedback.class)
                .setParameter("status", "approved")
                .getResultList();
    }

    public List<Feedback> searchByKeyword(String keyword) {
        return em.createQuery("SELECT f FROM Feedback f WHERE LOWER(f.name) LIKE :kw OR LOWER(f.email) LIKE :kw", Feedback.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public long countNewMessages() {
        return em.createQuery(
                "SELECT COUNT(f) FROM Feedback f WHERE f.status = 'pending'",
                Long.class
        ).getSingleResult();
    }

    public long countFeedback() {
        return em.createQuery(
                "SELECT COUNT(f) FROM Feedback f",
                Long.class
        ).getSingleResult();
    }
}
