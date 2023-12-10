# ProjetJ2EE

Ce projet est une application de commerce en ligne développée en utilisant Java, J2EE, Tomcat, Hibernate et d'autres technologies.

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants :

- Java JDK 17 ou version ultérieure
- Apache Maven
- Spring Boot
- TomCat version 10.1.15


## Configuration
Vous pouvez configurer l'application en modifiant le fichier src/main/resources/application.properties pour y modifier votre nom d'utilisateur et votre mot de passe MySql.

Attention : Veuillez à bien importer la base de donnée dans Workbench MySQL -> entrez dans votre connexion Mysql -> Server -> Data Import -> Cochez "Import from Self-Contained File" et mettez le .sql qui se trouve dans src/main/resources/ecommerce.sql puis importez.

## Fonctionnalités

- [X] Ajout de produits
- [X] Édition de produits
- [X] Suppression de produits
- [X] Visualisation du panier
- [X] Commande et paiement en ligne
- [X] Vérification du solde au paiement
- [X] Ajout et modification de droit de client
- [X] Page Admin
- [X] Ajout et Suppression de compte bancaire pour les clients
- [X] Envoie de mail à l'inscription et à la validation de commande 
