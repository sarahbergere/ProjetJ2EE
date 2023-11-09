package dao;

import entity.Client;

import javax.persistence.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class ClientDAO {
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Persistence");

    public void create(Client client) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(client);
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

    public Client findByUsername(String username) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String jpql = "SELECT c FROM Client c WHERE c.utilisateur.pseudo = :username";
        Query query = entityManager.createQuery(jpql, Client.class);
        query.setParameter("username", username);

        List<Client> clients = query.getResultList();

        if (clients.size() > 0) {
            return clients.get(0);
        }

        return null;
    }
    public String getPasswordById(int clientId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String jpql = "SELECT u.motDePasse FROM Utilisateur u WHERE u.idUtilisateur = :clientId";
        Query query = entityManager.createQuery(jpql, String.class);
        query.setParameter("clientId", clientId);

        try {
            String password = (String) query.getSingleResult();
            return password;
        } catch (Exception e) {
            return null;
        }
    }

    public Client findById(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Client client = entityManager.find(Client.class, id);
        entityManager.close();
        return client;
    }

    public List<Client> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Client> clients = entityManager.createQuery("SELECT c FROM client c", Client.class)
                .getResultList();
        entityManager.close();
        return clients;
    }

    public void update(Client client) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.merge(client);
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

    public void delete(Client client) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.remove(client);
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

