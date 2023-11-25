CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `idAdmin` int NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `Prenom` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `NumeroTelephone` varchar(20) NOT NULL,
  `idUtilisateur` int NOT NULL,
  PRIMARY KEY (`idAdmin`),
  KEY `admin_utilisateur_id_fk` (`idUtilisateur`),
  CONSTRAINT `admin_utilisateur_id_fk` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Bergere','Sarah','bergeresar@cy-tech.fr','0612345678',1);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `idclient` int NOT NULL AUTO_INCREMENT,
  `Nom` varchar(50) NOT NULL,
  `Prenom` varchar(50) NOT NULL,
  `Adresse` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telephone` varchar(20) NOT NULL,
  `idUtilisateur` int NOT NULL,
  `Droit` enum('aucun','modification','ajout','suppression','tout') NOT NULL,
  PRIMARY KEY (`idclient`),
  KEY `client_utilisateur_id_fk` (`idUtilisateur`),
  CONSTRAINT `client_utilisateur_id_fk` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Ndeugoue','Marcus','12 boulevard de lhautil','ndeugoue@cy-tech.fr','0612345678',2,'modification'),(2,'Dehaud','Laure','1 square des abricots','laure.dehaud@gmail.com','0612345678',3,'aucun'),(4,'Bergere','Marie','1 square des abricots','bergeresar@cy-tech.fr','0612345678',5,'tout'),(5,'Gentel Dehenne','Matéo','12 boulevard de lhautil','genteldehe@cy-tech.fr','0612345678',6,'aucun'),(6,'Bergere','sarah','12 boulevard de lhautil','bergeresar@cy-tech.fr','0612345678',7,'aucun');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande`
--

