package dao;

import entity.CompteBancaire;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import java.util.List;

public class CompteBancaireDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(CompteBancaire compteBancaire) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(compteBancaire);
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

    public CompteBancaire findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        CompteBancaire compteBancaire = entityManager.find(CompteBancaire.class, id);
        entityManager.close();
        return compteBancaire;
    }

    public List<CompteBancaire> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<CompteBancaire> comptesBancaires = entityManager.createQuery("SELECT c FROM CompteBancaire c", CompteBancaire.class)
                .getResultList();
        entityManager.close();
        return comptesBancaires;
    }

    public void update(CompteBancaire compteBancaire) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.merge(compteBancaire);
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

    public void delete(CompteBancaire compteBancaire) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.remove(compteBancaire);
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

