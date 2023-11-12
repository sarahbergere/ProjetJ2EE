<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        h1 {
            text-align: center;
            padding-top: 50px;
            color: #333;
        }

        form {
            width: 300px;
            margin: 0 auto;
            padding: 50px;
            border: 1px solid #ddd;
            background-color: #fff;
            border-radius: 5px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 8px;
            background-color: #5bc0de;
            border: none;
            border-radius: 3px;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
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

        a#inscription::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            color: #337ab7;;
            width: 100%;
            height: 1px;
            background-color: #333;
            transform-origin: bottom left;
            transform: scaleX(0);
            transition: transform 0.3s ease-in-out;
        }

        a#inscription:hover::before {
            transform: scaleX(1);
        }
    </style>
</head>
<body>
<h1>Login</h1>
<form method="post" action="LoginServlet">
    <label for="pseudo">Nom d'utilisateur:</label>
    <input type="text" name="pseudo" id="pseudo" required><br><br>

    <label for="password">Mot de passe:</label>
    <input type="password" name="password" id="password" required><br><br>

    <input type="submit" value="Se connecter"><br><br>
    <a id="inscription" href="RegisterServlet">Inscrivez-vous</a>
</form>
<p><%= request.getAttribute("message") %>
</p>
</body>
</html>