DROP TABLE IF EXISTS `commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commande` (
  `idcommande` int NOT NULL AUTO_INCREMENT,
  `IdClient` int NOT NULL,
  `DateDeCommande` date NOT NULL,
  `StatutDeCommande` varchar(20) NOT NULL,
  `montant` double DEFAULT NULL,
  `Nom` varchar(100) NOT NULL,
  `Adresse` varchar(100) NOT NULL,
  `CodePostal` varchar(10) NOT NULL,
  `Ville` varchar(50) NOT NULL,
  `Pays` varchar(30) NOT NULL,
  PRIMARY KEY (`idcommande`),
  KEY `IdClient_idx` (`IdClient`),
  CONSTRAINT `commande_client_idclient_fk` FOREIGN KEY (`IdClient`) REFERENCES `client` (`idclient`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande`
--

LOCK TABLES `commande` WRITE;
/*!40000 ALTER TABLE `commande` DISABLE KEYS */;
INSERT INTO `commande` VALUES (2,6,'2023-11-20','traitement',504,'Bergere Sarah','4 rue des clients','95280','Jouy le Moutier','France');
/*!40000 ALTER TABLE `commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comptebancaire`
--

DROP TABLE IF EXISTS `comptebancaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comptebancaire` (
  `idcompteBancaire` int NOT NULL AUTO_INCREMENT,
  `TitulaireDuCompte` varchar(100) NOT NULL,
  `NumeroDeCompte` varchar(20) NOT NULL,
  `Solde` decimal(10,2) NOT NULL,
  `ClientID` int NOT NULL,
  PRIMARY KEY (`idcompteBancaire`),
  KEY `comptebancaire_client_idclient_fk` (`ClientID`),
  CONSTRAINT `comptebancaire_client_idclient_fk` FOREIGN KEY (`ClientID`) REFERENCES `client` (`idclient`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comptebancaire`
--

LOCK TABLES `comptebancaire` WRITE;
/*!40000 ALTER TABLE `comptebancaire` DISABLE KEYS */;
INSERT INTO `comptebancaire` VALUES (1,'Gentel-Dehenne Matéo','584 586 785 214',574.85,5),(2,'Bergere sarah','584 586 785 214',6996.00,6),(3,'Bergere Marie','584 58 785',4788.00,6);
/*!40000 ALTER TABLE `comptebancaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailcommande`
--

DROP TABLE IF EXISTS `detailcommande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailcommande` (
  `idDetailCommande` int NOT NULL AUTO_INCREMENT,
  `CommandeId` int NOT NULL,
  `ProduitId` int NOT NULL,
  `Quantite` int NOT NULL,
  PRIMARY KEY (`idDetailCommande`),
  KEY `CommandeID_idx` (`CommandeId`),
  KEY `ProduitID_idx` (`ProduitId`),
  CONSTRAINT `CommandeID` FOREIGN KEY (`CommandeId`) REFERENCES `commande` (`idcommande`),
  CONSTRAINT `ProduitID` FOREIGN KEY (`ProduitId`) REFERENCES `produit` (`idproduit`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailcommande`
--

LOCK TABLES `detailcommande` WRITE;
/*!40000 ALTER TABLE `detailcommande` DISABLE KEYS */;
INSERT INTO `detailcommande` VALUES (3,2,13,2);
/*!40000 ALTER TABLE `detailcommande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paiement` (
  `idPaiement` int NOT NULL AUTO_INCREMENT,
  `CommandeID` int NOT NULL,
  `CompteBancaireID` int NOT NULL,
  `Montant` decimal(10,2) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`idPaiement`),
  KEY `CommandeID_paiement_idx` (`CommandeID`),
  KEY `CompteBancaireID_idx` (`CompteBancaireID`),
  CONSTRAINT `CommandeID_paiement` FOREIGN KEY (`CommandeID`) REFERENCES `commande` (`idcommande`),
  CONSTRAINT `CompteBancaireID` FOREIGN KEY (`CompteBancaireID`) REFERENCES `comptebancaire` (`idcompteBancaire`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiement`
--

LOCK TABLES `paiement` WRITE;
/*!40000 ALTER TABLE `paiement` DISABLE KEYS */;
INSERT INTO `paiement` VALUES (3,2,2,504.00,'2023-11-20');
/*!40000 ALTER TABLE `paiement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produit`
--

DROP TABLE IF EXISTS `produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produit` (
  `idproduit` int NOT NULL AUTO_INCREMENT,
  `Nom` varchar(100) NOT NULL,
  `Description` varchar(250) DEFAULT NULL,
  `Prix` decimal(10,2) NOT NULL,
  `Stock` int NOT NULL,
  `Image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idproduit`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
INSERT INTO `produit` VALUES (10,'Tenue de Pompier','Pour combattre le feu',224.00,3,'https://dodo.ac/np/images/0/0a/Firefighter_Uniform_%28Black%29_NH_Icon.png'),(11,'Costume de Ninja','Pour être le roi des arts martiaux',224.00,6,'https://dodo.ac/np/images/e/e7/Ninja_Costume_%28Dark_Blue%29_NH_Icon.png'),(12,'Robe de Noblesse','Pour être la reine du bal !',520.00,5,'https://dodo.ac/np/images/e/e3/Noble_Dress_%28White%29_NH_Icon.png'),(13,'Robe Victorienne','Pour les fans d\'Histoire',252.00,6,'https://dodo.ac/np/images/9/93/Victorian_Dress_%28Red%29_NH_Icon.png'),(14,'Maillot de Baseball','Pour être le meilleur joueur de baseball',112.00,85,'https://dodo.ac/np/images/1/10/Baseball_Shirt_%28White%29_NH_Icon.png'),(15,'T-Shirt Bonjour','Pour être poli au quotidien ! ',64.00,112,'https://dodo.ac/np/images/f/f9/Bonjour_Tee_NH_Icon.png'),(16,'T-Shirt de Camping','Alors, on attend pas Patrick ?',84.00,92,'https://dodo.ac/np/images/f/ff/Camper_Tee_NH_Icon.png'),(17,'Uniforme de café','Parfait pour votre nouveau travail de serveur.',500.00,500,'https://dodo.ac/np/images/6/66/Caf%C3%A9_Uniform_%28Black%29_NH_Icon.png'),(20,'Jupe école','Jupe parfaite pour vos tenues d\'automne !',45.00,4,'https://dodo.ac/np/images/3/36/Checkered_School_Skirt_%28Dark_Gray%29_NH_Icon.png');
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(50) NOT NULL,
  `Role` enum('admin','client') NOT NULL,
  `motDePasse` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'sarah','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'),(2,'marcus','client','948fe603f61dc036b5c596dc09fe3ce3f3d30dc90f024c85f3c82db2ccab679d'),(3,'lala','client','948fe603f61dc036b5c596dc09fe3ce3f3d30dc90f024c85f3c82db2ccab679d'),(5,'Marieee','client','948fe603f61dc036b5c596dc09fe3ce3f3d30dc90f024c85f3c82db2ccab679d'),(6,'MGD','client','948fe603f61dc036b5c596dc09fe3ce3f3d30dc90f024c85f3c82db2ccab679d'),(7,'scarabee','client','948fe603f61dc036b5c596dc09fe3ce3f3d30dc90f024c85f3c82db2ccab679d');
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-25 18:54:05
