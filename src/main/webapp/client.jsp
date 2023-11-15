<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page Client</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .content {
            width: 80%;
            margin: auto;
        }

        h1 {
            color: #333;
        }

        p {
            color: #666;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<div class="content">
    <h1>Bienvenue, ${sessionScope.pseudo}</h1>

    <p>Vous êtes connecté en tant que client. Vous pouvez accéder à votre compte et effectuer des opérations liées aux achats.</p>

    <table>
        <tr>
            <th>Nom</th>
            <th>Prénom</th>
        </tr>
        <tr>
            <td>${sessionScope.client.nom}</td>
            <td>${sessionScope.client.prenom}</td>
        </tr>
    </table>

    <c:choose>
        <c:when test="${empty sessionScope.client.commandes}">
            <p>Il n'y a pas encore de commande pour ce client.</p>
        </c:when>
        <c:otherwise>
            <h2>Commandes passées</h2>
            <table>
                <tr>
                    <th>Date</th>
                    <th>Produit</th>
                    <th>Quantité</th>
                </tr>
                <c:forEach var="commande" items="${sessionScope.client.commandes}">
                    <tr>
                        <td>${commande.dateDeCommande}</td>
                        <td>${commande.statutDeCommande}</td>
                        <td>${commande.montant}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>

    <form method="post" action="AddBankAccountServlet">
        <h2>Ajouter un compte bancaire</h2>
        <label for="titulaire">Nom du titulaire :</label>
        <input type="text" id="titulaire" name="titulaire" required><br>
        <label for="numeroCompte">Numéro de compte bancaire :</label>
        <input type="text" id="numeroCompte" name="numeroCompte" required><br>
        <label for="solde">Solde :</label>
        <input type="number" id="solde" name="solde" step="0.01" required><br>
        <input type="submit" value="Ajouter le compte">
    </form>


    <c:choose>
        <c:when test="${empty sessionScope.client.comptes}">
            <p>Vous n'avez pas encore de compte bancaire lié à votre compte</p>
        </c:when>
        <c:otherwise>
        <h2>Comptes liés :</h2>
        <ul>
            <c:forEach var="compte" items="${sessionScope.client.comptes}">
                <li>${compte.titulaireDuCompte} - ${compte.numeroDeCompte} - ${compte.solde} €</li>
                <form action="DeleteBankAccountServlet" method="post" style="display:inline;">
                    <input type="hidden" name="compteId" value="${compte.id}">
                    <input type="hidden" name="nomcompte" value="${compte.titulaireDuCompte}">
                    <input type="submit" value="Supprimer le compte">
                </form>
            </c:forEach>
        </ul>
        </c:otherwise>
    </c:choose>

    <form action="LogoutServlet" method="post">
        <input type="submit" value="Déconnexion">
    </form>
</div>
</body>
</html>