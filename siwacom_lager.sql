/*M!999999\- enable the sandbox mode */ 

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `siwacom_lager` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `siwacom_lager`;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,'Maus'),
(2,'Tastatur'),
(3,'Externe Festplatte'),
(4,'Drucker'),
(5,'Scanner'),
(6,'Dockingstation'),
(7,'Webcam'),
(8,'Headset'),
(9,'USB-Hub'),
(10,'Kabel & Adapter'),
(11,'Notebook'),
(12,'PC-System'),
(13,'Monitor'),
(14,'Software'),
(15,'Netzwerkgeräte');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warranty_months` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
(1,'Lenovo ThinkPad E15','15\" Notebook, Ryzen 7, 16GB RAM, 512GB SSD',720.00,1049.00,12,1,1,24),
(2,'HP ProDesk 400 G7','Desktop-PC, i5, 8GB RAM, 256GB SSD, Win 11 Pro',520.00,849.00,8,2,2,36),
(3,'Dell P2419H','24\" Full-HD IPS Monitor, höhenverstellbar',110.00,169.00,15,3,3,36),
(4,'Logitech MX Master 3','Kabellose Maus, ergonomisch, USB-C',70.00,109.00,19,4,1,24),
(5,'CHERRY Stream Keyboard','Leise Tastatur mit Nummernblock, DE Layout',25.00,39.90,25,5,2,24),
(6,'Seagate Backup Plus 2TB','Externe HDD, USB 3.0, 2TB',55.00,89.00,10,6,5,24),
(7,'Brother HL-L2350DW','Laser-Drucker, WLAN, Duplex',95.00,139.00,5,7,3,36),
(8,'Canon CanoScan LiDE 300','USB-Flachbettscanner A4',60.00,89.00,5,8,4,24),
(9,'Dell WD19TB','Thunderbolt Dock, USB-C, 180W',180.00,269.00,4,9,1,12),
(10,'Logitech C920 HD Pro','1080p Webcam, Autofokus, USB',60.00,95.00,18,10,2,24),
(11,'EPOS Sennheiser ADAPT 165','USB & 3.5mm Headset, Stereo, Noise Cancelling',45.00,79.00,10,11,5,24),
(12,'Anker 4-Port USB 3.0 Hub','Ultra Slim, USB-betrieben',15.00,25.00,15,12,2,12),
(13,'Delock HDMI zu VGA Adapter','Für Monitore & Beamer',10.00,17.90,40,13,3,12),
(14,'Microsoft Office Home & Business 2021','Einmalige Lizenz, ohne Abo',180.00,249.00,5,14,1,0),
(15,'TP-Link Archer AX10','WLAN-Router, AX1500, Dual-Band',55.00,89.00,9,15,4,24),
(16,'Testprodukt','Testprodukt um zu schauen ob alles läuft',99.90,119.90,0,5,2,24),
(17,'USB-C zu RJ45 Adapter','USB-C zu RJ45 Adapter',19.90,29.90,3,10,5,24);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sale_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `sale_id` (`sale_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `sale_items_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`),
  CONSTRAINT `sale_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sale_items` WRITE;
/*!40000 ALTER TABLE `sale_items` DISABLE KEYS */;
INSERT INTO `sale_items` VALUES
(1,1,4,1,109.00),
(2,1,14,1,249.00),
(3,2,11,4,79.00),
(4,2,16,5,119.90),
(5,3,7,2,139.00),
(6,3,12,15,25.00);
/*!40000 ALTER TABLE `sale_items` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT current_timestamp(),
  `customer_name` varchar(100) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES
(1,'2025-09-01 20:10:54','Max Mustermann','max@example.com'),
(2,'2025-09-01 20:26:02','Test Kunde','test@kunde.ch'),
(3,'2025-09-01 21:11:25','Joel','joel@test.ch');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES
(1,'Digitec Galaxus','info@digitec.ch','044 575 96 00','Zürich, Schweiz'),
(2,'Alltron','kontakt@alltron.ch','062 889 12 34','Mägenwil, Schweiz'),
(3,'VarioTrend','support@variotrend.ch','041 123 45 67','Luzern, Schweiz'),
(4,'ElectronicPartner','info@ep.ch','043 456 78 90','Zürich, Schweiz'),
(5,'semi electronics','sales@semi-electronics.ch','031 654 32 10','Bern, Schweiz');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

