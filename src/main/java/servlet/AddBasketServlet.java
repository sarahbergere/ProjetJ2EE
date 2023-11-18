package servlet;

import dao.ProduitDAO;
import entity.Produit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/AddBasketServlet")
public class AddBasketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();

        Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

        if (panier == null) {
            panier = new HashMap<>();
            session.setAttribute("panier", panier);
        }

        ProduitDAO produitDAO = new ProduitDAO();
        Produit produit = produitDAO.findById(productId);

        int stockDisponible = produit.getStock();

        if (panier.containsKey(productId)) {
            int existingQuantity = panier.get(productId);
            if (existingQuantity + quantity > stockDisponible) {
                panier.put(productId, stockDisponible);
            } else {
                panier.put(productId, existingQuantity + quantity);
            }
        } else {
            // Si le produit n'existe pas dans le panier, l'ajouter avec la quantité en vérifiant le stock
            if (quantity > stockDisponible) {
                // Si la quantité demandée est supérieure au stock, ajuster la quantité au stock maximum
                panier.put(productId, stockDisponible);
            } else {
                panier.put(productId, quantity);
            }
        }
    }
}