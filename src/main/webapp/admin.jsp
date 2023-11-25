<%@ page import="dao.ClientDAO" %>
<%@ page import="entity.Client" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page Administrateur</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <style>
        .client-table {
            border-collapse: collapse;
            width: 90%;
            border-spacing: 10px;
        }

        .client-table th, .client-table td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
    </style>
</head>
<body>
<header>
    <div class="neumorphic-header">
        <div>
            <a href="bienvenue.jsp"><button>Accueil</button></a>
            <a href="affichageProduit.jsp"><button>A la une</button></a>
        </div>
        <h1>Marketplace</h1>
        <div>
            <a href="panier.jsp"><button>Mon Panier</button></a>
            <a href="LogoutServlet"><button>Se d&eacute;connecter</button></a>
        </div>
    </div>
</header>
<h1>Bienvenue, Administrateur</h1>

<p>Vous &ecirc;tes connect&eacute; en tant qu'administrateur. Vous avez acc&egrave;s &agrave; des fonctionnalit&eacute;s administratives sp&eacute;ciales.</p>

<%
    ClientDAO clientDAO = new ClientDAO();
    List<Client> clients = clientDAO.findAll();
%>
<h2>Modification des droits du client :</h2>
<table align="center" class="client-table">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Pr&eacute;nom</th>
        <th>Droit Actuel</th>
        <th>Nouveau Droit</th>
        <th></th>
    </tr>
    <% for (Client client : clients) { %>
    <form action="ModifyRightServlet" method="post">
        <tr>
            <td><%= client.getId() %></td>
            <td><%= client.getNom() %></td>
            <td><%= client.getPrenom() %></td>
            <td><%= client.getDroit() %></td>
            <td>
                <select name="nouveauDroit">
                    <option value="aucun" <%= client.getDroit().equals("aucun") ? "selected" : "" %>>Aucun</option>
                    <option value="modification" <%= client.getDroit().equals("modification") ? "selected" : "" %>>Modification</option>
                    <option value="ajout" <%= client.getDroit().equals("ajout") ? "selected" : "" %>>Ajout</option>
                    <option value="supp" <%= client.getDroit().equals("supp") ? "selected" : "" %>>Suppression</option>
                    <option value="tout" <%= client.getDroit().equals("tout") ? "selected" : "" %>>Tout</option>
                </select>
            </td>
            <td>
                <input type="hidden" name="clientId" value="<%= client.getId() %>">
                <input type="submit" value="Valider">
            </td>
        </tr>
    </form>
    <% } %>
</table> <br> <br>

    <a href="editProducts.jsp"><button>Modifier Produit</button></a>
</body>
</html>