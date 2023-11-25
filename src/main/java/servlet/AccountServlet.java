package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/AccountServlet")
public class AccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Votre code de gestion pour les requêtes GET
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Votre code de gestion pour les requêtes POST
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            Object roleAttribute = session.getAttribute("role");

            if (roleAttribute != null) {
                String role = (String) roleAttribute;

                if ("client".equals(role)) {
                    request.getRequestDispatcher("ClientServlet").forward(request, response);
                } else if ("admin".equals(role)) {
                    request.getRequestDispatcher("/admin.jsp").forward(request, response);
                } else {
                    response.sendRedirect("LoginServlet");
                }
            } else {
                response.sendRedirect("LoginServlet");
            }
        } else {
            response.sendRedirect("LoginServlet");
        }
    }
}
