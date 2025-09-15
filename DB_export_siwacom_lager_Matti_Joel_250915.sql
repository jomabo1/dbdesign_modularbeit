/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: siwacom_lager
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

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

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

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

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES
(1,'Jeremy','jeremy@test.ch'),
(2,'Joel','joel@test.ch'),
(3,'Schmid House','schmidhouse@test.ch'),
(4,'Fridu Bühler','fritz@test.ch'),
(5,'Christian Locher','christian@test.ch'),
(6,'HansPeter','hanspeter@test.ch');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_sales`
--

DROP TABLE IF EXISTS `product_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_sales` (
  `product_sales_id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`product_sales_id`),
  KEY `sale_id` (`sale_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_sales_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`),
  CONSTRAINT `product_sales_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sales`
--

LOCK TABLES `product_sales` WRITE;
/*!40000 ALTER TABLE `product_sales` DISABLE KEYS */;
INSERT INTO `product_sales` VALUES
(8,4,17,3,29.90),
(9,5,36,1,64.90),
(10,5,16,3,49.00),
(11,6,1,3,19.90),
(12,7,10,2,14.90),
(13,7,31,5,79.00),
(14,7,44,4,159.00),
(15,7,23,1,69.90),
(16,8,15,6,179.00),
(17,8,5,1,259.00),
(18,8,35,6,21.90),
(19,8,14,3,199.00),
(20,9,1,3,19.90),
(21,9,10,2,14.90),
(22,10,28,1,199.00),
(23,12,39,1,1149.00),
(24,13,22,2,74.90),
(25,13,45,1,169.00),
(26,13,26,1,89.90),
(27,14,19,5,29.90),
(28,14,41,1,829.00),
(29,14,33,2,119.00),
(30,15,14,2,199.00),
(31,15,31,2,79.00),
(32,16,47,2,129.00),
(33,18,49,6,1266.00),
(34,19,3,3,59.00),
(35,19,24,1,129.00),
(36,20,16,3,49.00),
(37,20,32,1,229.00),
(38,20,44,5,159.00),
(39,21,5,1,259.00),
(40,21,12,2,849.00);
/*!40000 ALTER TABLE `product_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
(1,'Logitech M185','Kabellose Maus, 2.4GHz, Nano-Empfänger',12.00,19.90,19,1,1,24),
(2,'Microsoft Wired Keyboard 600','Kabelgebunden, DE-Layout, spritzwassergeschützt',17.00,27.90,18,2,2,24),
(3,'Toshiba Canvio Basics 1TB','USB 3.0, 2.5\", Plug & Play',40.00,59.00,7,3,3,24),
(4,'Epson EcoTank ET-2812','Tintenstrahl, WLAN, Nachfüllsystem',145.00,199.00,4,4,4,36),
(5,'Plustek OpticSlim 1180','A3 Flachbett-Scanner, USB 2.0',190.00,259.00,0,5,5,24),
(6,'ICY BOX USB-C Dockingstation','Dual Monitor, USB, LAN, PD 85W',85.00,129.00,6,6,3,24),
(7,'Aukey FHD Webcam','1080p, Stereo-Mikro, Plug & Play',38.00,59.90,12,7,2,12),
(8,'Trust GXT 322','Gaming-Headset mit Mikrofon, 3.5mm',25.00,39.90,9,8,5,12),
(9,'Sabrent 4-Port USB 3.0 Hub','Mit Ein/Aus-Schaltern',18.00,29.90,14,9,1,12),
(10,'Goobay HDMI-Kabel 2m','4K60Hz, vergoldete Kontakte',7.00,14.90,26,10,2,24),
(11,'Dell Latitude 5440','14\", i5-1345U, 16GB, 512GB SSD',890.00,1199.00,4,11,1,36),
(12,'MEDION Akoya E62013','i5, 16GB, 1TB SSD, Win 11',640.00,849.00,1,12,4,24),
(13,'Philips 243V7QDSB','24\", Full HD, IPS, HDMI/VGA',88.00,129.00,10,13,3,24),
(14,'Adobe Acrobat Pro DC Lizenz','1 Jahr, Download-Version',145.00,199.00,0,14,2,0),
(15,'AVM FRITZ!Box 7530 AX','Wi-Fi 6, Router + Modem',115.00,179.00,0,15,1,24),
(16,'Logitech R400 Presenter','Kabelloser Presenter mit Laserpointer',28.00,49.00,1,10,5,12),
(17,'USB-C zu RJ45 Adapter','USB-C zu RJ45 Adapter',19.90,29.90,0,10,5,24),
(18,'Notebook','Notebook HP ZBook',1000.00,1290.00,5,11,5,24),
(19,'Logitech M330 Silent Plus','Geräuscharme Maus, kabellos, 2.4GHz',17.00,29.90,15,1,1,24),
(20,'Razer DeathAdder V2','Gaming-Maus, kabelgebunden, 20000 DPI',45.00,69.90,8,1,2,24),
(21,'Logitech K280e','Spritzwassergeschützt, flache Tasten, USB',21.00,34.90,15,2,2,24),
(22,'Corsair K55 RGB Pro','Gaming-Tastatur mit Makrotasten und RGB',45.00,74.90,4,2,3,24),
(23,'WD Elements Portable 1TB','USB 3.0, Plug & Play',43.00,69.90,8,3,1,24),
(24,'Seagate Backup Plus Slim 4TB','USB 3.0, flaches Gehäuse',88.00,129.00,3,3,5,24),
(25,'HP LaserJet M110we','Kompakter WLAN-Monochrom-Laserdrucker',65.00,99.90,5,4,1,24),
(26,'Canon PIXMA TS3450','Multifunktionsgerät, WLAN, Farbe',60.00,89.90,6,4,4,24),
(27,'Epson Perfection V39','USB-Flachbettscanner für Fotos/Dokumente',70.00,109.00,3,5,2,24),
(28,'Brother ADS-1200','Mobiler Dokumentenscanner, Duplex',145.00,199.00,1,5,3,24),
(29,'Lenovo ThinkPad USB-C Dock Gen 2','Multiport, 135W, DisplayPort/HDMI',145.00,199.00,4,6,1,12),
(30,'I-Tec USB-C Triple Display Dock','3x Monitor, PD Charging, Gigabit LAN',130.00,179.00,5,6,3,12),
(31,'Microsoft Modern Webcam','1080p HD, integriertes Mikrofon',47.00,79.00,3,7,2,24),
(32,'Logitech Brio 4K','4K Ultra HD, Windows Hello, Autofokus',155.00,229.00,2,7,1,24),
(33,'Jabra Evolve2 40','USB-A, Noise-Cancelling-Mikrofon',78.00,119.00,4,8,4,24),
(34,'Logitech H390','USB, gepolsterter Bügel, Plug & Play',28.00,49.90,12,8,1,24),
(35,'TP-Link UH400 USB 3.0 Hub','4 Ports, tragbar, Plug & Play',13.00,21.90,10,9,2,12),
(36,'Anker PowerExpand 7-in-1','USB-C Hub, HDMI, SD, USB-A',42.00,64.90,8,9,5,12),
(37,'Apple USB-C auf USB Adapter','Original Apple Zubehör',16.00,25.00,25,10,1,12),
(38,'Delock HDMI zu VGA Adapter','Aktiv, mit Audio-Ausgang',14.00,22.90,18,10,3,24),
(39,'HP EliteBook 840 G10','14\", i7-1355U, 16GB, 512GB SSD',850.00,1149.00,4,11,1,36),
(40,'Acer Aspire 5','15.6\", Ryzen 5, 16GB, 1TB SSD',520.00,749.00,8,11,2,24),
(41,'Lenovo ThinkCentre M75q Gen 2','Kompakt-PC, Ryzen 5 PRO, 16GB, 512GB SSD',560.00,829.00,3,12,1,36),
(42,'HP Pavilion TG01-2001ng','Gaming PC, Ryzen 5, GTX 1660',710.00,999.00,2,12,4,24),
(43,'ASUS ProArt PA278QV','27\", WQHD, IPS, Farbkalibriert',280.00,399.00,6,13,2,36),
(44,'LG 24MK600M','24\", Full HD, IPS, HDMI/VGA',110.00,159.00,2,13,3,24),
(45,'Windows 11 Pro Lizenz','OEM Key (Digital)',110.00,169.00,6,14,2,0),
(46,'ESET Internet Security 1 Jahr','Digitale Lizenz, 1 Gerät',18.00,34.90,20,14,3,0),
(47,'Ubiquiti UniFi 6 Lite','WiFi 6 Access Point, PoE',85.00,129.00,3,15,5,24),
(48,'TP-Link Deco X20 3er-Pack','Mesh-WLAN, WiFi 6, AX1800',165.00,229.00,3,15,1,24),
(49,'Apple MacBook Pro M3','Apple MacBook Pro M3 256GB 15GB',999.00,1266.00,12,11,1,24),
(50,'Samsung Odyssey G5','27\" Odyssey G5 G50D QHD 180Hz Gaming Monitor',269.00,299.00,34,13,4,24);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT current_timestamp(),
  `customer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `fk_customer` (`customer_id`),
  CONSTRAINT `fk_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES
(1,'2025-09-01 20:10:54',NULL),
(2,'2025-09-01 20:26:02',NULL),
(3,'2025-09-01 21:11:25',NULL),
(4,'2025-09-04 14:06:30',NULL),
(5,'2025-09-04 14:57:07',1),
(6,'2025-09-04 14:57:42',1),
(7,'2025-09-04 16:31:13',2),
(8,'2025-09-04 17:18:47',3),
(9,'2025-09-04 17:22:43',3),
(10,'2025-09-04 17:24:03',2),
(11,'2025-09-04 17:27:40',2),
(12,'2025-09-04 17:29:45',2),
(13,'2025-09-04 17:32:10',4),
(14,'2025-09-08 18:29:59',1),
(15,'2025-09-08 18:38:46',5),
(16,'2025-09-08 18:40:29',5),
(17,'2025-09-08 18:41:21',5),
(18,'2025-09-11 10:14:04',4),
(19,'2025-09-11 12:08:36',1),
(20,'2025-09-11 14:53:27',1),
(21,'2025-09-15 19:58:46',6);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

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

--
-- Dumping data for table `suppliers`
--

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

-- Dump completed on 2025-09-15 20:03:35
