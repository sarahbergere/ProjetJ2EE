package Functions;
// Importez les classes nécessaires
import dao.ProduitDAO;
import entity.Produit;

import java.util.Map;

public class PanierUtil {

    // Méthode pour calculer le total du panier
    public static double calculateTotalAmount(Map<Integer, Integer> panier) {
        double total = 0.0;

        ProduitDAO produitDAO = new ProduitDAO();

        if (panier != null && !panier.isEmpty()) {
            for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();

                // Récupérez le produit à partir de la base de données
                Produit produit = produitDAO.findById(productId);

                // Ajoutez le montant total pour ce produit à la somme totale
                total += produit.getPrix() * quantity;
            }
        }

        return total;
    }
}
