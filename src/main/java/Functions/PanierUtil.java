package Functions;

import dao.ProduitDAO;
import entity.Produit;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Map;

public class PanierUtil {

    // Méthode pour calculer le total du panier
    public static double calculateTotalAmount(Map<Integer, Integer> panier) {
        BigDecimal total = BigDecimal.ZERO;

        ProduitDAO produitDAO = new ProduitDAO();

        if (panier != null && !panier.isEmpty()) {
            for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();

                // Récupérez le produit à partir de la base de données
                Produit produit = produitDAO.findById(productId);

                // Ajoutez le montant total pour ce produit à la somme totale
                BigDecimal productTotal = BigDecimal.valueOf(produit.getPrix() * quantity);
                total = total.add(productTotal);
            }
        }
        total = total.setScale(2, RoundingMode.HALF_UP);
        return total.doubleValue();
    }
}