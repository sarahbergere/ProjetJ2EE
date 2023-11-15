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
        #site {
            color :white;
        }
        header {
             background-color: #333;
             padding: 20px;
             display: flex;
             justify-content: space-between;
             align-items: center;
            border-radius: 50px;
         }

        .icon:hover {
            transform: scale(1.2);
        }

        .icon {
            width: 30px;
            height: 30px;
            padding: 5px;
            transition: transform 0.3s ease-in-out;
        }
        .logout-form {
            display: inline-block;
        }

        #logout-button {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
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

        #suppCompte{
            background-color: #e2b6b6;
            border-color: #e2b6b6;
            border-radius: 50px;
        }

        #ajoutcompte {
            max-width: 400px;
        }

        #ajoutcompte h2 {
            color: #333;
        }

        #ajoutcompte label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        #ajoutcompte input {
            width: calc(100% - 16px);
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #ajoutcompte input[type="submit"] {
            background-color: #adb4ae;
            color: #fff;
            cursor: pointer;
        }

        #ajoutcompte input[type="submit"]:hover {
            background-color: #adb4ae;
        }
    </style>
</head>
<body>
<header>
    <h1 id="site">Notre site</h1>
    <nav>
        <a href="#"><img class="icon" src="img/basket.png" alt="cart icon"></a>
        <form action="LogoutServlet" method="post" class="logout-form">
            <button type="submit" id="logout-button" aria-label="Déconnexion">
                <img class="icon" src="img/logout.png" alt="logout icon">
            </button>
        </form>
    </nav>
</header>
<div class="content">
    <h1>Bienvenue, ${sessionScope.pseudo}</h1>

    <p>Vous êtes connecté en tant que client. Vous pouvez accéder à votre compte et effectuer des opérations liées à votre compte.</p>
    <hr>
    <div id="informations">
        <p><h2>Vos informations</h2>
        Nom : ${sessionScope.client.nom} <br>
        Prénom : ${sessionScope.client.prenom} <br></p>
    </div>

    <hr>
    <h2>Commandes passées</h2>
    <c:choose>
        <c:when test="${empty sessionScope.client.commandes}">
            <p>Il n'y a pas encore de commande pour ce client.</p>
        </c:when>
        <c:otherwise>

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

    <hr>
    <h2>Comptes liés :</h2>
    <c:choose>
        <c:when test="${empty sessionScope.client.comptes}">
            <p>Vous n'avez pas encore de compte bancaire lié à votre compte</p>
        </c:when>
        <c:otherwise>
            <ul>
                <c:forEach var="compte" items="${sessionScope.client.comptes}">
                    <li>${compte.titulaireDuCompte} - ${compte.numeroDeCompte} - ${compte.solde} €
                        <form action="DeleteBankAccountServlet" method="post" style="display:inline;">
                            <input type="hidden" name="compteId" value="${compte.id}">
                            <input type="hidden" name="nomcompte" value="${compte.titulaireDuCompte}">
                            <input id="suppCompte" type="submit" value="Supprimer le compte">
                        </form>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <hr>
    <form method="post" action="AddBankAccountServlet" id="ajoutcompte">
        <h2>Ajouter un compte bancaire</h2>
        <label for="titulaire">Nom du titulaire :</label>
        <input type="text" id="titulaire" name="titulaire" required><br>
        <label for="numeroCompte">Numéro de compte bancaire :</label>
        <input type="text" id="numeroCompte" name="numeroCompte" required><br>
        <label for="solde">Solde :</label>
        <input type="number" id="solde" name="solde" step="0.01" required><br>
        <input type="submit" value="Ajouter le compte">
    </form>
</div>
</body>
</html>