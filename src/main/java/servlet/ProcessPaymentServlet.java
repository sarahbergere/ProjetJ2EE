package servlet;

import java.io.IOException;
import java.util.Date;
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

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String messageErreur = "";

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
            int compteBancaireId = Integer.parseInt(request.getParameter("compteBancaire"));
            
            compteBancaire = compteBancaireDAO.findById(compteBancaireId);
            if(compteBancaire.getSolde() < montantPanier) {
                messageErreur = "Le solde du compte choisi est inférieur au montant de votre panier. Veuillez choisir un autre compte bancaire.";
                session.setAttribute("messageErreur", messageErreur);
                return;
            }
        }
        else if ("lierCompte".equals(optionCompte)) {
            double nouveauSolde = Double.parseDouble(request.getParameter("solde"));
            if(nouveauSolde < montantPanier){
                messageErreur = "Le solde de votre compte est inférieur au montant de votre panier. Veuillez choisir un autre compte bancaire.";
                session.setAttribute("messageErreur", messageErreur);
            }
            String nouveauTitulaire = request.getParameter("titulaire");
            String numeroCompte = request.getParameter("numeroCompte");
            
            compteBancaire = new CompteBancaire(nouveauTitulaire, numeroCompte,nouveauSolde, (Client) session.getAttribute("client"));
            compteBancaireDAO.create(compteBancaire);
        }

        CommandeDAO commandeDAO = new CommandeDAO();
        Commande commande = new Commande(date, montantPanier, StatutCommande.traitement.toString(), (Client) session.getAttribute("client"));
        int idCommande = commandeDAO.create(commande);

        if (idCommande != 0) {
            PaiementDAO paiementDAO = new PaiementDAO();
            
            Paiement paiement = new Paiement(commande, compteBancaire, montantPanier, date);
            paiementDAO.create(paiement);

            DetailCommandeDAO detailCommandeDAO = new DetailCommandeDAO();
            Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");
            for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();
                ProduitDAO produitDAO = new ProduitDAO();

                DetailCommande detailCommande = new DetailCommande(commande, produitDAO.findById(productId), quantity);
                detailCommandeDAO.create(detailCommande);

                Produit produit = produitDAO.findById(productId);
                produit.setStock(produit.getStock() - quantity);
                produitDAO.update(produit);
            }
        }

        response.sendRedirect("confirmation.jsp"); // Remplacez "confirmation.jsp" par la page appropriée
    }
}
