# ProjetJ2EE

Ce projet est une application de commerce en ligne développée en utilisant Java, J2EE, Tomcat, Hibernate et d'autres technologies.

## Prérequis

Ce projet fonctionne et a été testé avec les outils suivant : 

- Java JDK 17 ou version ultérieure
- TomCat version 10.1.15
- Intellij IDEA 2023.2.5

## Configuration
Vous pouvez configurer l'application en modifiant le fichier src/main/resources/application.properties pour y modifier votre nom d'utilisateur et votre mot de passe MySql.

Attention : Veuillez à bien importer la base de donnée dans Workbench MySQL -> entrez dans votre connexion Mysql -> Server -> Data Import -> Cochez "Import from Self-Contained File" et mettez le .sql qui se trouve dans src/main/resources/ecommerce.sql puis importez.

### Étapes

1. Ouvrez le projet dans votre environnement de développement Java.

2. Lancez la configuration du Tomcat Server dans IntelliJ.
   - Assurez-vous que la configuration pointe vers votre serveur Tomcat et que les paramètres sont corrects.

3. Une fois l'application démarrée avec succès, la page web [http://localhost:8080](http://localhost:8080) s'ouvrira automatiquement.

4. Explorez l'application en utilisant l'interface utilisateur.
   - Ajoutez des produits à votre panier.
   - Modifiez les produits existants.
   - Supprimez des produits du catalogue.
   - Visualisez votre panier et procédez au paiement.
   - Explorez les fonctionnalités d'administration si nécessaire.

5. Profitez de l'expérience d'achat en ligne !

### Dépannage

- Consultez la console de l'application pour les messages de journalisation ou d'erreur lors du démarrage.
- Assurez-vous que les configurations de la base de données sont correctes.
- Vérifiez que le serveur Tomcat est en cours d'exécution.

**Note :** Pour arrêter l'application, retournez à votre environnement de développement Java et arrêtez l'exécution de Tomcat Server ou fermez la fenêtre du terminal où l'application est en cours d'exécution.

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

## Auteurs 

Fait par Sarah BERGERE, Florian GAULLIER, Matéo GENTEL-DEHENNE et Marcus NDEUGOUE.

ING 2 GSI Groupe 3.

CY TECH
