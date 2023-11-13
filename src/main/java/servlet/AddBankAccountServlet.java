package servlet;

import dao.CompteBancaireDAO;
import entity.Client;
import entity.CompteBancaire;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/AddBankAccountServlet")
public class AddBankAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String titulaire = request.getParameter("titulaire");
        String numeroCompte = request.getParameter("numeroCompte");
        double solde = Double.parseDouble(request.getParameter("solde"));

        CompteBancaire compteBancaire = new CompteBancaire(titulaire, numeroCompte, solde);

        CompteBancaireDAO compteBancaireDAO = new CompteBancaireDAO();
        compteBancaireDAO.create(compteBancaire);

        Client client = (Client) request.getSession().getAttribute("client");
        client.ajouterCompteBancaire(compteBancaire);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ClientServlet");
        dispatcher.forward(request, response);
    }
}