package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ValiderPanierServlet")
public class ValiderPanierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errorMessage = "";
        HttpSession session = request.getSession(false);

        boolean clientConnecte = (session.getAttribute("client") != null);
        boolean admin = session.getAttribute("role") == "admin";

        if (admin) {
            errorMessage = "Vous êtes administrateur vous ne pouvez pas acheter de produits.";
            session.setAttribute("erreurMessage", errorMessage);
            response.sendRedirect(request.getContextPath() + "/panier.jsp");
        } else if (clientConnecte) {
            response.sendRedirect(request.getContextPath() + "/paiement.jsp");
        } else if(clientConnecte == false) {
            errorMessage = "Vous devez être connecté pour valider votre panier. Connectez-vous <a href='LoginServlet'>ici</a>";
            session.setAttribute("erreurMessage", errorMessage);
            response.sendRedirect(request.getContextPath() + "/panier.jsp");
        }
    }
}