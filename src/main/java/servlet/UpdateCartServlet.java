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
import java.util.Map;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        ProduitDAO produitDAO = new ProduitDAO();
        Produit produit = produitDAO.findById(productId);

        HttpSession session = request.getSession();

        // Récupérer le panier depuis la session
        Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

        if (panier != null && panier.containsKey(productId)) {
            if(newQuantity > produit.getStock()){
                newQuantity = produit.getStock();
            }
            panier.put(productId, newQuantity);

            // Mettre à jour la session avec le panier modifié
            session.setAttribute("panier", panier);

            // Rediriger vers la page du panier
            response.sendRedirect("panier.jsp");
        } else {
            // Gérer le cas où le produit n'est pas trouvé dans le panier
            response.getWriter().println("Produit non trouvé dans le panier.");
        }
    }
}
