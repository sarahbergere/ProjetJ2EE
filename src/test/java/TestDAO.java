
import dao.CommandeDAO;
import dao.ProduitDAO;
import entity.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Assertions;

import java.util.Date;

public class TestDAO {
    private ProduitDAO produitDAO;
    private CommandeDAO commandeDAO;

    @BeforeEach
    public void setUp() {
        produitDAO = new ProduitDAO();
        commandeDAO = new CommandeDAO();
    }

    @AfterEach
    public void tearDown() {
        // Nettoyez les données de test
        for (Produit produit : produitDAO.findAll()) {
            produitDAO.delete(produit);
        }
        for (Commande commande : commandeDAO.findAll()) {
            commandeDAO.delete(commande);
        }
    }

    @Test
    public void testCreateAndDeleteProduit() {
        Produit produit = new Produit();
        produit.setNom("Nom du produit");
        produit.setDescription("Description du produit");
        produit.setPrix(19.99);
        produit.setStock(50);

        produitDAO.create(produit);

        Assertions.assertNotNull(produit.getId());

        Produit retrievedProduit = produitDAO.findById(produit.getId());
        Assertions.assertEquals("Nom du produit", retrievedProduit.getNom());

        produitDAO.delete(produit);

        Assertions.assertNull(produitDAO.findById(produit.getId()));
    }

    @Test
    public void testCreateAndUpdateCommande() {
        int clientId = 2;

        Client client = new Client("gentel dehenne","matéo", "square", "mato@gmail.com", "0601234567", Droit.aucun.toString());
        client.setId(clientId);

        Commande commande = new Commande(client, new Date(), StatutCommande.traitement.toString(), 5, "nn", "nn", "nn", ",,", "nn");

        commandeDAO.create(commande);

        Assertions.assertNotNull(commande.getId());

        // Mise à jour de la commande
        commande.setStatutDeCommande(StatutCommande.livrée.toString());
        commandeDAO.update(commande);

        Commande updatedCommande = commandeDAO.findById(commande.getId());
        Assertions.assertEquals("Terminée", updatedCommande.getStatutDeCommande());

        commandeDAO.delete(commande);

        Assertions.assertNull(commandeDAO.findById(commande.getId()));
    }

    @Test
    public void testReadCommande() {
        int clientId = 2;

        // Vous pouvez créer un client factice avec seulement l'ID
        Client client = new Client("gentel dehenne","matéo", "square", "mato@gmail.com", "0601234567",Droit.aucun.toString());
        client.setId(clientId);

        Commande commande = new Commande(client, new Date(), StatutCommande.traitement.toString(), 5, "nn", "nn", "nn", ",,", "nn");

        commande.setClient(client);
        commande.setDateDeCommande(new Date());
        commande.setStatutDeCommande(StatutCommande.traitement.toString());

        commandeDAO.create(commande);

        Assertions.assertNotNull(commande.getId());

        Commande retrievedCommande = commandeDAO.findById(commande.getId());
        Assertions.assertEquals("En cours", retrievedCommande.getStatutDeCommande());

        commandeDAO.delete(commande);

        Assertions.assertNull(commandeDAO.findById(commande.getId()));
    }
}