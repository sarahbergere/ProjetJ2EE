package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les paramètres du formulaire
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Récupérer la session
        HttpSession session = request.getSession();

        // Récupérer le panier depuis la session
        Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

        if (panier != null && panier.containsKey(productId)) {
            // Supprimer le produit du panier
            panier.remove(productId);

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