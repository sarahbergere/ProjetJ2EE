<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = null;
    Statement stmt = null;

    try {
        // Charger le driver JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String username = "root";
        String password = "eisti0001";
        conn = DriverManager.getConnection(url, username, password);

        // Récupérer les données du formulaire
        String nom = request.getParameter("nom");
        int prix = Integer.parseInt(request.getParameter("prix"));
        String description = request.getParameter("description");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String image = request.getParameter("image");

        // Créer la requête d'insertion
        String query = "INSERT INTO Produit (Nom, Prix, Description, Stock, Image) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, nom);
            preparedStatement.setInt(2, prix);
            preparedStatement.setString(3, description);
            preparedStatement.setInt(4, stock);
            preparedStatement.setString(5, image);

            // Exécuter la requête d'insertion
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Rediriger vers affichageProduit.jsp si le produit est ajouté avec succès
                response.sendRedirect("affichageProduit.jsp");
            } else {
                // Rediriger vers addProduit.jsp sinon
                response.sendRedirect("addProduit.jsp");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Fermer la connexion
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>


