package bean;

import entities.Users;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.List;

@Stateless
public class UsersFacade extends AbstractFacade<Users> {

    @PersistenceContext(unitName = "OnlineBookStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsersFacade() {
        super(Users.class);
    }

    public Users findByUsername(String username) {
        TypedQuery<Users> query = em.createQuery(
                "SELECT u FROM Users u WHERE u.username = :username", Users.class);
        query.setParameter("username", username);
        return query.getResultStream().findFirst().orElse(null);
    }

    public Users findByUsernameAndPassword(String username, String password) {
        try {
            return em.createQuery(
                    "SELECT u FROM Users u WHERE u.username = :username AND u.password = :password",
                    Users.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Users> findByUsernameOrEmail(String keyword) {
        return em.createQuery(
                "SELECT u FROM Users u WHERE u.username LIKE :kw OR u.email LIKE :kw",
                Users.class)
                .setParameter("kw", "%" + keyword + "%")
                .getResultList();
    }

    public List<Users> searchByUsernameOrEmail(String keyword) {
        return em.createQuery(
                "SELECT u FROM Users u WHERE LOWER(u.username) LIKE :kw OR LOWER(u.email) LIKE :kw",
                Users.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public Users findByEmailAndPassword(String email, String password) {
        try {
            TypedQuery<Users> query = em.createQuery(
                    "SELECT u FROM Users u WHERE u.email = :email AND u.password = :password", Users.class);
            query.setParameter("email", email);
            query.setParameter("password", password);

            List<Users> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public Users findByEmail(String email) {
        try {
            TypedQuery<Users> query = em.createQuery(
                    "SELECT u FROM Users u WHERE u.email = :email", Users.class);
            query.setParameter("email", email);

            List<Users> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public Users login(String email, String password) {
        try {
            return em.createQuery("SELECT u FROM Users u WHERE u.email = :email AND u.password = :pass", Users.class)
                    .setParameter("email", email)
                    .setParameter("pass", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public long countUsers() {
        return em.createQuery(
                "SELECT COUNT(u) FROM Users u WHERE u.role = 'customer'",
                Long.class
        ).getSingleResult();
    }

    public long countAdmins() {
        return em.createQuery(
                "SELECT COUNT(u) FROM Users u WHERE u.role = 'admin'",
                Long.class
        ).getSingleResult();
    }

    public long countAccounts() {
        return em.createQuery(
                "SELECT COUNT(u) FROM Users u",
                Long.class
        ).getSingleResult();
    }
    public List<Users> search(String keyword) {
        return em.createQuery(
                "SELECT u FROM Users u WHERE " +
                "LOWER(u.username) LIKE :kw OR " +
                "LOWER(u.fullName) LIKE :kw OR " +
                "LOWER(u.email) LIKE :kw", Users.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }
}
