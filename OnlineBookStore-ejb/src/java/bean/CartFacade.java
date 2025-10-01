/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import entities.Books;
import entities.Cart;
import entities.Users;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 *
 * @author Admin
 */
@Stateless
public class CartFacade extends AbstractFacade<Cart> {

    @PersistenceContext(unitName = "OnlineBookStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CartFacade() {
        super(Cart.class);
    }

    public List<Cart> findByUser(Users user) {
        return em.createQuery("SELECT c FROM Cart c WHERE c.userId = :user", Cart.class)
                .setParameter("user", user)
                .getResultList();
    }

    public Cart findByUserAndBook(Users user, Books book) {
        try {
            return em.createQuery("SELECT c FROM Cart c WHERE c.userId = :user AND c.bookId = :book", Cart.class)
                    .setParameter("user", user)
                    .setParameter("book", book)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

}
