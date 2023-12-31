package servlet;

import dao.ClientDAO;
import dao.UtilisateurDAO;
import entity.Client;
import entity.Droit;
import entity.Role;
import entity.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

import Functions.Password;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        String pseudo = request.getParameter("pseudo");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String adresse = request.getParameter("adresse");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String password = request.getParameter("password");

        if (pseudo == null || nom == null || prenom == null || adresse == null || email == null || telephone == null || password == null ||
                pseudo.isEmpty() || nom.isEmpty() || prenom.isEmpty() || adresse.isEmpty() || email.isEmpty() || telephone.isEmpty() || password.isEmpty()) {
            message = "Veuillez remplir tous les champs du formulaire.";
        } else {

            ClientDAO clientDAO = new ClientDAO();

            if(clientDAO.findByUsername(pseudo) == null ){

                UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setPseudo(pseudo);
                try {
                    utilisateur.setMotDePasse(Password.hashPassword(password));
                } catch (NoSuchAlgorithmException e) {
                    throw new RuntimeException(e);
                }
                utilisateur.setRole(Role.client);


                int idUtilisateur = utilisateurDAO.create(utilisateur);

                if (idUtilisateur != 0) {
                    Client nouveauClient = new Client(nom, prenom, adresse,email,telephone, Droit.aucun.toString());
                    nouveauClient.setIdUtilisateur(idUtilisateur);

                    clientDAO.create(nouveauClient);
                    sendEmail(email, prenom);

                    message = "Le compte a été créé avec succès Un e-mail de confirmation a été envoyé à " + email;
                } else {
                    message = "Erreur lors de la création du compte. Veuillez réessayer.";
                }
            }
            else{
                message = "Pseudonyme déjà utilisé.";
            }

        }
        request.setAttribute("message", message);
        request.getRequestDispatcher("/inscription.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        request.setAttribute("message",message);
        request.getRequestDispatcher("/inscription.jsp").forward(request, response);
    }

    private static void sendEmail(String emailclient, String prenom) {
        try {
            Email email = new SimpleEmail();
            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(587);
            email.setAuthenticator(new DefaultAuthenticator("sarahbergere10@gmail.com", "rqnc aeio fliv riko"));
            email.setStartTLSEnabled(true);
            email.setFrom("sarahbergere10@gmail.com");
            email.setSubject("Confirmation de la création de votre compte");
            email.setMsg("Bonjour "+prenom+",\n\n" +
                    "Votre compte a été créé avec succès. Nous sommes ravis de vous accueillir dans notre communauté.\n" +
                    "\n" +
                    "N'hésitez pas à explorer notre site/application et à profiter de tous nos services. Si vous avez des questions ou des préoccupations, n'hésitez pas à nous contacter.\n" +
                    "\n" +
                    "Merci de faire partie de notre communauté !\n" +
                    "\n" +
                    "Cordialement,\n" +
                    "Notre Marketplace\n");
            email.addTo(emailclient);
            email.send();
        } catch (EmailException e) {
            e.printStackTrace();
        }
    }
}
