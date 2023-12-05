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

import Functions.Password;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        String login = request.getParameter("pseudo");
        String password = request.getParameter("password");

        ClientDAO clientDAO = new ClientDAO();
        Client client = clientDAO.findByUsername(login);

        try{
            if (client != null && clientDAO.getPasswordById(client.getIdUtilisateur()).equals(Password.hashPassword(password))) {
                HttpSession session = request.getSession(true);
                session.setAttribute("pseudo", login);
                session.setAttribute("client", client);
                session.setAttribute("role", "client");
                response.sendRedirect(request.getContextPath() + "/AccountServlet");
                return;
            }
        } catch (
                NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        AdministrateurDAO administrateurDAO = new AdministrateurDAO();
        Administrateur administrateur = administrateurDAO.findByUsername(login);

        try{
            if (administrateur != null && administrateurDAO.getPasswordById(administrateur.getIdUtilisateur()).equals(Password.hashPassword(password))) {
                HttpSession session = request.getSession(true);
                session.setAttribute("role", "admin");
                response.sendRedirect(request.getContextPath() + "/AccountServlet");
                return;
            }
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        message = "Le nom d'utilisateur ou le mot de passe est incorrect. Veuillez réessayer.";
        request.setAttribute("message",message);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        request.setAttribute("message",message);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
