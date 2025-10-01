/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import entities.Books;
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
public class BooksFacade extends AbstractFacade<Books> {

    @PersistenceContext(unitName = "OnlineBookStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public BooksFacade() {
        super(Books.class);
    }

    public List<Books> search(String keyword) {
        return em.createQuery("SELECT b FROM Books b WHERE b.title LIKE :kw OR b.author LIKE :kw", Books.class)
                .setParameter("kw", "%" + keyword + "%")
                .getResultList();
    }

    @Override
    public List<Books> findAll() {
        return em.createQuery("SELECT b FROM Books b ORDER BY b.createdAt DESC", Books.class)
                .getResultList();
    }

    @Override
    public Books find(Object id) {
        if (id == null) {
            return null;
        }
        return em.find(Books.class, id);
    }

    public List<Books> searchByKeyword(String keyword) {
        return em.createQuery(
                "SELECT b FROM Books b WHERE LOWER(b.title) LIKE :kw OR LOWER(b.author) LIKE :kw",
                Books.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public long countBooks() {
        return em.createQuery("SELECT COUNT(b) FROM Books b", Long.class)
                .getSingleResult();
    }

    public List<Books> findRange(int start, int max) {
        return em.createQuery("SELECT b FROM Books b ORDER BY b.bookId DESC", Books.class)
                .setFirstResult(start)
                .setMaxResults(max)
                .getResultList();
    }

    public List<Books> searchByTitleOrAuthor(String keyword) {
        return em.createQuery(
                "SELECT b FROM Books b WHERE LOWER(b.title) LIKE :kw OR LOWER(b.author) LIKE :kw", Books.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

}
