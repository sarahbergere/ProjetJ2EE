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

@WebServlet("/AddBankAccountServlet")
public class AddBankAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String titulaire = request.getParameter("titulaire");
        String numeroCompte = request.getParameter("numeroCompte");
        double solde = Double.parseDouble(request.getParameter("solde"));
        Client client = (Client) request.getSession().getAttribute("client");

        CompteBancaire compteBancaire = new CompteBancaire(titulaire, numeroCompte, solde, client);

        CompteBancaireDAO compteBancaireDAO = new CompteBancaireDAO();
        compteBancaireDAO.create(compteBancaire);


        client.ajouterCompteBancaire(compteBancaire);

        response.sendRedirect(request.getContextPath() + "/ClientServlet");

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}