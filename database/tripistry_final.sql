/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: tripistry
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `tripistry`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tripistry` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;

USE `tripistry`;

--
-- Table structure for table `accomodation`
--

DROP TABLE IF EXISTS `accomodation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accomodation` (
  `AccomodationID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Type` enum('Hotel','Hostel','Airbnb','Resort') NOT NULL,
  `Check_in_time` time DEFAULT NULL,
  `Check_out_time` time DEFAULT NULL,
  `DestinationID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AccomodationID`),
  KEY `DestinationID` (`DestinationID`),
  CONSTRAINT `1` FOREIGN KEY (`DestinationID`) REFERENCES `destination` (`DestinationID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accomodation`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `accomodation` WRITE;
/*!40000 ALTER TABLE `accomodation` DISABLE KEYS */;
INSERT INTO `accomodation` VALUES
(1,'Paris Luxury Hotel','Hotel','14:00:00','11:00:00',1),
(2,'Shibuya Hostel','Hostel','15:00:00','10:00:00',2),
(3,'Table Mountain Resort','Resort','14:00:00','10:00:00',3),
(4,'Times Square Inn','Hotel','15:00:00','12:00:00',4),
(5,'Bondi Beach Airbnb','Airbnb','13:00:00','10:00:00',5),
(6,'Rome Heritage Suites','Hotel','14:00:00','11:00:00',6),
(7,'Pyramids View View','Hotel','12:00:00','10:00:00',7),
(8,'Sukhumvit Backpackers','Hostel','14:00:00','12:00:00',8),
(9,'London Eye Apartment','Airbnb','15:00:00','11:00:00',9),
(10,'Rio Cabana Hotel','Hotel','14:00:00','12:00:00',10),
(11,'Marina Luxury Stay','Hotel','15:00:00','12:00:00',11),
(12,'Northern Lights Lodge','Resort','16:00:00','11:00:00',12),
(13,'Inca Trail Hostel','Hostel','11:00:00','09:00:00',13),
(14,'CN View Condos','Airbnb','16:00:00','11:00:00',14),
(15,'Colaba Palace Hotel','Hotel','14:00:00','12:00:00',15),
(16,'Ramblas Apartments','Airbnb','14:00:00','11:00:00',16),
(17,'Auckland Marina Inn','Hotel','15:00:00','10:00:00',17),
(18,'Safari Lodge','Resort','12:00:00','10:00:00',18),
(19,'Atlas Mountain Riad','Hotel','13:00:00','12:00:00',19),
(20,'Seminyak Beach Villa','Resort','14:00:00','12:00:00',20),
(21,'Sandton Sun Hotel','Hotel','14:00:00','11:00:00',21),
(22,'Durban Beach Resort','Resort','13:00:00','10:00:00',22),
(23,'Kruger Safari Lodge','Resort','12:00:00','09:00:00',23),
(24,'Zanzibar Beach Villa','Resort','14:00:00','11:00:00',24),
(25,'Victoria Falls Hotel','Hotel','15:00:00','11:00:00',25),
(26,'Casablanca Riad','Hotel','14:00:00','12:00:00',26),
(27,'Miami Beach Hotel','Hotel','15:00:00','11:00:00',27),
(28,'Luxor Winter Palace','Hotel','14:00:00','12:00:00',28),
(29,'Osaka Dotonbori Inn','Hotel','15:00:00','11:00:00',29),
(30,'Lisbon Alfama Hostel','Hostel','14:00:00','12:00:00',30),
(31,'Amsterdam Canal House','Airbnb','15:00:00','11:00:00',31),
(32,'Berlin Mitte Hotel','Hotel','14:00:00','12:00:00',32),
(33,'Santorini Cliffside','Resort','14:00:00','11:00:00',33),
(34,'Istanbul Bosphorus','Hotel','15:00:00','12:00:00',34),
(35,'Vienna Grand Hotel','Hotel','14:00:00','11:00:00',35),
(36,'Phuket Beachfront','Resort','13:00:00','11:00:00',36),
(37,'Kyoto Ryokan Inn','Hotel','16:00:00','10:00:00',37),
(38,'Marina Bay Sands','Hotel','15:00:00','11:00:00',38),
(39,'Hanoi Old Quarter','Hostel','14:00:00','12:00:00',39),
(40,'Maldives Water Villa','Resort','14:00:00','12:00:00',40),
(41,'New Orleans Jazz Hotel','Hotel','15:00:00','11:00:00',41),
(42,'Vancouver Waterfront','Hotel','14:00:00','12:00:00',42),
(43,'Cancun All-Inclusive','Resort','13:00:00','11:00:00',43),
(44,'Buenos Aires Boutique','Hotel','15:00:00','12:00:00',44),
(45,'Cusco Heritage Hotel','Hotel','14:00:00','11:00:00',45),
(46,'Nice Promenade Hotel','Hotel','14:00:00','11:00:00',46),
(47,'Fiji Overwater Villa','Resort','14:00:00','12:00:00',47),
(48,'Zurich Old Town Hotel','Hotel','15:00:00','12:00:00',48),
(49,'Athens Plaka Hotel','Hotel','14:00:00','11:00:00',49),
(50,'Stockholm Gamla Stan','Hotel','15:00:00','12:00:00',50);
/*!40000 ALTER TABLE `accomodation` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `accomodation_amenities`
--

DROP TABLE IF EXISTS `accomodation_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accomodation_amenities` (
  `AccomodationID` int(11) NOT NULL,
  `Amenities` varchar(50) NOT NULL,
  PRIMARY KEY (`AccomodationID`,`Amenities`),
  CONSTRAINT `1` FOREIGN KEY (`AccomodationID`) REFERENCES `accomodation` (`AccomodationID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accomodation_amenities`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `accomodation_amenities` WRITE;
/*!40000 ALTER TABLE `accomodation_amenities` DISABLE KEYS */;
INSERT INTO `accomodation_amenities` VALUES
(1,'Free Wi-Fi'),
(1,'Pool'),
(2,'Shared Kitchen'),
(3,'Spa'),
(4,'Gym'),
(5,'Ocean View'),
(6,'Air Conditioning'),
(7,'Free Breakfast'),
(8,'Lockers'),
(9,'Washing Machine'),
(10,'Bar'),
(11,'Infinity Pool'),
(12,'Hot Tub'),
(13,'Guided Tour Desk'),
(14,'Balcony'),
(15,'24/7 Room Service'),
(16,'Kitchenette'),
(17,'Parking'),
(18,'Game Drives included'),
(19,'Traditional Hammam'),
(21,'Free Wi-Fi'),
(21,'Gym'),
(21,'Pool'),
(22,'Ocean View'),
(22,'Pool'),
(22,'Spa'),
(23,'Bush Breakfast'),
(23,'Free Wi-Fi'),
(23,'Game Drive'),
(24,'Ocean View'),
(24,'Private Beach'),
(24,'Snorkelling'),
(25,'Bar'),
(25,'Free Wi-Fi'),
(25,'River View'),
(26,'Air Con'),
(26,'Hammam'),
(26,'Rooftop Terrace'),
(27,'Beach Access'),
(27,'Free Wi-Fi'),
(27,'Pool'),
(28,'Free Wi-Fi'),
(28,'Nile View'),
(28,'Pool'),
(29,'Bar'),
(29,'City View'),
(29,'Free Wi-Fi'),
(30,'Free Wi-Fi'),
(30,'Lounge'),
(30,'Tour Desk'),
(31,'Bike Rental'),
(31,'Canal View'),
(31,'Free Wi-Fi'),
(32,'Bar'),
(32,'City View'),
(32,'Free Wi-Fi'),
(33,'Caldera View'),
(33,'Infinity Pool'),
(33,'Spa'),
(34,'Bosphorus View'),
(34,'Free Wi-Fi'),
(34,'Hammam'),
(35,'Fine Dining'),
(35,'Free Wi-Fi'),
(35,'Gym'),
(36,'Pool'),
(36,'Spa'),
(36,'Water Sports'),
(37,'Free Wi-Fi'),
(37,'Garden View'),
(37,'Onsen Bath'),
(38,'Free Wi-Fi'),
(38,'Infinity Pool'),
(38,'Sky Bar'),
(39,'Free Wi-Fi'),
(39,'Lounge'),
(39,'Shared Kitchen'),
(40,'Ocean View'),
(40,'Private Pool'),
(40,'Snorkelling'),
(41,'Bar'),
(41,'Free Wi-Fi'),
(41,'Jazz Lounge'),
(42,'Free Wi-Fi'),
(42,'Gym'),
(42,'Mountain View'),
(43,'All Inclusive'),
(43,'Beach Access'),
(43,'Pool'),
(44,'City View'),
(44,'Free Wi-Fi'),
(44,'Rooftop Bar'),
(45,'Free Wi-Fi'),
(45,'Mountain View'),
(45,'Tour Desk'),
(46,'Free Wi-Fi'),
(46,'Pool'),
(46,'Sea View'),
(47,'Overwater Deck'),
(47,'Private Beach'),
(47,'Snorkelling'),
(48,'Fine Dining'),
(48,'Free Wi-Fi'),
(48,'Gym'),
(49,'Acropolis View'),
(49,'Free Wi-Fi'),
(49,'Pool'),
(50,'City View'),
(50,'Free Wi-Fi'),
(50,'Sauna');
/*!40000 ALTER TABLE `accomodation_amenities` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `attractions`
--

DROP TABLE IF EXISTS `attractions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attractions` (
  `AttractionID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Accessibility_Rating` decimal(3,1) DEFAULT NULL,
  `Popularity_Rating` decimal(3,1) DEFAULT NULL,
  `Opening_Time` time DEFAULT NULL,
  `Closing_Time` time DEFAULT NULL,
  PRIMARY KEY (`AttractionID`),
  CONSTRAINT `chk_accessibility` CHECK (`Accessibility_Rating` between 0.0 and 10.0),
  CONSTRAINT `chk_popularity` CHECK (`Popularity_Rating` between 0.0 and 10.0)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attractions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `attractions` WRITE;
/*!40000 ALTER TABLE `attractions` DISABLE KEYS */;
INSERT INTO `attractions` VALUES
(1,'Eiffel Tower',8.5,9.9,'09:00:00','23:45:00'),
(2,'Senso-ji Temple',7.0,9.5,'06:00:00','17:00:00'),
(3,'Table Mountain',6.5,9.8,'08:00:00','20:00:00'),
(4,'Statue of Liberty',8.0,9.7,'08:30:00','16:00:00'),
(5,'Opera House',9.0,9.9,'09:00:00','17:00:00'),
(6,'Colosseum',6.0,9.9,'08:30:00','19:00:00'),
(7,'Giza Pyramids',4.5,10.0,'08:00:00','17:00:00'),
(8,'Grand Palace',6.0,9.4,'08:30:00','15:30:00'),
(9,'Tower of London',7.5,9.6,'09:00:00','17:30:00'),
(10,'Christ the Redeemer',5.5,9.8,'08:00:00','19:00:00'),
(11,'Burj Khalifa',9.5,9.9,'08:30:00','23:00:00'),
(12,'Blue Lagoon',9.0,9.5,'08:00:00','22:00:00'),
(13,'Machu Picchu Citadel',3.0,9.9,'06:00:00','17:30:00'),
(14,'CN Tower',9.2,9.3,'09:00:00','22:30:00'),
(15,'Gateway of India',8.0,9.1,'00:00:00','23:59:59'),
(16,'Sagrada Familia',8.2,9.9,'09:00:00','20:00:00'),
(17,'Sky Tower',9.0,9.0,'09:30:00','22:00:00'),
(18,'Nairobi Nat Park',5.0,9.2,'06:00:00','18:30:00'),
(19,'Majorelle Garden',7.0,9.3,'08:00:00','18:00:00'),
(20,'Uluwatu Temple',4.0,9.5,'07:00:00','19:00:00'),
(21,'Apartheid Museum',8.5,9.3,'09:00:00','17:00:00'),
(22,'uShaka Marine World',9.0,9.1,'09:00:00','17:00:00'),
(23,'Kruger Nat. Park',5.0,9.9,'06:00:00','18:30:00'),
(24,'Zanzibar Stone Town',7.5,9.2,'08:00:00','20:00:00'),
(25,'Victoria Falls',6.0,9.9,'06:00:00','18:00:00'),
(26,'Hassan II Mosque',8.0,9.4,'09:00:00','18:00:00'),
(27,'South Beach Miami',9.5,9.4,'00:00:00','23:59:00'),
(28,'Karnak Temple',7.0,9.8,'06:00:00','17:30:00'),
(29,'Dotonbori Street',9.0,9.6,'00:00:00','23:59:00'),
(30,'Belem Tower',8.5,9.3,'10:00:00','18:30:00'),
(31,'Anne Frank House',7.0,9.5,'09:00:00','22:00:00'),
(32,'Brandenburg Gate',9.5,9.8,'00:00:00','23:59:00'),
(33,'Oia Sunset Point',6.5,9.8,'00:00:00','23:59:00'),
(34,'Hagia Sophia',8.5,9.9,'09:00:00','17:00:00'),
(35,'Schoenbrunn Palace',9.0,9.6,'08:30:00','17:30:00'),
(36,'Phi Phi Islands',5.0,9.5,'08:00:00','18:00:00'),
(37,'Arashiyama Bamboo',7.0,9.7,'00:00:00','23:59:00'),
(38,'Gardens by the Bay',9.5,9.8,'05:00:00','23:59:00'),
(39,'Hoan Kiem Lake',9.0,9.3,'00:00:00','23:59:00'),
(40,'Maldives Coral Reef',5.0,9.9,'06:00:00','18:00:00'),
(41,'French Quarter',9.5,9.6,'00:00:00','23:59:00'),
(42,'Stanley Park',9.0,9.5,'00:00:00','23:59:00'),
(43,'Chichen Itza',6.0,9.8,'08:00:00','17:00:00'),
(44,'La Boca Caminito',8.5,9.2,'10:00:00','18:00:00'),
(45,'Rainbow Mountain',3.0,9.6,'05:00:00','16:00:00'),
(46,'Nice Old Town',9.0,9.2,'00:00:00','23:59:00'),
(47,'Coral Coast Reef',5.0,9.7,'07:00:00','18:00:00'),
(48,'Rhine Falls',8.5,9.3,'09:00:00','18:00:00'),
(49,'Acropolis Athens',8.0,9.9,'08:00:00','20:00:00'),
(50,'Gamla Stan',9.0,9.4,'00:00:00','23:59:00');
/*!40000 ALTER TABLE `attractions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `BookingID` int(11) NOT NULL AUTO_INCREMENT,
  `Price_paid` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Status` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending',
  `PackageID` int(11) DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `PackageID` (`PackageID`),
  CONSTRAINT `1` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE SET NULL,
  CONSTRAINT `chk_price_paid` CHECK (`Price_paid` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES
(1,1200,'2026-05-01','Confirmed',1),
(2,2300,'2026-03-15','Confirmed',2),
(3,1500,'2026-06-20','Confirmed',3),
(4,950,'2026-08-12','Pending',4),
(5,3100,'2026-11-01','Confirmed',5),
(6,1400,'2026-05-10','Cancelled',6),
(7,1100,'2026-10-05','Confirmed',7),
(8,850,'2026-12-15','Confirmed',8),
(9,1600,'2026-06-02','Confirmed',9),
(10,1800,'2026-01-10','Confirmed',10),
(11,2500,'2026-02-12','Confirmed',11),
(12,2000,'2026-01-02','Confirmed',12),
(13,1350,'2026-04-18','Pending',13),
(14,700,'2026-06-15','Confirmed',14),
(15,1250,'2026-10-22','Confirmed',15),
(16,1300,'2026-07-05','Confirmed',16),
(17,2900,'2026-11-18','Confirmed',17),
(18,2200,'2026-08-01','Confirmed',18),
(19,1050,'2026-03-20','Cancelled',19),
(20,1450,'2026-07-28','Confirmed',20),
(21,1900,'2026-06-15','Confirmed',21),
(22,1000,'2026-07-05','Confirmed',22),
(23,2500,'2026-08-10','Confirmed',23),
(24,3000,'2026-09-15','Confirmed',24),
(25,1800,'2026-10-22','Pending',25),
(26,1200,'2026-05-18','Confirmed',26),
(27,1050,'2026-06-25','Confirmed',27),
(28,1500,'2026-11-10','Confirmed',28),
(29,1800,'2026-07-20','Confirmed',29),
(30,1400,'2026-08-28','Pending',30),
(31,1800,'2026-06-08','Confirmed',31),
(32,1500,'2026-07-14','Confirmed',32),
(33,3100,'2026-08-05','Confirmed',33),
(34,2200,'2026-09-20','Confirmed',34),
(35,2000,'2026-10-18','Confirmed',35),
(36,2500,'2026-06-30','Confirmed',36),
(37,2800,'2026-04-08','Confirmed',37),
(38,3400,'2026-07-25','Confirmed',38),
(39,1200,'2026-08-12','Pending',39),
(40,4800,'2026-12-01','Confirmed',40),
(41,1600,'2026-03-12','Confirmed',41),
(42,2300,'2026-06-20','Confirmed',42),
(43,3000,'2026-12-22','Confirmed',43),
(44,2000,'2026-10-08','Confirmed',44),
(45,1700,'2026-05-30','Confirmed',45),
(46,2200,'2026-07-10','Confirmed',46),
(47,4000,'2026-08-16','Confirmed',47),
(48,2600,'2026-09-04','Confirmed',48),
(49,2400,'2026-10-14','Pending',49),
(50,2100,'2026-11-24','Confirmed',50);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `destination`
--

DROP TABLE IF EXISTS `destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination` (
  `DestinationID` int(11) NOT NULL AUTO_INCREMENT,
  `City_Name` varchar(20) NOT NULL,
  `Country_Name` varchar(30) NOT NULL,
  `Busy_Season` varchar(10) NOT NULL,
  `Continent` varchar(30) NOT NULL,
  PRIMARY KEY (`DestinationID`),
  CONSTRAINT `chk_busy_season` CHECK (`Busy_Season` in ('Summer','Winter','Spring','Autumn','All Year'))
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `destination` WRITE;
/*!40000 ALTER TABLE `destination` DISABLE KEYS */;
INSERT INTO `destination` VALUES
(1,'Paris','France','Summer','Europe'),
(2,'Tokyo','Japan','Spring','Asia'),
(3,'Cape Town','South Africa','Winter','Africa'),
(4,'New York','United States','Autumn','North America'),
(5,'Sydney','Australia','Summer','Oceania'),
(6,'Rome','Italy','Summer','Europe'),
(7,'Cairo','Egypt','Winter','Africa'),
(8,'Bangkok','Thailand','Winter','Asia'),
(9,'London','United Kingdom','Summer','Europe'),
(10,'Rio de Janeiro','Brazil','Summer','South America'),
(11,'Dubai','UAE','Winter','Asia'),
(12,'Reykjavik','Iceland','Winter','Europe'),
(13,'Machu Picchu','Peru','Winter','South America'),
(14,'Toronto','Canada','Summer','North America'),
(15,'Mumbai','India','Winter','Asia'),
(16,'Barcelona','Spain','Summer','Europe'),
(17,'Auckland','New Zealand','Summer','Oceania'),
(18,'Nairobi','Kenya','All Year','Africa'),
(19,'Marrakesh','Morocco','Spring','Africa'),
(20,'Bali','Indonesia','Summer','Asia'),
(21,'Johannesburg','South Africa','Summer','Africa'),
(22,'Durban','South Africa','Summer','Africa'),
(23,'Kruger Park','South Africa','Winter','Africa'),
(24,'Zanzibar','Tanzania','Summer','Africa'),
(25,'Victoria Falls','Zimbabwe','Winter','Africa'),
(26,'Casablanca','Morocco','Spring','Africa'),
(27,'Miami','United States','Summer','North America'),
(28,'Luxor','Egypt','Winter','Africa'),
(29,'Osaka','Japan','Spring','Asia'),
(30,'Lisbon','Portugal','Summer','Europe'),
(31,'Amsterdam','Netherlands','Summer','Europe'),
(32,'Berlin','Germany','Summer','Europe'),
(33,'Santorini','Greece','Summer','Europe'),
(34,'Istanbul','Turkey','Spring','Europe'),
(35,'Vienna','Austria','Summer','Europe'),
(36,'Phuket','Thailand','Winter','Asia'),
(37,'Kyoto','Japan','Spring','Asia'),
(38,'Singapore','Singapore','All Year','Asia'),
(39,'Hanoi','Vietnam','Autumn','Asia'),
(40,'Maldives','Maldives','Winter','Asia'),
(41,'New Orleans','United States','Spring','North America'),
(42,'Vancouver','Canada','Summer','North America'),
(43,'Cancun','Mexico','Winter','North America'),
(44,'Buenos Aires','Argentina','Spring','South America'),
(45,'Cusco','Peru','Winter','South America'),
(46,'Nice','France','Summer','Europe'),
(47,'Fiji','Fiji','Winter','Oceania'),
(48,'Zurich','Switzerland','Summer','Europe'),
(49,'Athens','Greece','Summer','Europe'),
(50,'Stockholm','Sweden','Summer','Europe');
/*!40000 ALTER TABLE `destination` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `FlightID` int(11) NOT NULL AUTO_INCREMENT,
  `Flight_Name` varchar(20) NOT NULL,
  `Departure_City` varchar(20) NOT NULL,
  `Departure_Date` date NOT NULL,
  `Departure_Time` time NOT NULL,
  `Arrival_City` varchar(20) NOT NULL,
  `Duration` decimal(10,2) NOT NULL,
  PRIMARY KEY (`FlightID`),
  CONSTRAINT `chk_flight_duration` CHECK (`Duration` > 0.00)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES
(1,'AirFrance 012','New York','2026-06-01','08:00:00','Paris',7.50),
(2,'JapanAir 705','Los Angeles','2026-04-10','12:30:00','Tokyo',11.20),
(3,'SA Airways 240','London','2026-07-15','21:00:00','Cape Town',11.50),
(4,'Delta 442','London','2026-09-20','10:15:00','New York',8.00),
(5,'Qantas 011','Los Angeles','2026-12-05','23:30:00','Sydney',15.00),
(6,'ITA Airways 610','New York','2026-06-15','17:45:00','Rome',8.25),
(7,'EgyptAir 986','Paris','2026-11-12','14:20:00','Cairo',4.50),
(8,'ThaiAir 741','Dubai','2026-01-20','02:10:00','Bangkok',6.00),
(9,'BritishAir 178','New York','2026-07-01','10:00:00','London',7.10),
(10,'LATAM 810','Miami','2026-02-18','22:00:00','Rio de Janeiro',8.50),
(11,'Emirates 202','New York','2026-03-05','23:00:00','Dubai',12.40),
(12,'IcelandAir 322','Boston','2026-01-15','20:30:00','Reykjavik',5.30),
(13,'Avianca 045','Miami','2026-05-22','06:15:00','Lima',5.45),
(14,'AirCanada 501','Chicago','2026-07-10','09:00:00','Toronto',1.45),
(15,'AirIndia 102','New York','2026-11-25','13:45:00','Mumbai',14.20),
(16,'Vueling 1420','Paris','2026-08-02','11:15:00','Barcelona',1.40),
(17,'AirNZ 002','San Francisco','2026-12-12','21:50:00','Auckland',13.10),
(18,'KenyaAir 101','London','2026-09-05','18:20:00','Nairobi',8.45),
(19,'RoyalAir 402','Paris','2026-04-14','15:30:00','Marrakesh',3.15),
(20,'Garuda 822','Sydney','2026-08-20','07:10:00','Bali',6.20),
(21,'SAA 101','Cape Town','2026-06-10','08:00:00','Johannesburg',1.50),
(22,'FlySafair 210','Johannesburg','2026-07-01','10:30:00','Durban',1.00),
(23,'Kulula 305','Johannesburg','2026-08-05','06:00:00','Kruger Park',0.75),
(24,'KenyaAir 440','Nairobi','2026-09-12','14:00:00','Zanzibar',1.50),
(25,'Ethiopian 512','Addis Ababa','2026-10-20','09:00:00','Victoria Falls',3.00),
(26,'RoyalAir 615','Casablanca','2026-05-15','11:30:00','Marrakesh',0.75),
(27,'American 720','New York','2026-06-22','07:00:00','Miami',0.75),
(28,'EgyptAir 825','Cairo','2026-11-08','13:00:00','Luxor',0.75),
(29,'JAL 930','Tokyo','2026-07-18','09:00:00','Osaka',0.50),
(30,'TAP Air 035','London','2026-08-25','10:00:00','Lisbon',2.25),
(31,'KLM 140','London','2026-06-05','09:00:00','Amsterdam',1.25),
(32,'Lufthansa 245','Frankfurt','2026-07-12','08:00:00','Berlin',1.00),
(33,'Aegean 350','Athens','2026-08-02','10:30:00','Santorini',0.75),
(34,'Turkish 455','Istanbul','2026-09-18','08:00:00','Athens',1.75),
(35,'Austrian 560','Vienna','2026-10-15','14:00:00','Rome',1.50),
(36,'ThaiAir 665','Bangkok','2026-06-28','11:00:00','Phuket',1.25),
(37,'JAL 770','Tokyo','2026-04-05','09:30:00','Kyoto',0.50),
(38,'SingaporeAir 875','Singapore','2026-07-22','08:00:00','Bali',2.25),
(39,'Vietnam 980','Hanoi','2026-08-10','10:00:00','Ho Chi Minh',2.00),
(40,'MaldivianAir 085','Colombo','2026-11-30','14:30:00','Maldives',1.75),
(41,'Delta 190','Atlanta','2026-03-10','09:00:00','New Orleans',1.50),
(42,'AirCanada 295','Toronto','2026-06-18','11:00:00','Vancouver',5.00),
(43,'Aeromexico 300','Mexico City','2026-12-20','08:30:00','Cancun',2.00),
(44,'LATAM 405','Santiago','2026-10-05','13:00:00','Buenos Aires',2.00),
(45,'LATAM 510','Lima','2026-05-28','06:00:00','Cusco',1.25),
(46,'EasyJet 615','Paris','2026-07-08','10:00:00','Nice',1.25),
(47,'FijiAir 720','Sydney','2026-08-14','10:00:00','Fiji',4.00),
(48,'Swiss 825','London','2026-09-02','09:00:00','Zurich',1.75),
(49,'Aegean 930','London','2026-10-12','10:00:00','Athens',3.50),
(50,'SAS 035','London','2026-11-22','09:00:00','Stockholm',2.50);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `group_trip`
--

DROP TABLE IF EXISTS `group_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_trip` (
  `GroupID` int(11) NOT NULL AUTO_INCREMENT,
  `TravellerID` int(11) DEFAULT NULL,
  `Travel_AgencyID` int(11) DEFAULT NULL,
  `PackageID` int(11) DEFAULT NULL,
  PRIMARY KEY (`GroupID`),
  KEY `TravellerID` (`TravellerID`),
  KEY `Travel_AgencyID` (`Travel_AgencyID`),
  KEY `PackageID` (`PackageID`),
  CONSTRAINT `1` FOREIGN KEY (`TravellerID`) REFERENCES `traveler` (`UserID`) ON DELETE SET NULL,
  CONSTRAINT `2` FOREIGN KEY (`Travel_AgencyID`) REFERENCES `travel_agency` (`UserID`) ON DELETE SET NULL,
  CONSTRAINT `3` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_trip`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `group_trip` WRITE;
