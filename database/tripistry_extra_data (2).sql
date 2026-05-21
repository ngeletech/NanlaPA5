

USE tripistry;

SET FOREIGN_KEY_CHECKS = 0;

INSERT IGNORE INTO `user` (`UserID`, `Email`, `Registration_Date`) VALUES
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
(61,'james.wilson@gmail.com','2025-03-01'),
(62,'sarah.connor@yahoo.com','2025-03-02'),
(63,'mike.johnson@outlook.com','2025-03-03'),
(64,'emily.davis@gmail.com','2025-03-04'),
(65,'chris.martin@hotmail.com','2025-03-05'),
(66,'jessica.taylor@gmail.com','2025-03-06'),
(67,'david.brown@yahoo.com','2025-03-07'),
(68,'lisa.white@outlook.com','2025-03-08'),
(69,'ryan.thomas@gmail.com','2025-03-09'),
(70,'amanda.harris@hotmail.com','2025-03-10'),
(71,'thabo.nkosi@gmail.com','2025-03-11'),
(72,'amahle.dlamini@yahoo.com','2025-03-12'),
(73,'sipho.zulu@gmail.com','2025-03-13'),
(74,'nomvula.khumalo@outlook.com','2025-03-14'),
(75,'lungelo.mthembu@gmail.com','2025-03-15'),
(76,'fatima.omar@gmail.com','2025-03-16'),
(77,'kwame.asante@yahoo.com','2025-03-17'),
(78,'aisha.diallo@gmail.com','2025-03-18'),
(79,'pierre.dubois@outlook.com','2025-03-19'),
(80,'yuki.tanaka@gmail.com','2025-03-20');

INSERT IGNORE INTO `travel_agency` (`UserID`, `Reg_Number`, `Name`, `Verification_Status`, `Commision_rate`) VALUES
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

INSERT IGNORE INTO `traveler` (`UserID`, `Passport_number`, `First_Name`, `Last_Name`, `Date_of_Birth`, `Citizenship`) VALUES
(61,'US1234561A','James','Wilson','1990-03-15','United States'),
(62,'CA9876541B','Sarah','Connor','1988-07-22','Canada'),
(63,'UK4567891C','Mike','Johnson','1995-11-08','United Kingdom'),
(64,'AU2345671D','Emily','Davis','1992-01-30','Australia'),
(65,'NZ3456781E','Chris','Martin','1987-06-14','New Zealand'),
(66,'IE5678901F','Jessica','Taylor','1993-09-25','Ireland'),
(67,'DE6789011G','David','Brown','1980-12-03','Germany'),
(68,'FR7890121H','Lisa','White','1991-04-18','France'),
(69,'US8901231I','Ryan','Thomas','1997-08-07','United States'),
(70,'CA9012341J','Amanda','Harris','1984-02-28','Canada'),
(71,'ZA1000001K','Thabo','Nkosi','1991-05-10','South Africa'),
(72,'ZA1000002L','Amahle','Dlamini','1994-08-22','South Africa'),
(73,'ZA1000003M','Sipho','Zulu','1988-11-15','South Africa'),
(74,'ZA1000004N','Nomvula','Khumalo','1996-03-07','South Africa'),
(75,'ZA1000005O','Lungelo','Mthembu','1990-07-19','South Africa'),
(76,'TN1000006P','Fatima','Omar','1993-12-01','Tunisia'),
(77,'GH1000007Q','Kwame','Asante','1985-04-30','Ghana'),
(78,'SN1000008R','Aisha','Diallo','1992-09-14','Senegal'),
(79,'FR1000009S','Pierre','Dubois','1979-06-23','France'),
(80,'JP1000010T','Yuki','Tanaka','1998-01-11','Japan');


INSERT IGNORE INTO `destination` (`DestinationID`, `City_Name`, `Country_Name`, `Busy_Season`, `Continent`) VALUES
(21,'Johannesburg','South Africa','Summer','Africa'),
(22,'Durban','South Africa','Summer','Africa'),
(23,'Kruger Park','South Africa','Winter','Africa'),
(24,'Zanzibar','Tanzania','Summer','Africa'),
(25,'Victoria Falls','Zimbabwe','Winter','Africa'),
(26,'Casablanca','Morocco','Spring','Africa'),
(27,'Accra','Ghana','All Year','Africa'),
(28,'Luxor','Egypt','Winter','Africa'),
(29,'Serengeti','Tanzania','Winter','Africa'),
(30,'Kigali','Rwanda','All Year','Africa'),
(31,'Amsterdam','Netherlands','Summer','Europe'),
(32,'Prague','Czech Republic','Summer','Europe'),
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
(46,'Queenstown','New Zealand','Winter','Oceania'),
(47,'Fiji','Fiji','Winter','Oceania'),
(48,'Windhoek','Namibia','Winter','Africa'),
(49,'Addis Ababa','Ethiopia','All Year','Africa'),
(50,'Lagos','Nigeria','All Year','Africa');


