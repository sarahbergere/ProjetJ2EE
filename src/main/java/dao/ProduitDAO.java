package dao;
import entity.DetailCommande;
import entity.Produit;

import javax.persistence.*;
import java.util.List;
import java.util.logging.Logger;

public class ProduitDAO {
    private static final Logger logger = Logger.getLogger(ProduitDAO.class.getName());
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

    public boolean delete(Produit produit) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        boolean isDeleted = false;

        try {
            transaction.begin();

            List<DetailCommande> detailsBefore = entityManager.createQuery(
                            "SELECT d FROM DetailCommande d WHERE d.produit = :produit", DetailCommande.class)
                    .setParameter("produit", produit)
                    .getResultList();
            logger.info("Details before update: " + detailsBefore);

            String jpqlUpdate = "UPDATE DetailCommande d SET d.produit = null WHERE d.produit.id = :productId";
            Query queryUpdate = entityManager.createQuery(jpqlUpdate);
            queryUpdate.setParameter("productId", produit.getId());
            queryUpdate.executeUpdate();

            List<DetailCommande> detailsAfter = entityManager.createQuery(
                            "SELECT d FROM DetailCommande d WHERE d.produit = :produit", DetailCommande.class)
                    .setParameter("produit", produit)
                    .getResultList();
            logger.info("Details after update: " + detailsAfter);

            entityManager.remove(entityManager.contains(produit) ? produit : entityManager.merge(produit));
            transaction.commit();

            isDeleted = true;
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return isDeleted;
    }


    public List<Produit> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Produit> produits = entityManager.createQuery("SELECT p FROM Produit p", Produit.class)
                .getResultList();
        entityManager.close();
        return produits;
    }
}
