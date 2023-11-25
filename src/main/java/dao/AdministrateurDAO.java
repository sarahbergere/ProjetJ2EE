package dao;

import entity.Administrateur;

import javax.persistence.*;
import java.util.List;

public class AdministrateurDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(Administrateur administrateur) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(administrateur);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    public Administrateur findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Administrateur administrateur = entityManager.find(Administrateur.class, id);
        entityManager.close();
        return administrateur;
    }

    public List<Administrateur> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Administrateur> administrateurs = entityManager.createQuery("SELECT a FROM Administrateur a", Administrateur.class)
                .getResultList();
        entityManager.close();
        return administrateurs;
    }

    public Administrateur findByUsername(String username) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String jpql = "SELECT a FROM Administrateur a WHERE a.idUtilisateur = (SELECT u.id FROM Utilisateur u WHERE u.pseudo = :username)";
        Query query = entityManager.createQuery(jpql, Administrateur.class);
        query.setParameter("username", username);

        List<Administrateur> admins = query.getResultList();

        if (admins.size() > 0) {
            return admins.get(0);
        }
        return null;
    }

    public String getPasswordById(int adminId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String jpql = "SELECT u.motDePasse FROM Utilisateur u JOIN Administrateur a ON u.id = a.idUtilisateur WHERE a.idUtilisateur = :adminId";
        Query query = entityManager.createQuery(jpql, String.class);
        query.setParameter("adminId", adminId);

        try {
            String password = (String) query.getSingleResult();
            return password;
        } catch (Exception e) {
            return null;
        }
    }
    public void update(Administrateur administrateur) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.merge(administrateur);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    public void delete(Administrateur administrateur) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.remove(administrateur);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }
}