INSERT IGNORE INTO `accomodation` (`AccomodationID`, `Name`, `Type`, `Check_in_time`, `Check_out_time`, `DestinationID`) VALUES
(21,'Sandton Sun Hotel','Hotel','14:00:00','11:00:00',21),
(22,'Durban Beach Resort','Resort','13:00:00','10:00:00',22),
(23,'Kruger Safari Lodge','Resort','12:00:00','09:00:00',23),
(24,'Zanzibar Beach Villa','Resort','14:00:00','11:00:00',24),
(25,'Victoria Falls Hotel','Hotel','15:00:00','11:00:00',25),
(26,'Casablanca Riad','Hotel','14:00:00','12:00:00',26),
(27,'Labadi Beach Hotel','Hotel','15:00:00','11:00:00',27),
(28,'Luxor Winter Palace','Hotel','14:00:00','12:00:00',28),
(29,'Serengeti Tented Camp','Resort','12:00:00','10:00:00',29),
(30,'Kigali Marriott','Hotel','15:00:00','12:00:00',30),
(31,'Amsterdam Canal House','Airbnb','15:00:00','11:00:00',31),
(32,'Prague Old Town Inn','Hotel','14:00:00','12:00:00',32),
(33,'Santorini Cliffside','Resort','14:00:00','11:00:00',33),
(34,'Istanbul Bosphorus Hotel','Hotel','15:00:00','12:00:00',34),
(35,'Vienna Grand Hotel','Hotel','14:00:00','11:00:00',35),
(36,'Phuket Beachfront Resort','Resort','13:00:00','11:00:00',36),
(37,'Kyoto Ryokan Inn','Hotel','16:00:00','10:00:00',37),
(38,'Marina Bay Sands','Hotel','15:00:00','11:00:00',38),
(39,'Hanoi Old Quarter Hostel','Hostel','14:00:00','12:00:00',39),
(40,'Maldives Water Villa','Resort','14:00:00','12:00:00',40),
(41,'New Orleans Jazz Hotel','Hotel','15:00:00','11:00:00',41),
(42,'Vancouver Waterfront Inn','Hotel','14:00:00','12:00:00',42),
(43,'Cancun All-Inclusive','Resort','13:00:00','11:00:00',43),
(44,'Buenos Aires Boutique','Hotel','15:00:00','12:00:00',44),
(45,'Cusco Heritage Hotel','Hotel','14:00:00','11:00:00',45),
(46,'Queenstown Lake Lodge','Resort','14:00:00','10:00:00',46),
(47,'Fiji Overwater Bungalow','Resort','14:00:00','12:00:00',47),
(48,'Windhoek Country Lodge','Hotel','14:00:00','11:00:00',48),
(49,'Addis Sheraton Hotel','Hotel','15:00:00','12:00:00',49),
(50,'Eko Hotel Lagos','Hotel','14:00:00','12:00:00',50);

INSERT IGNORE INTO `accomodation_amenities` (`AccomodationID`, `Amenities`) VALUES
(21,'Free Wi-Fi'),(21,'Pool'),(21,'Gym'),
(22,'Ocean View'),(22,'Spa'),(22,'Pool'),
(23,'Game Drive Included'),(23,'Bush Breakfast'),(23,'Free Wi-Fi'),
(24,'Private Beach'),(24,'Snorkelling Gear'),(24,'Ocean View'),
(25,'River View'),(25,'Free Wi-Fi'),(25,'Bar'),
(26,'Traditional Hammam'),(26,'Rooftop Terrace'),(26,'Air Conditioning'),
(27,'Pool'),(27,'Free Wi-Fi'),(27,'Beach Access'),
(28,'Nile View'),(28,'Pool'),(28,'Free Wi-Fi'),
(29,'Bush Wi-Fi'),(29,'Full Board'),(29,'Game Drives'),
(30,'Free Wi-Fi'),(30,'Gym'),(30,'Rooftop Pool'),
(31,'Canal View'),(31,'Bike Rental'),(31,'Free Wi-Fi'),
(32,'Free Wi-Fi'),(32,'Bar'),(32,'Historic Views'),
(33,'Infinity Pool'),(33,'Caldera View'),(33,'Spa'),
(34,'Bosphorus View'),(34,'Hammam'),(34,'Free Wi-Fi'),
(35,'Free Wi-Fi'),(35,'Gym'),(35,'Fine Dining'),
(36,'Pool'),(36,'Water Sports'),(36,'Spa'),
(37,'Onsen Bath'),(37,'Traditional Breakfast'),(37,'Garden View'),
(38,'Infinity Pool'),(38,'Sky Bar'),(38,'Free Wi-Fi'),
(39,'Shared Kitchen'),(39,'Free Wi-Fi'),(39,'Lounge'),
(40,'Private Pool'),(40,'Snorkelling'),(40,'Ocean View'),
(41,'Jazz Lounge'),(41,'Free Wi-Fi'),(41,'Bar'),
(42,'Mountain View'),(42,'Free Wi-Fi'),(42,'Gym'),
(43,'All-Inclusive Food'),(43,'Pool'),(43,'Beach Access'),
(44,'City View'),(44,'Free Wi-Fi'),(44,'Rooftop Bar'),
(45,'Mountain View'),(45,'Free Wi-Fi'),(45,'Tour Desk'),
(46,'Lake View'),(46,'Ski Access'),(46,'Free Wi-Fi'),
(47,'Overwater Deck'),(47,'Snorkelling'),(47,'Private Beach'),
(48,'Game Drives'),(48,'Free Wi-Fi'),(48,'Pool'),
(49,'Free Wi-Fi'),(49,'Pool'),(49,'Gym'),
(50,'Free Wi-Fi'),(50,'Pool'),(50,'Business Centre');

