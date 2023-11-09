package servlet;

import dao.ClientDAO;
import dao.AdministrateurDAO;
import entity.Client;
import entity.Administrateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        String login = request.getParameter("param1");
        String password = request.getParameter("param2");

        // Vérifiez si l'utilisateur est un client
        ClientDAO clientDAO = new ClientDAO();
        Client client = clientDAO.findByUsername(login);

        if (client != null && clientDAO.getPasswordById(client.getId()).equals(password)) {
            // Utilisateur client, redirigez-le vers la page du client
            request.getRequestDispatcher("/client.jsp").forward(request, response);
            return;
        }

        // Si ce n'est pas un client, vérifiez si c'est un administrateur
        AdministrateurDAO administrateurDAO = new AdministrateurDAO();
        Administrateur administrateur = administrateurDAO.findByUsername(login);

        if (administrateur != null && administrateurDAO.getPasswordById(administrateur.getId()).equals(password)) {
            // Administrateur, redirigez-le vers la page de l'administrateur
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
            return;
        }

        // Les identifiants sont incorrects, afficher un message d'erreur
        response.setContentType("text/html");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h1>Erreur de Connexion</h1>");
        response.getWriter().println("<p>Identifiants incorrects. Veuillez réessayer.</p>");
        response.getWriter().println("</body></html>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Afficher la page de login lorsque la requête GET est reçue
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
