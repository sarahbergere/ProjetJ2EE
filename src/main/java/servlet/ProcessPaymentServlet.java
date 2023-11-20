package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import Functions.PanierUtil;
import dao.*;
import entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String messageErreur = "";
        int idCompteBancaire = 0;

        double montantPanier = PanierUtil.calculateTotalAmount((Map<Integer, Integer>) session.getAttribute("panier"));

        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        String ville = request.getParameter("ville");
        String codePostal = request.getParameter("codePostal");
        String pays = request.getParameter("pays");

        String optionCompte = request.getParameter("optionCompte");

        CompteBancaire compteBancaire = null;
        Date date = new Date();
        CompteBancaireDAO compteBancaireDAO = new CompteBancaireDAO();

        
        if ("choisirCompteLie".equals(optionCompte)) { //Compte déjà dans la base de donnée
            idCompteBancaire = Integer.parseInt(request.getParameter("compteBancaire"));
            
            compteBancaire = compteBancaireDAO.findById(idCompteBancaire);
            if(compteBancaire.getSolde() < montantPanier) {
                messageErreur = "Le solde du compte choisi est inférieur au montant de votre panier. Veuillez choisir un autre compte bancaire.";
                session.setAttribute("messageErreur", messageErreur);
                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                return;
            }
            compteBancaire.setSolde(compteBancaire.getSolde() - montantPanier);
            compteBancaireDAO.update(compteBancaire);
        }
        else if ("lierCompte".equals(optionCompte)) {
            double nouveauSolde = Double.parseDouble(request.getParameter("solde"));
            if(nouveauSolde < montantPanier){
                messageErreur = "Le solde de votre compte est inférieur au montant de votre panier. Veuillez choisir un autre compte bancaire.";
                session.setAttribute("messageErreur", messageErreur);
                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                return;
            }
            String nouveauTitulaire = request.getParameter("titulaire");
            String numeroCompte = request.getParameter("numeroCompte");
            
            compteBancaire = new CompteBancaire(nouveauTitulaire, numeroCompte, nouveauSolde-montantPanier, (Client) session.getAttribute("client"));
            idCompteBancaire = compteBancaireDAO.create(compteBancaire);
        }

        CommandeDAO commandeDAO = new CommandeDAO();
        Commande commande = new Commande(date, montantPanier, StatutCommande.traitement.toString(), (Client) session.getAttribute("client"));
        int idCommande = commandeDAO.create(commande);
        session.setAttribute("commande", commande);

        if (idCommande != 0) {
            PaiementDAO paiementDAO = new PaiementDAO();

            Paiement paiement = new Paiement(idCommande,idCompteBancaire, montantPanier,date);
            paiementDAO.create(paiement);

            DetailCommandeDAO detailCommandeDAO = new DetailCommandeDAO();
            Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

            List<DetailCommande> detailsCommandeList = new ArrayList<>();
            for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();
                ProduitDAO produitDAO = new ProduitDAO();

                DetailCommande detailCommande = new DetailCommande(commande, produitDAO.findById(productId), quantity);
                detailCommandeDAO.create(detailCommande);

                Produit produit = produitDAO.findById(productId);
                produit.setStock(produit.getStock() - quantity);
                produitDAO.update(produit);

                detailsCommandeList.add(detailCommande);
            }
            session.setAttribute("detailsCommande", detailsCommandeList);
        }
        sendEmail(commande, (Client) session.getAttribute("client"));
        session.removeAttribute("panier");
        response.sendRedirect("confirmation.jsp");
    }

    private static void sendEmail(Commande commande, Client client) {
        try {
            Email email = new SimpleEmail();
            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(587);
            email.setAuthenticator(new DefaultAuthenticator("sarahbergere10@gmail.com", "rqnc aeio fliv riko"));
            email.setStartTLSEnabled(true);
            email.setFrom("sarahbergere10@gmail.com");
            email.setSubject("Confirmation de votre commande");

            StringBuilder message = new StringBuilder();
            message.append("Bonjour ").append(client.getPrenom()).append(",\n\n")
                    .append("Nous vous confirmons la réception de votre commande.\n\n")
                    .append("Détails de la commande:\n")
                    .append("Numéro de commande: ").append(commande.getId()).append("\n")
                    .append("Date de commande: ").append(commande.getDateDeCommande()).append("\n")
                    .append("Montant de la commande: ").append(commande.getMontant()).append(" €\n\n")
                    .append("Produits commandés:\n");

            // Utilisation du DAO pour obtenir les détails de commande
            DetailCommandeDAO detailCommandeDAO = new DetailCommandeDAO();
            List<DetailCommande> detailsCommande = detailCommandeDAO.findByCommande(commande);

            for (DetailCommande detailCommande : detailsCommande) {
                ProduitDAO produitDAO = new ProduitDAO();
                Produit produit = produitDAO.findById(detailCommande.getProduit().getId());

                message.append("- ").append(produit.getNom()).append(" (Quantité: ").append(detailCommande.getQuantite()).append(")\n");
            }

            message.append("\nMerci de votre confiance !\n\n")
                    .append("Cordialement,\n")
                    .append("MarketPlace\n");

            email.setMsg(message.toString());
            email.addTo(client.getEmail());
            email.send();

        } catch (EmailException e) {
            e.printStackTrace();
        }
    }
}
