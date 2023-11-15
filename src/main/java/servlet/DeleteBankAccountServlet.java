package servlet;

import dao.CompteBancaireDAO;
import entity.Client;
import entity.CompteBancaire;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/DeleteBankAccountServlet")
public class DeleteBankAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String compteBancaireSupp = request.getParameter("compteId");
        String nomcompte = request.getParameter("nomcompte");

        CompteBancaireDAO compteBancaireDAO = new CompteBancaireDAO();
        compteBancaireDAO.delete(compteBancaireSupp);

        HttpSession session = request.getSession(false);
        Client client = (Client) session.getAttribute("client");
        List<CompteBancaire> comptes = client.getComptes();

        if (comptes != null) {
            comptes.removeIf(account -> account.getId() == Integer.parseInt(compteBancaireSupp));
            client.setComptes(comptes);
            session.setAttribute("client", client);
        }
        response.sendRedirect("ClientServlet");
    }
}
