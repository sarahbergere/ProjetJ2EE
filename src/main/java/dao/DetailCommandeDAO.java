package dao;
import entity.Commande;
import entity.DetailCommande;

import javax.persistence.*;
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

    public List<DetailCommande> findByCommande(Commande commande) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String jpql = "SELECT dc FROM DetailCommande dc WHERE dc.commande = :commande";
        TypedQuery<DetailCommande> query = entityManager.createQuery(jpql, DetailCommande.class);
        query.setParameter("commande", commande);
        return query.getResultList();
    }
}

