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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import entity.Password;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        String login = request.getParameter("pseudo");
        String password = request.getParameter("password");

        // Vérifiez si l'utilisateur est un client
        ClientDAO clientDAO = new ClientDAO();
        Client client = clientDAO.findByUsername(login);

        try{
            if (client != null && clientDAO.getPasswordById(client.getIdUtilisateur()).equals(Password.hashPassword(password))) {
                HttpSession session = request.getSession(true);
                session.setAttribute("pseudo", login);
                session.setAttribute("client", client);
                session.setAttribute("role", "client");
                response.sendRedirect(request.getContextPath() + "/ClientServlet");
                return;
            }

        } catch (
                NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        // Si ce n'est pas un client, vérifiez si c'est un administrateur
        AdministrateurDAO administrateurDAO = new AdministrateurDAO();
        Administrateur administrateur = administrateurDAO.findByUsername(login);


        if (administrateur != null && administrateurDAO.getPasswordById(administrateur.getIdUtilisateur()).equals(password)) {
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
            return;
        }

        // Les identifiants sont incorrects, afficher un message d'erreur

        message = "Le nom d'utilisateur ou le mot de passe est incorrect. Veuillez réessayer.";
        request.setAttribute("message",message);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        // Afficher la page de login lorsque la requête GET est reçue
        request.setAttribute("message",message);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
