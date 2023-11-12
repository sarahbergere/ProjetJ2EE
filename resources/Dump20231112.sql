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
  PRIMARY KEY (`idclient`),
  KEY `client_utilisateur_id_fk` (`idUtilisateur`),
  CONSTRAINT `client_utilisateur_id_fk` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Ndeugoue','Marcus','12 boulevard de lhautil','ndeugoue@cy-tech.fr','0612345678',2),(2,'Dehaud','Laure','1 square des abricots','laure.dehaud@gmail.com','0612345678',3),(4,'Bergere','Marie','1 square des abricots','bergeresar@cy-tech.fr','0612345678',5),(5,'Gentel Dehenne','Matéo','12 boulevard de lhautil','genteldehe@cy-tech.fr','0612345678',6);
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
  PRIMARY KEY (`idcommande`),
  KEY `IdClient_idx` (`IdClient`),
  CONSTRAINT `commande_client_idclient_fk` FOREIGN KEY (`IdClient`) REFERENCES `client` (`idclient`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande`
--

LOCK TABLES `commande` WRITE;
/*!40000 ALTER TABLE `commande` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comptebancaire`
--

LOCK TABLES `comptebancaire` WRITE;
/*!40000 ALTER TABLE `comptebancaire` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailcommande`
--

LOCK TABLES `detailcommande` WRITE;
/*!40000 ALTER TABLE `detailcommande` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiement`
--

LOCK TABLES `paiement` WRITE;
/*!40000 ALTER TABLE `paiement` DISABLE KEYS */;
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
  `Description` mediumtext,
  `Prix` decimal(10,2) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`idproduit`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'sarah','admin','admin'),(2,'marcus','client','client'),(3,'lala','client','client'),(5,'Marieee','client','client'),(6,'MGD','client','client');
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

-- Dump completed on 2023-11-12 11:21:08
