package dao;

import entity.Commande;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

public class CommandeDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(Commande commande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(commande);
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

    public Commande findById(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Commande commande = entityManager.find(Commande.class, id);
        entityManager.close();
        return commande;
    }

    public List<Commande> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Commande> commandes = entityManager.createQuery("SELECT c FROM Commande c", Commande.class)
                .getResultList();
        entityManager.close();
        return commandes;
    }

    public List<Commande> findAllById(int idclient) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query = entityManager.createQuery("SELECT c FROM Commande c WHERE IdClient = :idclient", Commande.class);
        query.setParameter("idclient", idclient);

        try {
            List<Commande> commandes = query.getResultList();
            entityManager.close();
            return commandes;
        } catch (Exception e) {
            entityManager.close();
            return null;
        }
    }

    public void update(Commande commande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.merge(commande);
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

    public void delete(Commande commande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            Commande managedCommande = entityManager.merge(commande);

            entityManager.remove(managedCommande);
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
