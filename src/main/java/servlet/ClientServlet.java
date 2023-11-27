package servlet;

import entity.Droit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import entity.Client;
import java.io.IOException;

@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("role") != null && session.getAttribute("role").equals("client")) {
            Client client = (Client) session.getAttribute("client");

            String modifierProduit = client.getDroit().equals(Droit.aucun.toString()) ? "" : "<hr><div>\n" +
                    "        <h2>Vos droits</h2><a href=\"editProducts.jsp\"><button>Modifier Produit</button></a></p>\n" +
                    "    </div>" ;

            session.setAttribute("modifierProduit", modifierProduit);
            client.chargerCompteBancaire();
            client.chargerCommande();

            request.getRequestDispatcher("/client.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        }
    }
}
