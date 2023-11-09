package dao;
import entity.DetailCommande;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import java.util.List;

public class DetailCommandeDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(DetailCommande detailCommande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(detailCommande);
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

    public DetailCommande findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        DetailCommande detailCommande = entityManager.find(DetailCommande.class, id);
        entityManager.close();
        return detailCommande;
    }

    public List<DetailCommande> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<DetailCommande> detailCommandes = entityManager.createQuery("SELECT dc FROM DetailCommande dc", DetailCommande.class)
                .getResultList();
        entityManager.close();
        return detailCommandes;
    }

    public void update(DetailCommande detailCommande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.merge(detailCommande);
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

    public void delete(DetailCommande detailCommande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.remove(detailCommande);
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