INSERT IGNORE INTO `attractions` (`AttractionID`, `Name`, `Accessibility_Rating`, `Popularity_Rating`, `Opening_Time`, `Closing_Time`) VALUES
(21,'Apartheid Museum',8.5,9.3,'09:00:00','17:00:00'),
(22,'uShaka Marine World',9.0,9.1,'09:00:00','17:00:00'),
(23,'Kruger Nat. Park',5.0,9.9,'06:00:00','18:30:00'),
(24,'Zanzibar Stone Town',7.5,9.2,'08:00:00','20:00:00'),
(25,'Victoria Falls View',6.0,9.9,'06:00:00','18:00:00'),
(26,'Hassan II Mosque',8.0,9.4,'09:00:00','18:00:00'),
(27,'Kakum Nat. Park',5.5,8.9,'07:00:00','17:00:00'),
(28,'Karnak Temple',7.0,9.8,'06:00:00','17:30:00'),
(29,'Serengeti Plains',4.0,9.9,'06:00:00','19:00:00'),
(30,'Kigali Mem. Centre',8.5,9.0,'08:00:00','17:00:00'),
(31,'Anne Frank House',7.0,9.5,'09:00:00','22:00:00'),
(32,'Prague Castle',8.0,9.7,'06:00:00','22:00:00'),
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
(46,'Milford Sound',5.5,9.9,'00:00:00','23:59:00'),
(47,'Coral Coast Reef',5.0,9.7,'07:00:00','18:00:00'),
(48,'Sossusvlei Dunes',4.0,9.8,'06:00:00','18:00:00'),
(49,'Lalibela Churches',5.5,9.5,'06:00:00','17:30:00'),
(50,'Lekki Market',8.5,8.8,'09:00:00','18:00:00');


INSERT IGNORE INTO `restaurant` (`RestaurantID`, `Name`, `Rating`, `Type`, `is_vegan`, `is_halaal`, `DestinationID`) VALUES
(21,'Grillhouse JHB',8.9,'Fine Dining',0,0,21),
(22,'Unity Berea',8.3,'Casual',1,1,22),
(23,'Camp Jabulani',9.5,'Fine Dining',0,0,23),
(24,'The Rock Rest.',9.4,'Fine Dining',0,1,24),
(25,'The Boma',9.1,'Casual',0,0,25),
(26,'Ricks Cafe',8.7,'Fine Dining',0,0,26),
(27,'Buka Accra',8.5,'Casual',0,1,27),
(28,'Sofra Luxor',8.2,'Casual',0,1,28),
(29,'Bush Dinner',9.3,'Fine Dining',0,0,29),
(30,'Repub Lounge',8.6,'Casual',1,0,30),
(31,'Rijksmuseum Cafe',8.4,'Cafe',1,0,31),
(32,'Lokal Prague',8.8,'Casual',0,0,32),
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
(46,'Botswana Butchery',9.1,'Fine Dining',0,0,46),
(47,'Saffron Fiji',8.7,'Fine Dining',0,0,47),
(48,'Joes Beerhouse',8.5,'Casual',0,0,48),
(49,'Yod Abyssinia',9.0,'Casual',1,0,49),
(50,'Nok by Alara',8.4,'Fine Dining',1,0,50);


