package servlet;

import entity.CompteBancaire;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import entity.Client;

import java.io.IOException;
import java.util.List;

@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("role") != null) {
            String pseudo = (String) session.getAttribute("pseudo");
            Client client = (Client) session.getAttribute("client");
            client.chargerCompteBancaire();

            request.getRequestDispatcher("/client.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        }
    }
}
