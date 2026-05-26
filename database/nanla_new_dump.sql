/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: nanla
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,'Seminyak Beach Villa','Resort','14:00:00','12:00:00',20);
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
(19,'Traditional Hammam');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,'Uluwatu Temple',4.0,9.5,'07:00:00','19:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,1450,'2026-07-28','Confirmed',20);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,'Bali','Indonesia','Summer','Asia');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,'Garuda 822','Sydney','2026-08-20','07:10:00','Bali',6.20);
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
  PRIMARY KEY (`GroupID`),
  KEY `TravellerID` (`TravellerID`),
  KEY `Travel_AgencyID` (`Travel_AgencyID`),
  CONSTRAINT `1` FOREIGN KEY (`TravellerID`) REFERENCES `traveler` (`UserID`) ON DELETE SET NULL,
  CONSTRAINT `2` FOREIGN KEY (`Travel_AgencyID`) REFERENCES `travel_agency` (`UserID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_trip`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `group_trip` WRITE;
/*!40000 ALTER TABLE `group_trip` DISABLE KEYS */;
INSERT INTO `group_trip` VALUES
(1,1,11),
(2,2,12),
(3,3,13),
(4,4,14),
(5,5,15),
(6,6,16),
(7,7,17),
(8,8,18),
(9,9,19),
(10,10,20),
(11,21,11),
(12,22,12),
(13,23,13),
(14,24,14),
(15,25,15),
(16,26,16),
(17,27,17),
(18,28,18),
(19,29,19),
(20,30,20);
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
  `BookingID` int(11) DEFAULT NULL,
  `Travel_AgencyID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PackageID`),
  KEY `BookingID` (`BookingID`),
  KEY `Travel_AgencyID` (`Travel_AgencyID`),
  CONSTRAINT `1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`) ON DELETE SET NULL,
  CONSTRAINT `2` FOREIGN KEY (`Travel_AgencyID`) REFERENCES `travel_agency` (`UserID`) ON DELETE SET NULL,
  CONSTRAINT `chk_package_dates` CHECK (`End_Date` >= `Start_Date`),
  CONSTRAINT `chk_package_price` CHECK (`Price` >= 0),
  CONSTRAINT `chk_group_size` CHECK (`Max_Group_Size` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES
(1,'Romantic Paris Escape',1500,'2026-06-01','2026-06-07','7 Days in Paris with museum tours.',10,1,11),
(2,'Tokyo Highlights',2500,'2026-04-10','2026-04-18','Experience Tokyo history and modern life.',15,2,12),
(3,'Cape Town Adventure',1800,'2026-07-15','2026-07-25','Explore Table Mountain and Vineyards.',12,3,13),
(4,'NYC City Lights',1100,'2026-09-20','2026-09-24','Broadway and Statue of Liberty tours.',20,4,14),
(5,'Ultimate Sydney Tour',3300,'2026-12-05','2026-12-15','Opera house entry and coastal cruising.',8,5,15),
(6,'Classic Rome Heritage',1600,'2026-06-15','2026-06-22','Colosseum and Vatican guide package.',15,6,16),
(7,'Ancient Wonders Egypt',1200,'2026-11-12','2026-11-19','Pyramids, Sphinx and Nile cruises.',25,7,17),
(8,'Bangkok Culture Tour',900,'2026-01-20','2026-01-26','Temples and street food expeditions.',30,8,18),
(9,'Historic London Tour',1750,'2026-07-01','2026-07-08','Tower of London exploration stay.',14,9,19),
(10,'Rio Carnival Special',2100,'2026-02-18','2026-02-24','VIP access to world famous festival.',50,10,20),
(11,'Luxury Dubai Escape',2800,'2026-03-05','2026-03-11','High life in the modern desert wonderland.',12,11,11),
(12,'Icelandic Wonders',2200,'2026-01-15','2026-01-22','Chasing auroras and Blue Lagoon relaxation.',16,12,12),
(13,'Inca Discovery',1500,'2026-05-22','2026-05-30','Trek to Machu Picchu sacred ruins.',10,13,13),
(14,'Discover Toronto',850,'2026-07-10','2026-07-14','CN tower view and urban discovery.',20,14,14),
(15,'Mumbai Dynamic Beats',1300,'2026-11-25','2026-12-02','Bollywood tours and ocean drive nights.',18,15,15),
(16,'Barcelona Architecture',1450,'2026-08-02','2026-08-09','Gaudi masterpiece walks and beaches.',15,16,16),
(17,'Auckland Explorer',3100,'2026-12-12','2026-12-22','Sailing tours and volcanic climbs.',10,17,17),
(18,'Wild Kenya Safari',2500,'2026-09-05','2026-09-12','Big Five national park game safaris.',8,18,18),
(19,'Marrakesh Nights',1150,'2026-04-14','2026-04-20','Spices, souks, and historic riad stays.',12,19,19),
(20,'Bali Tropical Paradise',1600,'2026-08-20','2026-08-28','Temple sunset tours and beach resorts.',15,20,20);
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
(20,20);
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
(20,20);
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
(20,20);
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
(20,20);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,'Ubud Greens',9.3,'Cafe',1,0,20);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(20,9.7,'Unbelievable ocean sunsets every evening.','2026-09-02',20,30);
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
(40,10020,'Solo Wanderer Corp','Verified',7);
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
(30,'P00000010','Diana','Prince','1986-10-10','Greece');
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
(30,20);
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
(30,20);
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(40,'a10@agency.com','2024-01-10');
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

-- Dump completed on 2026-05-18  7:45:21
