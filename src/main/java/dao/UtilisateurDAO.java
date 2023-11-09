package dao;

import entity.Utilisateur;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

public class UtilisateurDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(Utilisateur utilisateur) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(utilisateur);
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

    public Utilisateur findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Utilisateur utilisateur = entityManager.find(Utilisateur.class, id);
        entityManager.close();
        return utilisateur;
    }

}
