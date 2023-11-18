<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <style>
        body {
            height: auto;
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0 auto;
            padding: 0;
            background: linear-gradient(to bottom right, #FFD2E5, #AAD8FF); /* Utilisez les couleurs pastel de votre choix */
        }
        #titreLogin {
            text-align: center;
            padding-top: 50px;
            color: #333;
        }

        .login {
            width: 300px;
            border: none;
            background: #efefef;
            box-shadow: 5px 5px 10px rgba(163, 177, 198, 0.5),
            -5px -5px 10px rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            margin : 0 auto;
        }

        .login input[type="text"], .login input[type="password"] {
            background: #efefef;
            padding: 10px;
            height: 30px;
            border: none;
            box-shadow: inset 5px 5px 10px rgba(163, 177, 198, 0.5),
            inset -5px -5px 12px rgba(255, 255, 255, 0.8);
            outline: none;
            border-radius: 10px;
        }

        .login input[type="submit"] {
            padding: 0.5em 1.5em;
            background: #efefef;
            border: none;
            border-radius: .5rem;
            color: #444;
            font-size: 1rem;
            font-weight: 700;
            text-align: center;
            outline: none;
            cursor: pointer;
            transition: .2s ease-in-out;
            box-shadow: -6px -6px 14px rgba(255, 255, 255, .7),
            -6px -6px 10px rgba(255, 255, 255, .5),
            6px 6px 8px rgba(255, 255, 255, .075),
            6px 6px 10px rgba(0, 0, 0, .15);
        }

        .login input[type="submit"]:hover {
            background-color: #337ab7;
        }

        p {
            text-align: center;
            color: red;
        }

        a#inscription {
            color: #337ab7;
            text-decoration: none;
            position: relative;
            display: inline-block;
        }
    </style>
</head>
<body>
    <%@ include file="header.html" %>
    <h1 id="titreLogin">Login</h1>
    <form method="post" action="LoginServlet" class="login">
        <label for="pseudo">Nom d'utilisateur:</label>
        <input type="text" name="pseudo" id="pseudo" required><br><br>

        <label for="password">Mot de passe:</label>
        <input type="password" name="password" id="password" required><br><br>

        <input type="submit" value="Se connecter"><br><br>
        <a id="inscription" href="RegisterServlet">Inscrivez-vous</a>
    </form>
    <p><%= request.getAttribute("message") %></p>
    </body>
</html>