INSERT IGNORE INTO `flight` (`FlightID`, `Flight_Name`, `Departure_City`, `Departure_Date`, `Departure_Time`, `Arrival_City`, `Duration`) VALUES
(21,'SAA 101','Cape Town','2026-06-10','08:00:00','Johannesburg',1.50),
(22,'FlySafair 210','Johannesburg','2026-07-01','10:30:00','Durban',1.00),
(23,'Kulula 305','Johannesburg','2026-08-05','06:00:00','Kruger Park',0.75),
(24,'KenyaAir 440','Nairobi','2026-09-12','14:00:00','Zanzibar',1.50),
(25,'Ethiopian 512','Addis Ababa','2026-10-20','09:00:00','Victoria Falls',3.00),
(26,'RoyalAir 615','Casablanca','2026-05-15','11:30:00','Marrakesh',0.75),
(27,'AfricanWings 720','Accra','2026-06-22','07:00:00','Lagos',1.25),
(28,'EgyptAir 825','Cairo','2026-11-08','13:00:00','Luxor',0.75),
(29,'KenyaAir 930','Nairobi','2026-07-18','05:30:00','Serengeti',1.00),
(30,'RwandAir 035','Kigali','2026-08-25','16:00:00','Nairobi',1.50),
(31,'KLM 140','London','2026-06-05','09:00:00','Amsterdam',1.25),
(32,'CSA 245','Prague','2026-07-12','12:00:00','Vienna',1.00),
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
(46,'AirNZ 615','Auckland','2026-07-08','12:00:00','Queenstown',1.75),
(47,'FijiAir 720','Sydney','2026-08-14','10:00:00','Fiji',4.00),
(48,'SAA 825','Johannesburg','2026-09-02','08:30:00','Windhoek',2.50),
(49,'Ethiopian 930','Addis Ababa','2026-10-12','07:00:00','Nairobi',2.00),
(50,'AfricanWings 035','Lagos','2026-11-22','09:00:00','Accra',1.25),
-- Return flights 
(51,'SAA 102','Johannesburg','2026-06-16','14:00:00','Cape Town',1.50),
(52,'FlySafair 211','Durban','2026-07-05','17:00:00','Johannesburg',1.00),
(53,'KenyaAir 441','Zanzibar','2026-09-19','16:00:00','Nairobi',1.50),
(54,'Ethiopian 513','Victoria Falls','2026-10-26','12:00:00','Addis Ababa',3.00),
(55,'KLM 141','Amsterdam','2026-06-11','15:00:00','London',1.25),
(56,'Aegean 351','Santorini','2026-08-09','13:00:00','Athens',0.75),
(57,'ThaiAir 666','Phuket','2026-07-05','16:00:00','Bangkok',1.25),
(58,'JAL 771','Kyoto','2026-04-12','17:00:00','Tokyo',0.50),
(59,'SingaporeAir 876','Bali','2026-07-28','19:00:00','Singapore',2.25),
(60,'AirNZ 616','Queenstown','2026-07-14','15:00:00','Auckland',1.75);


INSERT IGNORE INTO `booking` (`BookingID`, `Price_paid`, `Date`, `Status`, `PackageID`) VALUES
(21,1800,'2026-06-15','Confirmed',21),
(22,950,'2026-07-05','Confirmed',22),
(23,2200,'2026-08-10','Confirmed',23),
(24,2800,'2026-09-15','Confirmed',24),
(25,1600,'2026-10-22','Pending',25),
(26,1100,'2026-05-18','Confirmed',26),
(27,900,'2026-06-25','Confirmed',27),
(28,1400,'2026-11-10','Confirmed',28),
(29,3500,'2026-07-20','Confirmed',29),
(30,1200,'2026-08-28','Pending',30),
(31,1700,'2026-06-08','Confirmed',31),
(32,1300,'2026-07-14','Confirmed',32),
(33,2900,'2026-08-05','Confirmed',33),
(34,2100,'2026-09-20','Confirmed',34),
(35,1900,'2026-10-18','Confirmed',35),
(36,2400,'2026-06-30','Confirmed',36),
(37,2600,'2026-04-08','Confirmed',37),
(38,3200,'2026-07-25','Confirmed',38),
(39,1100,'2026-08-12','Pending',39),
(40,4500,'2026-12-01','Confirmed',40),
(41,1500,'2026-03-12','Confirmed',41),
(42,2200,'2026-06-20','Confirmed',42),
(43,2800,'2026-12-22','Confirmed',43),
(44,1900,'2026-10-08','Confirmed',44),
(45,1600,'2026-05-30','Confirmed',45),
(46,2300,'2026-07-10','Confirmed',46),
(47,3800,'2026-08-16','Confirmed',47),
(48,1400,'2026-09-04','Confirmed',48),
(49,1000,'2026-10-14','Cancelled',49),
(50,850,'2026-11-24','Confirmed',50),
-- Extra bookings: multiple travellers booking the same popular packages
(51,2500,'2026-08-06','Confirmed',23),
(52,3000,'2026-09-13','Confirmed',24),
(53,3800,'2026-07-19','Confirmed',29),
(54,3100,'2026-08-03','Confirmed',33),
(55,4800,'2026-12-02','Confirmed',40),
(56,1900,'2026-06-11','Cancelled',21),
(57,2500,'2026-07-09','Confirmed',46),
(58,1800,'2026-06-06','Confirmed',31),
(59,1300,'2026-07-13','Pending',32),
(60,2800,'2026-04-06','Confirmed',37);


