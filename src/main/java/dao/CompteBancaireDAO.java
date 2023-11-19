package dao;

import entity.CompteBancaire;

import javax.persistence.*;
import java.util.List;

public class CompteBancaireDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(CompteBancaire compteBancaire) {
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

    public CompteBancaire findById(int id) {
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

    public List<CompteBancaire> findAllByIdClient(int idclient) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query = entityManager.createQuery("SELECT c FROM CompteBancaire c WHERE ClientID = :idclient", CompteBancaire.class);
        query.setParameter("idclient", idclient);

        try {
            List<CompteBancaire> compteBancaires = query.getResultList();
            entityManager.close();
            return compteBancaires;
        } catch (Exception e) {
            entityManager.close();
            return null;
        }
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
    public void delete(String id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            CompteBancaire compteBancaire = entityManager.find(CompteBancaire.class, Integer.parseInt(id));
            if( compteBancaire != null){
                entityManager.remove(compteBancaire);
                if (entityManager.contains(compteBancaire)) {
                    entityManager.refresh(compteBancaire);
                }
                if (transaction.isActive()) {
                    transaction.commit();
                }
            } else {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
            }
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