/*!40000 ALTER TABLE `group_trip` DISABLE KEYS */;
INSERT INTO `group_trip` VALUES
(1,1,11,1),
(2,2,12,2),
(3,3,13,3),
(4,4,14,4),
(5,5,15,5),
(6,6,16,6),
(7,7,17,7),
(8,8,18,8),
(9,9,19,9),
(10,10,20,10),
(11,21,11,11),
(12,22,12,12),
(13,23,13,13),
(14,24,14,14),
(15,25,15,15),
(16,26,16,16),
(17,27,17,17),
(18,28,18,18),
(19,29,19,19),
(20,30,20,20),
(21,51,41,21),
(22,52,42,22),
(23,53,43,23),
(24,54,44,24),
(25,55,45,25),
(26,56,46,26),
(27,57,47,27),
(28,58,48,28),
(29,59,49,29),
(30,60,50,30),
(31,61,41,31),
(32,62,42,32),
(33,63,43,33),
(34,64,44,34),
(35,65,45,35);
/*!40000 ALTER TABLE `group_trip` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `PackageID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Price` int(11) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `Description` text DEFAULT NULL,
  `Max_Group_Size` int(11) DEFAULT NULL,
  `Travel_AgencyID` int(11) DEFAULT NULL,
  `Offers_Group_Trip` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`PackageID`),
  KEY `Travel_AgencyID` (`Travel_AgencyID`),
  CONSTRAINT `2` FOREIGN KEY (`Travel_AgencyID`) REFERENCES `travel_agency` (`UserID`) ON DELETE SET NULL,
  CONSTRAINT `chk_package_dates` CHECK (`End_Date` >= `Start_Date`),
  CONSTRAINT `chk_package_price` CHECK (`Price` >= 0),
  CONSTRAINT `chk_group_size` CHECK (`Max_Group_Size` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES
(1,'Romantic Paris Escape',1500,'2026-06-01','2026-06-07','7 Days in Paris with museum tours.',10,11,1),
(2,'Tokyo Highlights',2500,'2026-04-10','2026-04-18','Experience Tokyo history and modern life.',15,12,1),
(3,'Cape Town Adventure',1800,'2026-07-15','2026-07-25','Explore Table Mountain and Vineyards.',12,13,1),
(4,'NYC City Lights',1100,'2026-09-20','2026-09-24','Broadway and Statue of Liberty tours.',20,14,0),
(5,'Ultimate Sydney Tour',3300,'2026-12-05','2026-12-15','Opera house entry and coastal cruising.',8,15,1),
(6,'Classic Rome Heritage',1600,'2026-06-15','2026-06-22','Colosseum and Vatican guide package.',15,16,0),
(7,'Ancient Wonders Egypt',1200,'2026-11-12','2026-11-19','Pyramids, Sphinx and Nile cruises.',25,17,1),
(8,'Bangkok Culture Tour',900,'2026-01-20','2026-01-26','Temples and street food expeditions.',30,18,0),
(9,'Historic London Tour',1750,'2026-07-01','2026-07-08','Tower of London exploration stay.',14,19,1),
(10,'Rio Carnival Special',2100,'2026-02-18','2026-02-24','VIP access to world famous festival.',50,20,1),
(11,'Luxury Dubai Escape',2800,'2026-03-05','2026-03-11','High life in the modern desert wonderland.',12,11,0),
(12,'Icelandic Wonders',2200,'2026-01-15','2026-01-22','Chasing auroras and Blue Lagoon relaxation.',16,12,1),
(13,'Inca Discovery',1500,'2026-05-22','2026-05-30','Trek to Machu Picchu sacred ruins.',10,13,0),
(14,'Discover Toronto',850,'2026-07-10','2026-07-14','CN tower view and urban discovery.',20,14,0),
(15,'Mumbai Dynamic Beats',1300,'2026-11-25','2026-12-02','Bollywood tours and ocean drive nights.',18,15,1),
(16,'Barcelona Architecture',1450,'2026-08-02','2026-08-09','Gaudi masterpiece walks and beaches.',15,16,0),
(17,'Auckland Explorer',3100,'2026-12-12','2026-12-22','Sailing tours and volcanic climbs.',10,17,0),
(18,'Wild Kenya Safari',2500,'2026-09-05','2026-09-12','Big Five national park game safaris.',8,18,1),
(19,'Marrakesh Nights',1150,'2026-04-14','2026-04-20','Spices, souks, and historic riad stays.',12,19,0),
(20,'Bali Tropical Paradise',1600,'2026-08-20','2026-08-28','Temple sunset tours and beach resorts.',15,20,0),
(21,'Joburg City Experience',1900,'2026-06-10','2026-06-16','Explore Soweto, Apartheid Museum and Maboneng.',20,41,1),
(22,'Durban Beach Escape',1000,'2026-07-01','2026-07-05','Golden Mile beaches, uShaka and curry trail.',25,42,1),
(23,'Kruger Big Five Safari',2500,'2026-08-05','2026-08-12','Guided game drives in Kruger National Park.',10,46,1),
(24,'Zanzibar Island Paradise',3000,'2026-09-12','2026-09-19','Spice tours, Stone Town and Indian Ocean beaches.',15,48,0),
(25,'Victoria Falls Adventure',1800,'2026-10-20','2026-10-26','The great waterfall plus bungee and rafting.',12,43,1),
(26,'Casablanca City Tour',1200,'2026-05-15','2026-05-20','Hassan II Mosque and medina food tours.',18,47,0),
(27,'Miami Beach Experience',1050,'2026-06-22','2026-06-27','South Beach, Art Deco and Ocean Drive nightlife.',20,41,1),
(28,'Luxor Ancient Egypt',1500,'2026-11-08','2026-11-14','Karnak Temple and Valley of the Kings.',15,42,0),
(29,'Osaka Food and Culture',1800,'2026-07-18','2026-07-24','Dotonbori street food, Osaka Castle and Namba.',20,41,1),
(30,'Lisbon and Sintra Tour',1400,'2026-08-25','2026-08-30','Belem Tower, Sintra palaces and fado nights.',18,44,0),
(31,'Amsterdam Canals Tour',1800,'2026-06-05','2026-06-11','Van Gogh Museum, Anne Frank House and canals.',20,43,1),
(32,'Berlin History and Arts',1500,'2026-07-12','2026-07-17','Brandenburg Gate, Berlin Wall and Museum Island.',25,44,1),
(33,'Santorini Luxury Retreat',3100,'2026-08-02','2026-08-09','Caldera views, Oia sunset and catamaran cruises.',12,45,0),
(34,'Istanbul East Meets West',2200,'2026-09-18','2026-09-24','Hagia Sophia, Grand Bazaar and Bosphorus cruise.',18,49,1),
(35,'Vienna Classical Tour',2000,'2026-10-15','2026-10-21','Mozart concerts and Schoenbrunn Palace.',15,50,0),
(36,'Phuket Beach and Temples',2500,'2026-06-28','2026-07-05','Phi Phi Islands, Big Buddha and beach clubs.',20,41,1),
(37,'Kyoto Cherry Blossom',2800,'2026-04-05','2026-04-12','Arashiyama bamboo and Fushimi Inari.',15,42,0),
(38,'Singapore City Luxury',3400,'2026-07-22','2026-07-28','Gardens by the Bay and Marina Bay Sands.',20,43,1),
(39,'Hanoi and Halong Bay',1200,'2026-08-10','2026-08-16','Old Quarter food tour and Halong Bay cruise.',25,44,1),
(40,'Maldives Overwater Escape',4800,'2026-11-30','2026-12-07','Private water villa and coral snorkelling.',6,45,0),
(41,'New Orleans Jazz Fest',1600,'2026-03-10','2026-03-15','French Quarter, jazz clubs and Creole cuisine.',20,49,1),
(42,'Vancouver and Whistler',2300,'2026-06-18','2026-06-24','Stanley Park and Whistler skiing.',15,50,1),
(43,'Cancun All-Inclusive Week',3000,'2026-12-20','2026-12-27','Beachfront resort and Chichen Itza day trip.',30,41,1),
(44,'Buenos Aires Tango Tour',2000,'2026-10-05','2026-10-11','La Boca, tango show and premium steakhouse.',18,42,0),
(45,'Machu Picchu Trek',1700,'2026-05-28','2026-06-04','Inca Trail hike and Rainbow Mountain sunrise.',10,46,1),
(46,'Nice and French Riviera',2200,'2026-07-08','2026-07-14','Promenade des Anglais and Monaco day trip.',15,47,0),
(47,'Fiji Island Hopping',4000,'2026-08-14','2026-08-21','Overwater bungalow and coral reef diving.',10,48,1),
(48,'Zurich and Swiss Alps',2600,'2026-09-02','2026-09-08','Rhine Falls, Jungfraujoch and Lucerne.',12,46,0),
(49,'Athens and Greek Islands',2400,'2026-10-12','2026-10-18','Acropolis, Plaka and Santorini ferry.',15,47,1),
(50,'Stockholm Scandinavia',2100,'2026-11-22','2026-11-27','Gamla Stan, Vasa Museum and Nordic cuisine.',18,48,0);
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `package_accomodations`
--

DROP TABLE IF EXISTS `package_accomodations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_accomodations` (
  `PackageID` int(11) NOT NULL,
  `AccomodationID` int(11) NOT NULL,
  PRIMARY KEY (`PackageID`,`AccomodationID`),
  KEY `AccomodationID` (`AccomodationID`),
  CONSTRAINT `1` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`AccomodationID`) REFERENCES `accomodation` (`AccomodationID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_accomodations`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package_accomodations` WRITE;
/*!40000 ALTER TABLE `package_accomodations` DISABLE KEYS */;
INSERT INTO `package_accomodations` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,22),
(23,23),
(24,24),
(25,25),
(26,26),
(27,27),
(28,28),
(29,29),
(30,30),
(31,31),
(32,32),
(33,33),
(34,34),
(35,35),
(36,36),
(37,37),
(38,38),
(39,39),
(40,40),
(41,41),
(42,42),
(43,43),
(44,44),
(45,45),
(46,46),
(47,47),
(48,48),
(49,49),
(50,50);
/*!40000 ALTER TABLE `package_accomodations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `package_attractions`
--

DROP TABLE IF EXISTS `package_attractions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_attractions` (
  `PackageID` int(11) NOT NULL,
  `AttractionID` int(11) NOT NULL,
  PRIMARY KEY (`PackageID`,`AttractionID`),
  KEY `AttractionID` (`AttractionID`),
  CONSTRAINT `1` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`AttractionID`) REFERENCES `attractions` (`AttractionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_attractions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package_attractions` WRITE;
/*!40000 ALTER TABLE `package_attractions` DISABLE KEYS */;
INSERT INTO `package_attractions` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,21),
(23,21),
(21,22),
(22,22),
(23,23),
(25,23),
(24,24),
(24,25),
(25,25),
(26,26),
(28,26),
(27,27),
(41,27),
(26,28),
(28,28),
(29,28),
(29,29),
(36,29),
(37,29),
(30,30),
(30,31),
(31,31),
(50,31),
(31,32),
(32,32),
(35,32),
(33,33),
(34,33),
(40,33),
(46,33),
(49,33),
(33,34),
(34,34),
(32,35),
(35,35),
(48,35),
(36,36),
(37,37),
(38,38),
(39,38),
(38,39),
(39,39),
(40,40),
(47,40),
(27,41),
(41,41),
(42,41),
(43,41),
(42,42),
(43,43),
(44,44),
(45,44),
(44,45),
(45,45),
(46,46),
(47,47),
(48,48),
(49,49),
(50,50);
/*!40000 ALTER TABLE `package_attractions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `package_destinations`
--

DROP TABLE IF EXISTS `package_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_destinations` (
  `PackageID` int(11) NOT NULL,
  `DestinationID` int(11) NOT NULL,
  PRIMARY KEY (`PackageID`,`DestinationID`),
  KEY `DestinationID` (`DestinationID`),
  CONSTRAINT `1` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`DestinationID`) REFERENCES `destination` (`DestinationID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_destinations`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package_destinations` WRITE;
/*!40000 ALTER TABLE `package_destinations` DISABLE KEYS */;
INSERT INTO `package_destinations` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,22),
(23,23),
(24,24),
(25,25),
(26,26),
(27,27),
(28,28),
(29,29),
(30,30),
(31,31),
(32,32),
(33,33),
(34,34),
(35,35),
(36,36),
(37,37),
(38,38),
(39,39),
(40,40),
(41,41),
(42,42),
(43,43),
(44,44),
(45,45),
(46,46),
(47,47),
(48,48),
(49,49),
(50,50);
/*!40000 ALTER TABLE `package_destinations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `package_flights`
--

DROP TABLE IF EXISTS `package_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_flights` (
  `PackageID` int(11) NOT NULL,
  `FlightID` int(11) NOT NULL,
  PRIMARY KEY (`PackageID`,`FlightID`),
  KEY `FlightID` (`FlightID`),
  CONSTRAINT `1` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_flights`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package_flights` WRITE;
/*!40000 ALTER TABLE `package_flights` DISABLE KEYS */;
INSERT INTO `package_flights` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,22),
(23,23),
(24,24),
(25,25),
(26,26),
(27,27),
(28,28),
(29,29),
(30,30),
(31,31),
(32,32),
(33,33),
(34,34),
(35,35),
(36,36),
(37,37),
(38,38),
(39,39),
(40,40),
(41,41),
(42,42),
(43,43),
(44,44),
(45,45),
(46,46),
(47,47),
(48,48),
(49,49),
(50,50);
/*!40000 ALTER TABLE `package_flights` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `RestaurantID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Rating` decimal(3,1) DEFAULT NULL,
  `Type` enum('Fast Food','Fine Dining','Cafe','Casual') NOT NULL,
  `is_vegan` tinyint(1) DEFAULT 0,
  `is_halaal` tinyint(1) DEFAULT 0,
  `DestinationID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RestaurantID`),
  KEY `DestinationID` (`DestinationID`),
  CONSTRAINT `1` FOREIGN KEY (`DestinationID`) REFERENCES `destination` (`DestinationID`) ON DELETE SET NULL,
  CONSTRAINT `chk_rest_rating` CHECK (`Rating` between 0.0 and 10.0),
  CONSTRAINT `chk_vegan_bool` CHECK (`is_vegan` in (0,1)),
  CONSTRAINT `chk_halaal_bool` CHECK (`is_halaal` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES
(1,'Le Bistro',8.5,'Fine Dining',1,0,1),
(2,'Sushi Master',9.2,'Casual',0,0,2),
(3,'The Africa Cafe',8.0,'Casual',1,1,3),
(4,'Burger Joint NYC',7.5,'Fast Food',0,0,4),
(5,'Harbor Grill',8.8,'Fine Dining',0,0,5),
(6,'Roma Pasta',8.4,'Casual',1,0,6),
(7,'Nile Bites',7.9,'Fast Food',0,1,7),
(8,'Bangkok Street Food',9.0,'Fast Food',1,1,8),
(9,'The Pub Lounge',8.1,'Casual',0,0,9),
(10,'Copacabana Churrasco',8.7,'Fine Dining',0,0,10),
(11,'Desert Oasis Diner',8.3,'Fine Dining',0,1,11),
(12,'Reykjavik Fish Fish',8.6,'Casual',0,0,12),
(13,'Andean Flavors',8.2,'Casual',1,0,13),
(14,'Maple Leaf Eats',7.8,'Fast Food',1,0,14),
(15,'Taj Mahal Spices',9.1,'Fine Dining',1,1,15),
(16,'Tapas Central',8.5,'Casual',0,0,16),
(17,'Kiwi Cafe',8.0,'Cafe',1,0,17),
(18,'Savannah Buffet',8.2,'Casual',0,1,18),
(19,'Medina Tajine',8.9,'Fine Dining',1,1,19),
(20,'Ubud Greens',9.3,'Cafe',1,0,20),
(21,'Grillhouse JHB',8.9,'Fine Dining',0,0,21),
(22,'Unity Berea',8.3,'Casual',1,1,22),
(23,'Camp Jabulani',9.5,'Fine Dining',0,0,23),
(24,'The Rock Rest.',9.4,'Fine Dining',0,1,24),
(25,'The Boma',9.1,'Casual',0,0,25),
(26,'Ricks Cafe',8.7,'Fine Dining',0,0,26),
(27,'Joe s Stone Crab',9.2,'Fine Dining',0,0,27),
(28,'Sofra Luxor',8.2,'Casual',0,1,28),
(29,'Ichiran Ramen',9.3,'Fast Food',0,0,29),
(30,'Time Out Market',8.8,'Casual',1,0,30),
(31,'Rijksmuseum Cafe',8.4,'Cafe',1,0,31),
(32,'Berliner Kindl',8.6,'Casual',0,0,32),
(33,'Argo Restaurant',9.2,'Fine Dining',0,0,33),
(34,'Ciya Sofrasi',9.0,'Casual',0,1,34),
(35,'Steirereck',9.6,'Fine Dining',1,0,35),
(36,'Suay Restaurant',8.7,'Fine Dining',1,0,36),
(37,'Nishiki Stall',8.5,'Fast Food',1,0,37),
(38,'Hawker Chan',9.1,'Fast Food',0,1,38),
(39,'Bun Bo Nam Bo',8.9,'Fast Food',0,0,39),
(40,'Ithaa Undersea',9.8,'Fine Dining',0,0,40),
(41,'Dooky Chases',9.0,'Fine Dining',0,0,41),
(42,'Miku Vancouver',9.2,'Fine Dining',0,0,42),
(43,'La Fisheria',8.6,'Casual',0,0,43),
(44,'La Cabrera BA',9.3,'Fine Dining',0,0,44),
(45,'Chicha Gaston',8.8,'Fine Dining',1,0,45),
(46,'Le Plongeoir',9.0,'Fine Dining',0,0,46),
(47,'Saffron Fiji',8.7,'Fine Dining',0,0,47),
(48,'Zeughauskeller',8.7,'Casual',0,0,48),
(49,'Strofi Athens',9.1,'Fine Dining',0,0,49),
(50,'Aifur Stockholm',8.9,'Casual',0,0,50);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `ReviewID` int(11) NOT NULL AUTO_INCREMENT,
  `Rating` decimal(3,1) NOT NULL,
  `Comment` text DEFAULT NULL,
  `Date_Posted` date NOT NULL,
  `PackageID` int(11) DEFAULT NULL,
  `TravellerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ReviewID`),
  KEY `PackageID` (`PackageID`),
  KEY `TravellerID` (`TravellerID`),
  CONSTRAINT `1` FOREIGN KEY (`PackageID`) REFERENCES `package` (`PackageID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`TravellerID`) REFERENCES `traveler` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES
(1,9.5,'Amazing tour! Worth every dollar.','2026-06-10',1,1),
(2,9.0,'Incredible experience, well organized.','2026-04-20',2,2),
(3,8.5,'Beautiful sights, hotel could be slightly better.','2026-07-28',3,3),
(4,7.0,'Decent, too much walking for our group.','2026-09-26',4,4),
(5,10.0,'Best vacation of my entire life!','2026-12-18',5,5),
(6,9.2,'Loved the historical context provided by guides.','2026-06-25',6,6),
(7,8.0,'The pyramids were stunning, weather was hot.','2026-11-22',7,7),
(8,8.8,'Very deep street food immersion, loved it.','2026-02-01',8,8),
(9,9.0,'Brilliant logistics, safe transport lines.','2026-07-10',9,9),
(10,9.9,'The energy during Carnival was unparalleled.','2026-03-01',10,10),
(11,9.1,'Pure luxury from beginning to end.','2026-03-15',11,21),
(12,8.7,'The blue lagoon water was spectacular.','2026-01-25',12,22),
(13,9.6,'A tough physical challenge but unforgettable.','2026-06-05',13,23),
(14,7.9,'Good city overview package.','2026-07-18',14,24),
(15,8.4,'Vibrant sounds and great food.','2026-12-05',15,25),
(16,9.3,'Gaudi designs explained beautifully.','2026-08-12',16,26),
(17,8.9,'New Zealand scenery did not disappoint.','2026-12-24',17,27),
(18,10.0,'Saw lions hunting, mind-blowing.','2026-09-15',18,28),
(19,6.5,'Got lost in markets, communication was tough.','2026-04-25',19,29),
(20,9.7,'Unbelievable ocean sunsets every evening.','2026-09-02',20,30),
(21,9.2,'Soweto tour was deeply moving and educational.','2026-06-18',21,51),
(22,8.5,'Durban beaches are stunning, curry unforgettable.','2026-07-08',22,52),
(23,9.8,'Saw all Big Five on day two. Breathtaking.','2026-08-14',23,53),
(24,9.5,'Zanzibar is paradise. Stone Town was magical.','2026-09-18',24,54),
(25,9.7,'Standing at Victoria Falls left me speechless.','2026-10-25',25,55),
(26,8.8,'Casablanca architecture and food blew my mind.','2026-05-21',26,56),
(27,8.5,'Miami South Beach was electric and vibrant.','2026-06-28',27,57),
(28,9.6,'Karnak Temple at sunrise is one of a kind.','2026-11-15',28,58),
(29,9.3,'Osaka street food is absolutely world class.','2026-07-28',29,59),
(30,8.9,'Lisbon is charming. Sintra was breathtaking.','2026-09-02',30,60),
(31,8.9,'Amsterdam canals are romantic, museums world class.','2026-06-12',31,61),
(32,9.0,'Berlin is raw, creative and unlike any city.','2026-07-18',32,62),
(33,9.7,'Santorini sunset in Oia is worth every cent.','2026-08-10',33,63),
(34,9.4,'Istanbul is the most fascinating city I visited.','2026-09-25',34,64),
(35,9.1,'Vienna is elegance personified. Concerts divine.','2026-10-22',35,65),
(36,9.3,'Phi Phi Islands are even more beautiful in person.','2026-07-08',36,66),
(37,9.8,'Cherry blossoms in Kyoto brought tears to my eyes.','2026-04-14',37,67),
(38,9.5,'Singapore is the most impressive city I know.','2026-07-30',38,68),
(39,8.7,'Halong Bay overnight cruise was unforgettable.','2026-08-18',39,69),
(40,10.0,'Maldives overwater villa is ultimate luxury.','2026-12-10',40,70),
(41,9.0,'New Orleans jazz and food is unlike anywhere else.','2026-03-16',41,71),
(42,9.2,'Whistler skiing combined with Vancouver was perfect.','2026-06-25',42,72),
(43,8.8,'Cancun resort and Chichen Itza was magnificent.','2026-12-28',43,73),
(44,9.4,'Buenos Aires steak and tango was an incredible night.','2026-10-12',44,74),
(45,9.6,'Inca Trail was tough but Machu Picchu worth it.','2026-06-06',45,75),
(46,9.2,'French Riviera is as glamorous as everyone says.','2026-07-15',46,76),
(47,9.9,'Fiji overwater bungalow was our dream honeymoon.','2026-08-23',47,77),
(48,9.5,'Zurich is beautiful. The Swiss Alps were stunning.','2026-09-09',48,78),
(49,9.3,'Acropolis at golden hour is one of the best sights.','2026-10-19',49,79),
(50,8.8,'Stockholm in autumn is magical and incredibly cosy.','2026-11-28',50,80);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `travel_agency`
--

DROP TABLE IF EXISTS `travel_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `travel_agency` (
  `UserID` int(11) NOT NULL,
  `Reg_Number` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Verification_Status` enum('Pending','Verified','Rejected') DEFAULT 'Pending',
  `Commision_rate` int(11) DEFAULT 0,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `idx_agency_reg` (`Reg_Number`),
  CONSTRAINT `1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `chk_commission` CHECK (`Commision_rate` between 0 and 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_agency`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `travel_agency` WRITE;
/*!40000 ALTER TABLE `travel_agency` DISABLE KEYS */;
INSERT INTO `travel_agency` VALUES
(11,10001,'Apex Travel','Verified',10),
(12,10002,'Horizon Tours','Verified',12),
(13,10003,'Global Getaways','Pending',5),
(14,10004,'Blue Sky Vacations','Verified',15),
(15,10005,'Safari Adventures','Verified',8),
(16,10006,'Alpine Escapes','Rejected',0),
(17,10007,'Nomad Journeys','Verified',10),
(18,10008,'Vanguard Travels','Pending',7),
(19,10009,'Coastal Cruises','Verified',14),
(20,10010,'Summit Tours','Verified',11),
(31,10011,'EcoTours Ltd','Verified',9),
(32,10012,'Backpacker Pros','Verified',5),
(33,10013,'Luxury Travel Co','Verified',20),
(34,10014,'City Break Experts','Pending',10),
(35,10015,'Oceanic Voyages','Verified',12),
(36,10016,'Polar Explorers','Verified',15),
(37,10017,'Desert Treks','Rejected',0),
(38,10018,'Culture Route','Verified',8),
(39,10019,'Family Fun Travel','Verified',10),
(40,10020,'Solo Wanderer Corp','Verified',7),
(41,10021,'Wanderlust Co','Verified',10),
(42,10022,'Travel Plus','Verified',12),
(43,10023,'Sunset Voyages','Verified',8),
(44,10024,'Roam Free','Pending',5),
(45,10025,'Pacific Trails','Verified',11),
(46,10026,'African Safaris','Verified',13),
(47,10027,'Cape Routes','Verified',9),
(48,10028,'Kruger Expeditions','Verified',10),
(49,10029,'Elite Escapes','Verified',15),
(50,10030,'Voyage Master','Pending',7);
/*!40000 ALTER TABLE `travel_agency` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `traveler`
--

DROP TABLE IF EXISTS `traveler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `traveler` (
  `UserID` int(11) NOT NULL,
  `Passport_number` varchar(13) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Date_of_Birth` date NOT NULL,
  `Citizenship` varchar(30) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Passport_number` (`Passport_number`),
  CONSTRAINT `1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traveler`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `traveler` WRITE;
/*!40000 ALTER TABLE `traveler` DISABLE KEYS */;
INSERT INTO `traveler` VALUES
(1,'A1234567B','Alice','Smith','1990-05-14','United States'),
(2,'C9876543D','Bob','Jones','1985-11-23','Canada'),
(3,'E4567891F','Charlie','Brown','1995-02-02','United Kingdom'),
(4,'G2345678H','Dana','White','1988-08-19','Australia'),
(5,'I3456789J','Evan','Wright','2000-12-01','New Zealand'),
(6,'K5678901L','Fiona','Gallagher','1993-04-04','Ireland'),
(7,'M6789012N','George','Clark','1979-07-27','South Africa'),
(8,'O7890123P','Hannah','Lewis','1992-10-10','Germany'),
(9,'Q8901234R','Ian','Malcolm','1965-03-18','United States'),
(10,'S9012345T','Julia','Roberts','1982-09-05','United Kingdom'),
(21,'P00000001','John','Doe','1991-01-01','United States'),
(22,'P00000002','Jane','Doe','1992-02-02','United Kingdom'),
(23,'P00000003','Mark','Twain','1980-03-03','United States'),
(24,'P00000004','Mary','Shelley','1985-04-04','United Kingdom'),
(25,'P00000005','Luke','Skywalker','1977-05-05','Australia'),
(26,'P00000006','Leia','Organa','1977-06-06','Australia'),
(27,'P00000007','Han','Solo','1970-07-07','Canada'),
(28,'P00000008','Bruce','Wayne','1989-08-08','United States'),
(29,'P00000009','Clark','Kent','1988-09-09','United States'),
(30,'P00000010','Diana','Prince','1986-10-10','Greece'),
(51,'US1234561A','James','Wilson','1990-03-15','United States'),
(52,'CA9876541B','Sarah','Connor','1988-07-22','Canada'),
(53,'UK4567891C','Mike','Johnson','1995-11-08','United Kingdom'),
(54,'AU2345671D','Emily','Davis','1992-01-30','Australia'),
(55,'NZ3456781E','Chris','Martin','1987-06-14','New Zealand'),
(56,'IE5678901F','Jessica','Taylor','1993-09-25','Ireland'),
(57,'DE6789011G','David','Brown','1980-12-03','Germany'),
(58,'FR7890121H','Lisa','White','1991-04-18','France'),
(59,'US8901231I','Ryan','Thomas','1997-08-07','United States'),
(60,'CA9012341J','Amanda','Harris','1984-02-28','Canada'),
(61,'ZA1000001K','Thabo','Nkosi','1991-05-10','South Africa'),
(62,'ZA1000002L','Amahle','Dlamini','1994-08-22','South Africa'),
(63,'ZA1000003M','Sipho','Zulu','1988-11-15','South Africa'),
(64,'ZA1000004N','Nomvula','Khumalo','1996-03-07','South Africa'),
(65,'ZA1000005O','Lungelo','Mthembu','1990-07-19','South Africa'),
(66,'TN1000006P','Fatima','Omar','1993-12-01','Tunisia'),
(67,'GH1000007Q','Kwame','Asante','1985-04-30','Ghana'),
(68,'SN1000008R','Aisha','Diallo','1992-09-14','Senegal'),
(69,'FR1000009S','Pierre','Dubois','1979-06-23','France'),
(70,'JP1000010T','Yuki','Tanaka','1998-01-11','Japan'),
(71,'MX1000011U','Carlos','Mendez','1986-05-20','Mexico'),
(72,'IN1000012V','Priya','Sharma','1993-08-14','India'),
(73,'UK1000013W','Oliver','Smith','1989-11-30','United Kingdom'),
(74,'IT1000014X','Sofia','Rossi','1991-03-25','Italy'),
(75,'IE1000015Y','Liam','OConnor','1987-07-12','Ireland'),
(76,'SE1000016Z','Emma','Johansson','1994-01-08','Sweden'),
(77,'DE1000017A','Noah','Mueller','1982-09-17','Germany'),
(78,'BR1000018B','Isabella','Santos','1996-04-03','Brazil'),
(79,'CN1000019C','William','Chen','1990-12-22','China'),
(80,'NL1000020D','Mia','Vandenberg','1988-06-15','Netherlands');
/*!40000 ALTER TABLE `traveler` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `traveller_bookings`
--

DROP TABLE IF EXISTS `traveller_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `traveller_bookings` (
  `TravellerID` int(11) NOT NULL,
  `BookingID` int(11) NOT NULL,
  PRIMARY KEY (`TravellerID`,`BookingID`),
  KEY `BookingID` (`BookingID`),
  CONSTRAINT `1` FOREIGN KEY (`TravellerID`) REFERENCES `traveler` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traveller_bookings`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `traveller_bookings` WRITE;
/*!40000 ALTER TABLE `traveller_bookings` DISABLE KEYS */;
INSERT INTO `traveller_bookings` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(21,11),
(22,12),
(23,13),
(24,14),
(25,15),
(26,16),
(27,17),
(28,18),
(29,19),
(30,20),
(51,21),
(52,22),
(53,23),
(54,24),
(55,25),
(56,26),
(57,27),
(58,28),
(59,29),
(60,30),
(61,31),
(62,32),
(63,33),
(64,34),
(65,35),
(66,36),
(67,37),
(68,38),
(69,39),
(70,40),
(71,41),
(72,42),
(73,43),
(74,44),
(75,45),
(76,46),
(77,47),
(78,48),
(79,49),
(80,50);
/*!40000 ALTER TABLE `traveller_bookings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `traveller_grouptrips`
--

DROP TABLE IF EXISTS `traveller_grouptrips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `traveller_grouptrips` (
  `TravellerID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  PRIMARY KEY (`TravellerID`,`GroupID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `1` FOREIGN KEY (`TravellerID`) REFERENCES `traveler` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`GroupID`) REFERENCES `group_trip` (`GroupID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traveller_grouptrips`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `traveller_grouptrips` WRITE;
/*!40000 ALTER TABLE `traveller_grouptrips` DISABLE KEYS */;
INSERT INTO `traveller_grouptrips` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(21,11),
(22,12),
(23,13),
(24,14),
(25,15),
(26,16),
(27,17),
(28,18),
(29,19),
(30,20),
(51,21),
(52,22),
(53,23),
(54,24),
(55,25),
(56,26),
(57,27),
(58,28),
(59,29),
(60,30),
(61,31),
(62,32),
(63,33),
(64,34),
(65,35);
/*!40000 ALTER TABLE `traveller_grouptrips` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(30) NOT NULL,
  `Registration_Date` date NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `idx_user_email` (`Email`),
  CONSTRAINT `chk_email_format` CHECK (`Email` like '%@%.%')
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'alice.smith@travel.com','2025-01-10'),
(2,'bob.jones@world.com','2025-01-15'),
(3,'charlie.brown@trip.com','2025-01-20'),
(4,'dana.white@explore.com','2025-01-22'),
(5,'evan.wright@journey.com','2025-01-25'),
(6,'fiona.gall@roam.com','2025-02-01'),
(7,'george.clark@trek.com','2025-02-03'),
(8,'hannah.lewis@wander.com','2025-02-05'),
(9,'ian.malcolm@voyage.com','2025-02-10'),
(10,'julia.roberts@tour.com','2025-02-12'),
(11,'info@apex-travel.com','2024-05-01'),
(12,'contact@horizon-tours.com','2024-06-12'),
(13,'sales@global-getaways.com','2024-07-20'),
(14,'support@blue-sky-vacations.com','2024-08-15'),
(15,'admin@safari-adventures.com','2024-09-01'),
(16,'bookings@alpine-escapes.com','2024-10-10'),
(17,'hello@nomad-journeys.com','2024-11-05'),
(18,'info@vanguard-travels.com','2024-12-01'),
(19,'contact@coastal-cruises.com','2025-01-02'),
(20,'reservations@summit-tours.com','2025-01-05'),
(21,'t1@test.com','2025-02-15'),
(22,'t2@test.com','2025-02-16'),
(23,'t3@test.com','2025-02-17'),
(24,'t4@test.com','2025-02-18'),
(25,'t5@test.com','2025-02-19'),
(26,'t6@test.com','2025-02-20'),
(27,'t7@test.com','2025-02-21'),
(28,'t8@test.com','2025-02-22'),
(29,'t9@test.com','2025-02-23'),
(30,'t10@test.com','2025-02-24'),
(31,'a1@agency.com','2024-01-01'),
(32,'a2@agency.com','2024-01-02'),
(33,'a3@agency.com','2024-01-03'),
(34,'a4@agency.com','2024-01-04'),
(35,'a5@agency.com','2024-01-05'),
(36,'a6@agency.com','2024-01-06'),
(37,'a7@agency.com','2024-01-07'),
(38,'a8@agency.com','2024-01-08'),
(39,'a9@agency.com','2024-01-09'),
(40,'a10@agency.com','2024-01-10'),
(41,'info@wanderlust-co.com','2024-02-01'),
(42,'hello@travelplus.com','2024-02-05'),
(43,'contact@sunsetvoyages.com','2024-02-10'),
(44,'admin@roamfree.com','2024-02-15'),
(45,'bookings@pacifictrails.com','2024-03-01'),
(46,'info@africansafaris.com','2024-03-05'),
(47,'support@caperoutes.com','2024-03-10'),
(48,'hello@krugerexpeditions.com','2024-03-15'),
(49,'contact@eliteescapes.com','2024-04-01'),
(50,'admin@voyagemaster.com','2024-04-05'),
(51,'james.wilson@gmail.com','2025-03-01'),
(52,'sarah.connor@yahoo.com','2025-03-02'),
(53,'mike.johnson@outlook.com','2025-03-03'),
(54,'emily.davis@gmail.com','2025-03-04'),
(55,'chris.martin@hotmail.com','2025-03-05'),
(56,'jessica.taylor@gmail.com','2025-03-06'),
(57,'david.brown@yahoo.com','2025-03-07'),
(58,'lisa.white@outlook.com','2025-03-08'),
(59,'ryan.thomas@gmail.com','2025-03-09'),
(60,'amanda.harris@hotmail.com','2025-03-10'),
(61,'thabo.nkosi@gmail.com','2025-03-11'),
(62,'amahle.dlamini@yahoo.com','2025-03-12'),
(63,'sipho.zulu@gmail.com','2025-03-13'),
(64,'nomvula.khumalo@outlook.com','2025-03-14'),
(65,'lungelo.mthembu@gmail.com','2025-03-15'),
(66,'fatima.omar@gmail.com','2025-03-16'),
(67,'kwame.asante@yahoo.com','2025-03-17'),
(68,'aisha.diallo@gmail.com','2025-03-18'),
(69,'pierre.dubois@outlook.com','2025-03-19'),
(70,'yuki.tanaka@gmail.com','2025-03-20'),
(71,'carlos.mendez@gmail.com','2025-03-21'),
(72,'priya.sharma@yahoo.com','2025-03-22'),
(73,'oliver.smith@outlook.com','2025-03-23'),
(74,'sofia.rossi@gmail.com','2025-03-24'),
(75,'liam.oconnor@hotmail.com','2025-03-25'),
(76,'emma.johansson@gmail.com','2025-03-26'),
(77,'noah.mueller@yahoo.com','2025-03-27'),
(78,'isabella.santos@gmail.com','2025-03-28'),
(79,'william.chen@outlook.com','2025-03-29'),
(80,'mia.vandenberg@gmail.com','2025-03-30');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-25 14:31:50