-- PACKAGES (21-50)

INSERT IGNORE INTO `package` (`PackageID`, `Name`, `Price`, `Start_Date`, `End_Date`, `Description`, `Max_Group_Size`, `BookingID`, `Travel_AgencyID`) VALUES
(21,'Joburg City Experience',1900,'2026-06-10','2026-06-16','Explore Soweto, the Apartheid Museum and vibrant Maboneng precinct.',20,21,41),
(22,'Durban Beach Escape',1000,'2026-07-01','2026-07-05','Golden Mile beaches, uShaka Marine World and Durban curry trail.',25,22,42),
(23,'Kruger Big Five Safari',2500,'2026-08-05','2026-08-12','Guided game drives spotting lion, leopard, rhino, elephant and buffalo.',10,23,46),
(24,'Zanzibar Island Paradise',3000,'2026-09-12','2026-09-19','Spice tours, Stone Town UNESCO sites and pristine Indian Ocean beaches.',15,24,48),
(25,'Victoria Falls Adventure',1800,'2026-10-20','2026-10-26','Witness one of the worlds greatest waterfalls plus bungee and rafting.',12,25,43),
(26,'Casablanca and Rabat Tour',1200,'2026-05-15','2026-05-20','Imperial cities, Hassan II Mosque and local medina food tours.',18,26,47),
(27,'Accra Cultural Safari',950,'2026-06-22','2026-06-27','Kakum canopy walk, Cape Coast Castle and Accra street food.',20,27,41),
(28,'Luxor Ancient Egypt',1500,'2026-11-08','2026-11-14','Karnak Temple, Valley of the Kings and Nile sunset felucca ride.',15,28,42),
(29,'Serengeti Migration Tour',3800,'2026-07-18','2026-07-26','Witness millions of wildebeest migrate across the Serengeti plains.',8,29,46),
(30,'Rwanda Gorilla Trekking',1300,'2026-08-25','2026-08-30','Mountain gorilla trekking in Volcanoes National Park and city tour.',10,30,48),
(31,'Amsterdam Canals Tour',1800,'2026-06-05','2026-06-11','Van Gogh Museum, Anne Frank House, canal boat tours and Keukenhof.',20,31,43),
(32,'Prague Fairytale City',1400,'2026-07-12','2026-07-17','Prague Castle, Old Town Square, Charles Bridge and beer tastings.',25,32,44),
(33,'Santorini Luxury Retreat',3100,'2026-08-02','2026-08-09','Caldera views, sunset in Oia, wine tours and catamaran cruises.',12,33,45),
(34,'Istanbul East Meets West',2200,'2026-09-18','2026-09-24','Hagia Sophia, Grand Bazaar, Bosphorus cruise and Turkish bath.',18,34,49),
(35,'Vienna Classical Tour',2000,'2026-10-15','2026-10-21','Mozart concerts, Schoenbrunn Palace, Viennese coffee houses.',15,35,50),
(36,'Phuket Beach and Temples',2500,'2026-06-28','2026-07-05','Phi Phi Islands, Big Buddha, Tiger Cave Temple and beach clubs.',20,36,41),
(37,'Kyoto Cherry Blossom',2800,'2026-04-05','2026-04-12','Arashiyama bamboo, Fushimi Inari, tea ceremony and geisha district.',15,37,42),
(38,'Singapore City Luxury',3400,'2026-07-22','2026-07-28','Gardens by the Bay, Marina Bay Sands, Sentosa Island and hawker food.',20,38,43),
(39,'Hanoi and Halong Bay',1200,'2026-08-10','2026-08-16','Old Quarter food tour, Halong Bay overnight cruise and cave visits.',25,39,44),
(40,'Maldives Overwater Escape',4800,'2026-11-30','2026-12-07','Private water villa, coral snorkelling, sunset dolphin cruise.',6,40,45),
(41,'New Orleans Jazz Fest',1600,'2026-03-10','2026-03-15','French Quarter, jazz clubs, Creole cuisine and swamp airboat tour.',20,41,49),
(42,'Vancouver and Whistler',2300,'2026-06-18','2026-06-24','Stanley Park, Capilano Bridge, Whistler Blackcomb skiing.',15,42,50),
(43,'Cancun All-Inclusive Week',3000,'2026-12-20','2026-12-27','Beachfront resort, Chichen Itza day trip and cenote swimming.',30,43,41),
(44,'Buenos Aires Tango Tour',2000,'2026-10-05','2026-10-11','La Boca, tango show, premium steakhouse and Tigre delta cruise.',18,44,42),
(45,'Machu Picchu Trek',1700,'2026-05-28','2026-06-04','Inca Trail hike, Rainbow Mountain sunrise and Sacred Valley.',10,45,46),
(46,'Queenstown Thrill Seeker',2500,'2026-07-08','2026-07-14','Bungy jumping, skydiving, Milford Sound cruise and skiing.',12,46,47),
(47,'Fiji Island Hopping',4000,'2026-08-14','2026-08-21','Overwater bungalow, coral reef diving, village visits and kava ceremony.',10,47,48),
(48,'Namibia Desert Explorer',1500,'2026-09-02','2026-09-08','Sossusvlei red dunes, Deadvlei, Fish River Canyon and stargazing.',12,48,46),
(49,'Addis Ababa and Lalibela',1100,'2026-10-12','2026-10-17','Rock-hewn Lalibela churches, traditional injera meals and coffee ceremony.',15,49,47),
(50,'Lagos and Abuja Discovery',900,'2026-11-22','2026-11-26','Lekki Market, Nike Art Gallery, Aso Rock and vibrant nightlife.',20,50,48);


