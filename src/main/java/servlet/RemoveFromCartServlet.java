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
        int productId = Integer.parseInt(request.getParameter("productId"));

        HttpSession session = request.getSession();

        Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

        if (panier != null && panier.containsKey(productId)) {
            panier.remove(productId);

            session.setAttribute("panier", panier);

            response.sendRedirect("panier.jsp");
        } else {
            // Gérer le cas où le produit n'est pas trouvé dans le panier
            response.getWriter().println("Produit non trouvé dans le panier.");
        }
    }
}