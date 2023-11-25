package servlet;

import dao.ClientDAO;
import entity.Client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ModifyRightServlet")
public class ModifyRightServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clientId = Integer.parseInt(request.getParameter("clientId"));
        String nouveauDroit = request.getParameter("nouveauDroit");

        ClientDAO clientDAO = new ClientDAO();
        Client client = clientDAO.findById(clientId);

        if (client != null) {
            client.setDroit(nouveauDroit);
            clientDAO.update(client);
        }
        response.sendRedirect("admin.jsp");
    }
}