-- PACKAGE - DESTINATIONS (one primary per package)

INSERT IGNORE INTO `package_destinations` (`PackageID`, `DestinationID`) VALUES
(21,21),(22,22),(23,23),(24,24),(25,25),
(26,26),(27,27),(28,28),(29,29),(30,30),
(31,31),(32,32),(33,33),(34,34),(35,35),
(36,36),(37,37),(38,38),(39,39),(40,40),
(41,41),(42,42),(43,43),(44,44),(45,45),
(46,46),(47,47),(48,48),(49,49),(50,50);


-- PACKAGE - ACCOMMODATIONS (one primary per package)

INSERT IGNORE INTO `package_accomodations` (`PackageID`, `AccomodationID`) VALUES
(21,21),(22,22),(23,23),(24,24),(25,25),
(26,26),(27,27),(28,28),(29,29),(30,30),
(31,31),(32,32),(33,33),(34,34),(35,35),
(36,36),(37,37),(38,38),(39,39),(40,40),
(41,41),(42,42),(43,43),(44,44),(45,45),
(46,46),(47,47),(48,48),(49,49),(50,50);

-- ============================================
-- PACKAGE - ATTRACTIONS
-- Each package has 2-3 attractions
-- Primary attraction matches destination.
-- Secondary attractions are nearby or thematically linked.
-- ============================================
INSERT IGNORE INTO `package_attractions` (`PackageID`, `AttractionID`) VALUES
-- Joburg: Apartheid Museum + Kruger (day trip) + uShaka (coastal excursion)
(21,21),(21,23),(21,22),
-- Durban: uShaka Marine + Apartheid Museum day trip
(22,22),(22,21),
-- Kruger: Park itself + Apartheid Museum in Joburg stopover
(23,23),(23,21),
-- Zanzibar: Stone Town + Victoria Falls excursion
(24,24),(24,25),
-- Victoria Falls: Falls + Serengeti extension
(25,25),(25,29),
-- Casablanca: Hassan II Mosque + Karnak (Egypt extension)
(26,26),(26,28),
-- Accra: Kakum Park + Lekki Market Lagos day trip
(27,27),(27,50),
-- Luxor: Karnak + Giza Pyramids day trip (from original data)
(28,28),(28,7),
-- Serengeti: Plains + Victoria Falls extension
(29,29),(29,25),(29,18),
-- Rwanda: Kigali Centre + Serengeti extension
(30,30),(30,29),
-- Amsterdam: Anne Frank + Eiffel Tower Paris day trip (from original data)
(31,31),(31,1),
-- Prague: Castle + Schoenbrunn Vienna day trip
(32,32),(32,35),
-- Santorini: Oia Sunset + Colosseum Rome excursion (from original data)
(33,33),(33,6),
-- Istanbul: Hagia Sophia + Sagrada Familia comparison (from original data)
(34,34),(34,16),
-- Vienna: Schoenbrunn + Prague Castle day trip
(35,35),(35,32),
-- Phuket: Phi Phi + Grand Palace Bangkok day trip (from original data)
(36,36),(36,8),
-- Kyoto: Arashiyama Bamboo + Senso-ji Temple Tokyo (from original data)
(37,37),(37,2),
-- Singapore: Gardens by the Bay + Uluwatu Temple Bali (from original data)
(38,38),(38,20),
-- Hanoi: Hoan Kiem Lake + Gardens by the Bay Singapore extension
(39,39),(39,38),
-- Maldives: Coral Reef + Blue Lagoon Iceland comparison (from original data)
(40,40),(40,12),
-- New Orleans: French Quarter + Statue of Liberty NYC (from original data)
(41,41),(41,4),
-- Vancouver: Stanley Park + CN Tower Toronto (from original data)
(42,42),(42,14),
-- Cancun: Chichen Itza + Statue of Liberty comparison
(43,43),(43,4),
-- Buenos Aires: La Boca + Christ the Redeemer Rio (from original data)
(44,44),(44,10),
-- Machu Picchu: Rainbow Mountain + Inca Trail Machu Picchu (from original data)
(45,45),(45,13),
-- Queenstown: Milford Sound + Sydney Opera House (from original data)
(46,46),(46,5),
-- Fiji: Coral Reef + Blue Lagoon Iceland comparison
(47,47),(47,12),
-- Namibia: Sossusvlei + Serengeti extension
(48,48),(48,29),
-- Addis Ababa: Lalibela + Kigali Memorial Centre
(49,49),(49,30),
-- Lagos: Lekki Market + Kakum National Park Ghana
(50,50),(50,27);

