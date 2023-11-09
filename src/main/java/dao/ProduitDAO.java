package dao;
import entity.Produit;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import java.util.List;

public class ProduitDAO {

    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(Produit produit) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(produit);
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

    public Produit findById(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Produit produit = entityManager.find(Produit.class, id);
        entityManager.close();
        return produit;
    }

    public void update(Produit produit) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.merge(produit);
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

    public void delete(Produit produit) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.remove(entityManager.contains(produit) ? produit : entityManager.merge(produit));
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

    public List<Produit> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Produit> produits = entityManager.createQuery("SELECT p FROM Produit p", Produit.class)
                .getResultList();
        entityManager.close();
        return produits;
    }
}
