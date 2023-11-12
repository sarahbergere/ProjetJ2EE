
import dao.CommandeDAO;
import dao.ProduitDAO;
import entity.Client;
import entity.Commande;
import entity.Produit;
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
        produit.setNomDuProduit("Nom du produit");
        produit.setDescription("Description du produit");
        produit.setPrix(19.99);
        produit.setStock(50);

        produitDAO.create(produit);

        Assertions.assertNotNull(produit.getId());

        Produit retrievedProduit = produitDAO.findById(produit.getId());
        Assertions.assertEquals("Nom du produit", retrievedProduit.getNomDuProduit());

        produitDAO.delete(produit);

        Assertions.assertNull(produitDAO.findById(produit.getId()));
    }

    @Test
    public void testCreateAndUpdateCommande() {
        Commande commande = new Commande();
        int clientId = 2; // Remplacez par l'ID d'un client existant

        // Vous pouvez créer un client factice avec seulement l'ID
        Client client = new Client();
        client.setId(clientId);

        commande.setClient(client);
        commande.setDateDeCommande(new Date());
        commande.setStatutDeCommande("En cours");

        commandeDAO.create(commande);

        Assertions.assertNotNull(commande.getId());

        // Mise à jour de la commande
        commande.setStatutDeCommande("Terminée");
        commandeDAO.update(commande);

        Commande updatedCommande = commandeDAO.findById(commande.getId());
        Assertions.assertEquals("Terminée", updatedCommande.getStatutDeCommande());

        commandeDAO.delete(commande);

        Assertions.assertNull(commandeDAO.findById(commande.getId()));
    }

    @Test
    public void testReadCommande() {
        Commande commande = new Commande();
        int clientId = 2; // Remplacez par l'ID d'un client existant

        // Vous pouvez créer un client factice avec seulement l'ID
        Client client = new Client();
        client.setId(clientId);
        client.setEmail("ndeugouema@cy-tech.fr");
        client.setNumeroTelephone("0612345678");
        client.setNom("Ndeugoue");
        client.setPrenom("Marcus");
        client.setAdresse("avenue de lhautil");

        commande.setClient(client);
        commande.setDateDeCommande(new Date());
        commande.setStatutDeCommande("En cours");

        commandeDAO.create(commande);

        Assertions.assertNotNull(commande.getId());

        Commande retrievedCommande = commandeDAO.findById(commande.getId());
        Assertions.assertEquals("En cours", retrievedCommande.getStatutDeCommande());

        commandeDAO.delete(commande);

        Assertions.assertNull(commandeDAO.findById(commande.getId()));
    }
}