-- ============================================
-- PACKAGE - FLIGHTS
-- Each package has outbound + return flight
-- ============================================
INSERT IGNORE INTO `package_flights` (`PackageID`, `FlightID`) VALUES
-- Outbound + return
(21,21),(21,51),
(22,22),(22,52),
(23,23),
(24,24),(24,53),
(25,25),(25,54),
(26,26),
(27,27),
(28,28),
(29,29),
(30,30),
(31,31),(31,55),
(32,32),
(33,33),(33,56),
(34,34),
(35,35),
(36,36),(36,57),
(37,37),(37,58),
(38,38),(38,59),
(39,39),
(40,40),
(41,41),
(42,42),
(43,43),
(44,44),
(45,45),
(46,46),(46,60),
(47,47),
(48,48),
(49,49),
(50,50);


-- TRAVELLER BOOKINGS

INSERT IGNORE INTO `traveller_bookings` (`TravellerID`, `BookingID`) VALUES
(61,21),(62,22),(63,23),(64,24),(65,25),
(66,26),(67,27),(68,28),(69,29),(70,30),
(71,31),(72,32),(73,33),(74,34),(75,35),
(76,36),(77,37),(78,38),(79,39),(80,40),
(61,41),(62,42),(63,43),(64,44),(65,45),
(66,46),(67,47),(68,48),(69,49),(70,50),
-- Extra bookings: popular packages booked by multiple travellers
(71,51),(72,52),(73,53),(74,54),(75,55),
(76,56),(77,57),(78,58),(79,59),(80,60);


-- GROUP TRIPS

INSERT IGNORE INTO `group_trip` (`GroupID`, `TravellerID`, `Travel_AgencyID`) VALUES
(21,61,41),(22,62,42),(23,63,43),(24,64,44),(25,65,45),
(26,66,46),(27,67,47),(28,68,48),(29,69,49),(30,70,50),
(31,71,41),(32,72,42),(33,73,43),(34,74,44),(35,75,45);


-- TRAVELLER GROUP TRIPS

INSERT IGNORE INTO `traveller_grouptrips` (`TravellerID`, `GroupID`) VALUES
(61,21),(62,22),(63,23),(64,24),(65,25),
(66,26),(67,27),(68,28),(69,29),(70,30),
(71,31),(72,32),(73,33),(74,34),(75,35);

-- REVIEWS
-- Multiple reviews per popular package
INSERT IGNORE INTO `review` (`ReviewID`, `Rating`, `Comment`, `Date_Posted`, `PackageID`, `TravellerID`) VALUES
-- New package reviews
(21,9.2,'Soweto tour was deeply moving and incredibly educational.','2026-06-18',21,61),
(22,8.5,'Durban beaches are stunning, the curry was unforgettable.','2026-07-08',22,62),
(23,9.8,'Saw all Big Five on day two. Absolutely breathtaking.','2026-08-14',23,63),
(24,9.5,'Zanzibar is paradise on earth. Stone Town was magical.','2026-09-18',24,64),
(25,9.7,'Standing at Victoria Falls left me completely speechless.','2026-10-25',25,65),
(26,8.8,'Casablanca blew my mind with its architecture and food.','2026-05-21',26,66),
(27,8.3,'Cape Coast Castle was sobering but important to visit.','2026-06-28',27,67),
(28,9.6,'Karnak Temple at sunrise is one of the greatest sights ever.','2026-11-15',28,68),
(29,10.0,'The Great Migration is the most spectacular thing I have seen.','2026-07-28',29,69),
(30,9.1,'Gorilla trekking in Rwanda changed my perspective on life.','2026-09-02',30,70),
(31,8.9,'Amsterdam canals are romantic and the museums world class.','2026-06-12',31,71),
(32,9.0,'Prague is like stepping into a fairy tale.','2026-07-18',32,72),
(33,9.7,'Santorini sunset in Oia is worth every single cent.','2026-08-10',33,73),
(34,9.4,'Istanbul is the most fascinating city I have visited.','2026-09-25',34,74),
(35,9.1,'Vienna is elegance personified. The concerts were divine.','2026-10-22',35,75),
(36,9.3,'Phi Phi Islands are even more beautiful in person.','2026-07-08',36,76),
(37,9.8,'Cherry blossoms in Kyoto brought tears to my eyes.','2026-04-14',37,77),
(38,9.5,'Singapore is the cleanest and most impressive city I know.','2026-07-30',38,78),
(39,8.7,'Halong Bay overnight cruise was an unforgettable experience.','2026-08-18',39,79),
(40,10.0,'Maldives overwater villa is the ultimate luxury escape.','2026-12-10',40,80),
(41,9.0,'New Orleans jazz and food scene is unlike anywhere else.','2026-03-16',41,61),
(42,9.2,'Whistler skiing combined with Vancouver city was perfect.','2026-06-25',42,62),
(43,8.8,'Cancun resort was great and Chichen Itza was magnificent.','2026-12-28',43,63),
(44,9.4,'Buenos Aires steak and tango show was an incredible night.','2026-10-12',44,64),
(45,9.6,'Inca Trail was tough but reaching Machu Picchu was worth it.','2026-06-06',45,65),
(46,9.3,'Queenstown bungy jump was terrifying and brilliant.','2026-07-15',46,66),
(47,9.9,'Fiji overwater bungalow was our dream honeymoon come true.','2026-08-23',47,67),
(48,9.7,'Sossusvlei dunes at sunrise are among the most surreal sights.','2026-09-09',48,68),
(49,8.9,'Lalibela rock churches are a hidden wonder of the world.','2026-10-19',49,69),
(50,8.4,'Lagos energy is infectious, Lekki Market was a great experience.','2026-11-28',50,70),
-- Multiple reviews for popular packages
(51,9.5,'Kruger was unreal. Our guide knew exactly where to find the lions.','2026-08-15',23,71),
(52,8.9,'Zanzibar spice tour was a highlight. Food was incredible.','2026-09-20',24,72),
(53,9.9,'Serengeti exceeded all expectations. Truly life changing.','2026-07-29',29,73),
(54,9.6,'Santorini is the most beautiful place I have ever been.','2026-08-11',33,74),
(55,10.0,'Maldives is absolute heaven. Will definitely return.','2026-12-11',40,75),
(56,7.5,'Joburg was interesting but felt rushed in some areas.','2026-06-17',21,76),
(57,9.1,'Queenstown adventure activities were world class.','2026-07-16',46,77),
(58,8.7,'Amsterdam was charming, loved the canal boat tour.','2026-06-13',31,78),
(59,8.5,'Prague Old Town is stunning, especially at night.','2026-07-19',32,79),
(60,9.7,'Kyoto in cherry blossom season is like a dream.','2026-04-15',37,80);

SET FOREIGN_KEY_CHECKS = 1;


-- Verify record counts

SELECT 'destinations' AS table_name, COUNT(*) AS total_records FROM destination
UNION ALL SELECT 'accommodations', COUNT(*) FROM accomodation
UNION ALL SELECT 'attractions', COUNT(*) FROM attractions
UNION ALL SELECT 'restaurants', COUNT(*) FROM restaurant
UNION ALL SELECT 'flights', COUNT(*) FROM flight
UNION ALL SELECT 'packages', COUNT(*) FROM package
UNION ALL SELECT 'bookings', COUNT(*) FROM booking
UNION ALL SELECT 'reviews', COUNT(*) FROM review
UNION ALL SELECT 'travellers', COUNT(*) FROM traveler
UNION ALL SELECT 'agencies', COUNT(*) FROM travel_agency
UNION ALL SELECT 'pkg_attractions links', COUNT(*) FROM package_attractions
UNION ALL SELECT 'pkg_flights links', COUNT(*) FROM package_flights;
