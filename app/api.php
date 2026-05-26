<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

    header("Content-Type: application/json");
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: POST");
    header("Access-Control-Allow-Headers: Content-Type");

    require_once('config.php');

    class Tripistry {
        private $conn;
        private $data;

        public function __construct($dbConnection, $requestData){
            $this->conn = $dbConnection;
            $this->data = $requestData;
        }

        private function sendError($message, $statusCode = 400) {
            http_response_code($statusCode);
            echo json_encode([
                "status" => "error",
                "data" => $message
            ]);

            exit();
        }

        private function sendResponse($data, $statusCode = 200){
            http_response_code($statusCode);
            echo json_encode ([
                "status" => "success",
                "data" => $data
            ]);
            exit();
        }

        public function processRequest() {
            if(!isset($this->data['type'])){
                $this->sendError("Missing parameter", 400);
                exit();
            }

            $type = $this->data['type'];
            switch ($type) {
                case 'Register':
                    $this->register();
                    break;
                case 'Login':
                    $this->login();
                    break;
                case 'GetProfile':
                    $this->getProfile();
                    break;
                case 'GetTravelAgengcies':
                    $this->getTravelAgencies();
                    break;
                case 'CreatePackage':
                    $this->createPackage();
                    break;
                case 'UpdatePackage':
                    $this->updatePackage();
                    break;
                case 'DeletePackage':
                    $this->deletePackage();
                    break;
                case 'GetPackages':
                    $this->getPackages();
                    break;
                case 'GetDestinations':
                    $this->getDestinations();
                    break;
                case 'GetAccomodations':
                    $this->getAccomodations();
                    break;
                case 'GetAttractions':
                    $this->getAttractions();
                    break;
                case 'GetRestaurants':
                    $this->getRestaurants();
                    break;
                case 'BookPackage':
                    $this->bookPackage();
                    break;
                case 'ViewPackage':
                    $this->viewPackage();
                    break;
                case 'getFlights':
                    $this->getFlights();
                    break;
                case 'makeReview':
                    $this->makeReview();
                    break;
                case 'GetReview':
                    $this->getReviews();
                    break;
                case 'GetReviewCount':
                    $this->getReviewCount();
                    break;
                case 'GetTravellerProfile':
                    $this->getTravellerProfile();
                    break;
                case 'UpdateTravellerProfile':
                    $this->updateTravellerProfile();
                    break;
                //Agency profile functions
                    case 'GetAgencyProfile':
                    $this->getAgencyProfile();
                    break;
                case 'UpdateAgencyProfile':
                    $this->updateAgencyProfile();
                    break;
                case 'GetAgencyPackages':
                    $this->getAgencyPackages();
                    break;
                case 'GetAgencyStats':
                    $this->getAgencyStats();
                    break;
                case 'GetAgencyRecentBookings':
                    $this->getAgencyRecentBookings();
                    break;
                    
                case 'GetRecentBookings':
                    $this->getRecentBookings();
                    break;

                case 'GetRecommendedPackages':
                    $this->getRecommendedPackages();
                    break;

                //GroupTrips
                case 'GetAgencyGroupTrips':
                    $this->getAgencyGroupTrips();
                    break;
                case 'CreateGroupTrip':
                    $this->createGroupTrip();
                    break;
                case 'DeleteGroupTrip':
                    $this->deleteGroupTrip();
                    break;  
                case 'UpdateGroupTrip':
                    $this->updateGroupTrip();
                    break; 
                case 'GetAllTravellers':
                    $this->getAllTravellers();
                    break;  
                
                case 'Logout':
                    if (session_status() === PHP_SESSION_NONE)session_start();
                    session_destroy();
                    $this->sendResponse("Logged out", 200);
                    break;
                default:
                    $this->sendError("Invalid" , 400);
                    break;
            }
        }



        //1
        private function register(){

            error_log("=== REGISTER CALLED ===");
            error_log("Received data: " . print_r($this->data, true));

            if(!isset($this->data['user_type']) || empty($this->data['user_type'])){
                $this->sendError('Missing user type', 400);
                return;
            }

            
            $user_type = $this->data['user_type'];
            $email = $this->data['email'];
            $password = $this->data['password'];
              
            $emailRegex = '/^[a-zA-Z0-9._%+=]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/';
            if(!preg_match($emailRegex, $email)){
                $this->sendError("Invalid email format",400);
                return;
            }
    
            $passwordRegex = '/^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{9,}$/';
            if(!preg_match( $passwordRegex, $password)){
                $this->sendError("Password must be longer than 8 characters and must contail uppercase, lowercase, digit and symbol",400);
                return;
            }

            $stmt = $this->conn->prepare("SELECT UserID FROM user WHERE Email = ?");
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $stmt->store_result();
            if($stmt->num_rows > 0){
                $this->sendError("Email already exists",400);
                return;
            }

            $stmt->close();

            $salt = bin2hex(random_bytes(16)); //32 chars generate a random bytes and convert it to hexadecemal
            $hashedPassword = hash('sha256', $salt . $password); //adding the hexadecimal to the password and run thro

            $stmt = $this->conn->prepare("INSERT INTO user (Email, Registration_Date,hashed_password, salt) VALUES (?, CURDATE(), ?, ?)");
            $stmt->bind_param("sss", $email, $hashedPassword, $salt);
            if(!$stmt->execute()){
                $this->sendError("Registration failed: ".$stmt->error, 500);
                return;
            }

            $userID = $this->conn->insert_id;
            $stmt->close();
            
            if($user_type === 'Traveller'){
                if(!isset( $this->data['name']) || !isset( $this->data['surname']) || !isset( $this->data['DOB']) || !isset( $this->data['passnum']) || !isset( $this->data['citizenship'])){
                $this->sendError('Missing parameter',400);
                return;
                }

                $name = $this->data['name'];
                $surname = $this->data['surname'];
                $dob = $this->data['DOB'];
                $passport = $this->data['passnum'];
                $citizenship = $this->data['citizenship'];
            

                $stmt = $this->conn->prepare("INSERT INTO traveler (UserID,Passport_number, First_Name, Last_Name, Date_of_Birth, Citizenship) VALUES (?,?,?,?,?,?)");
                $stmt->bind_param("isssss", $userID, $passport, $name, $surname, $dob, $citizenship);

            } else if ($user_type === 'Travel Agency'){
                if(!isset( $this->data['name'])  || !isset( $this->data['reg_num'])){
                $this->sendError('Missing parameter',400);
                return;
                }

                $name = $this->data['name'];
                $reg_num = $this->data['reg_num'];

                $stmt = $this->conn->prepare("INSERT INTO travel_agency (UserID, Reg_Number, Name, Verification_Status, Commision_rate) VALUES (?, ?, ?, 'Pending', 0)");
                $stmt->bind_param("iis", $userID, $reg_num, $name);
            } else {
                $this->conn->prepare("DELETE FROM user WHERE UserID = ?")->execute([$userID]);
                $this->sendError("Invalid user type", 400);
                return;
            }
            if($stmt->execute()){
                $this->sendResponse(" Registration successful",200);
            } else {
                $reverse = $this->conn->prepare("DELETE FROM user WHERE UserID = ?");
                $reverse->bind_param("i", $userID);
                $reverse->execute();
                $this->sendError("Registration failed: " . $stmt->error,500);

            }

        }
        
        //2
        private function getProfile(){
            if(!isset($this->data['userID'])){
                $this->sendError("Missing userID", 400);
                return;
            }

            $userID = $this->data['userID'];

            $stmt = $this->conn->prepare("SELECT u.UserID,u.Email,  u.Registration_Date, t.First_name, t.Last_Name, t.Passport_number, t.Date_of_Birth, t.Citizenship, 'Traveller' AS user_type FROM user as u JOIN traveler as t on u.UserID = t.userID WHERE u.UserID = ? ");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $user = $result->fetch_assoc();
            $stmt->close();

            if(!$user){
                $stmt = $this->conn->prepare("SELECT u.UserID, u.Email, u.Registration_Date, ta.Name, ta.Reg_Number, ta.Verification_Status, ta.Commision_rate, 'Travel Agency' AS user_type FROM user as u JOIN traveler_agency as ta on u.UserID = ta.userID WHERE u.UserID = ? ");
                $stmt->bind_param("i", $userID);
                $stmt->execute();
                $result = $stmt->get_result();
                $user = $result->fetch_assoc();
                $stmt->close();
            }

            if (!$user) {
                $this->sendError("User not found", 404);
                return;
            }

            $this->sendResponse($user,200);

        }


        //3
        private function login(){

            if(!isset($this->data['email']) || !isset($this->data['password'])){
                $this->sendError("Missing parameters", 400);
                return;
            }

            $email = $this->data['email'];
            $password = $this->data['password'];

            if(empty($email) || empty($password)){
                $this->sendError("Missing parameters", 400);
                return;
            }


            $emailRegex = '/^[a-zA-Z0-9._%+=]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/';
            if(!preg_match($emailRegex, $email)){
                $this->sendError("Invalid email format",400);
                return;
            }

            $stmt = $this->conn->prepare("SELECT UserID, Email, hashed_password, salt FROM user WHERE Email = ?");
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();
            $user = $result->fetch_assoc();
            $stmt->close();

            if(!$user){
                    $this->sendError("Invalid email or password",401);
                return;
                        
            }
            $hashedInput = hash('sha256', $user['salt'] . $password);
            if($hashedInput !== $user['hashed_password']){
                $this->sendError("Invalid email or password",401);
                return;
            }  
            
            $userID = $user['UserID'];

            $stmt = $this->conn->prepare("SELECT First_Name AS name, 'Traveller' AS type FROM traveler WHERE UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $profile = $result->fetch_assoc();
            $stmt->close();

            if(!$profile){
                $stmt = $this->conn->prepare("SELECT Name AS name, 'Travel Agency' AS type FROM travel_agency WHERE UserID = ?");
                $stmt->bind_param("i", $userID);
                $stmt->execute();
                $result = $stmt->get_result();
                $profile = $result->fetch_assoc();
                $stmt->close();
            }

            if(!$profile){
                $this->sendError("User profile not found", 404);
                return;
            }

            if(session_status() === PHP_SESSION_NONE)session_start();
            $_SESSION['user_id'] = $userID;
            $_SESSION['user_name'] = $profile['name'];
            $_SESSION['user_type'] = $profile['type'] === 'Travel Agency' ? 'agency' : 'traveller';

            $this->sendResponse([
                "user" => $userID,
                "name"=> $profile['name'],
                "email"=> $user['Email'],
                "type" => $profile['type']

            ], 200);            
            
        }


        //4
        private function getTravelAgencies(){

            //basic get all travellers
            $sql = "SELECT Name from travel_agency WHERE 1 = 1";
            $result = $this->conn->query($sql);
            $agencies = [];
            while($row = $result->fetch_assoc()){
                $agencies[] = $row;
            }
            $this->sendResponse($agencies, 200);
            return; 
        }

        //5
        private function getPackages(){
            if(session_status() === PHP_SESSION_NONE) session_start();

            $destination = $this->data['destination'] ?? '';
            $minPrice = $this->data['min_price'] ?? '';
            $maxPrice = $this->data['max_price'] ?? '';
            $minDuration = $this->data['min_duration'] ?? '';
            $maxDuration = $this->data['max_duration'] ?? '';
            $minRating = $this->data['min_rating'] ?? '';
            $groupOnly = $this->data['group_only'] ?? 0;
            $sort = $this->data['sort'] ?? 'price_asc';
                                                            
            $sql = "SELECT p.PackageID, p.Name, p.Description, p.Price, p.Start_Date, p.Max_Group_Size, p.Offers_Group_Trip AS Is_Group_Trip ,DATEDIFF(p.End_Date, p.Start_Date) AS Duration, ta.Name as AgencyName, COALESCE(AVG(r.Rating), 0) AS AvgRating, COUNT(r.ReviewID) AS ReviewCount
                    FROM package AS p
                    LEFT JOIN travel_agency AS ta ON p.Travel_AgencyID = ta.UserID
                    LEFT JOIN review AS r ON p.PackageID = r.PackageID";

            if(!empty($destination)){
                $sql .= " LEFT JOIN package_destinations AS pd ON p.PackageID = pd.PackageID
                          LEFT JOIN destination AS d ON pd.DestinationID = d.DestinationID";
            }

            $sql .= " WHERE 1=1";

            $params = [];
            $types = '';
            if(!empty($destination)){
                $sql .= " AND (d.City_Name LIKE ? OR d.Country_Name LIKE ? OR d.Continent LIKE ?)";
                $searchDestination = '%'. $destination .'%';
                $params[] = $searchDestination;
                $params[] = $searchDestination;
                $params[] = $searchDestination;
                $types .= 'sss';
            }

            if($minPrice !== ''){
                $sql .= " AND p.Price >= ?";
                $params[] = (int)$minPrice;
                $types .= 'i';
            }

            if($maxPrice !== ''){
                $sql .= " AND p.Price <= ?";
                $params[] = (int)$maxPrice;
                $types .= 'i';
            }

            if($minDuration !== ''){
                $sql .= " AND DATEDIFF(p.End_Date, p.Start_Date) >= ?";
                $params[] = (int)$minDuration;
                $types .= 'i';
            }

            if($maxDuration !== ''){
                $sql .= " AND DATEDIFF(p.End_Date, p.Start_Date) <= ?";
                $params[] = (int)$maxDuration;
                $types .= 'i';
            }

            if($groupOnly){
                $sql .= " AND p.Offers_Group_Trip = 1";
            }

            $sql .= " GROUP BY p.PackageID, p.Name, p.Description, p.Price, p.Start_Date, p.End_Date, p.Max_Group_Size, ta.Name";

            if($minRating !== ''){
                $sql .= " HAVING AvgRating >= ?";
                $params[] = (float)$minRating;
                $types .= 'd'; 
            }

            switch ($sort) {
                case 'price_desc':
                    $sql .= " ORDER BY p.Price DESC";
                    break;
                case 'rating_desc':
                    $sql .= " ORDER BY AvgRating DESC";
                    break;
                case 'duration_asc':
                    $sql .= " ORDER BY Duration ASC";
                    break;
                case 'duration_desc':
                    $sql .= " ORDER BY Duration DESC";
                    break;
                default:
                    $sql .= " ORDER BY p.Price ASC";
                    break;
            }

            $stmt = $this->conn->prepare($sql);
            if(!empty($params)){
                $stmt->bind_param($types, ...$params);
            }
            $stmt->execute();
            $result = $stmt->get_result();
            $packages = [];
            while ($row = $result->fetch_assoc()) {
                $packages[] = $row;
            }

            $stmt->close();
            $this->sendResponse($packages, 200);


        }

        private function getDestinations(){

            $sql = $this->conn->prepare("SELECT DISTINCT DestinationID, City_Name, Country_Name FROM destination ORDER BY Country_Name ASC, City_Name ASC");
            $sql->execute();
            $result = $sql->get_result();
            $destinations = [];

            while($row = $result->fetch_assoc()){
                $destinations[] = $row;
            }

            $this->sendResponse($destinations, 200);
        
        }
           
        
        //6
        private function getAccomodations(){

            $sql = $this->conn->prepare("SELECT DISTINCT AccomodationID, Name, Type FROM Accomodation ORDER BY Type ASC, Name ASC");
            $sql->execute();
            $result = $sql->get_result();
            $accomadations = [];

            while($row = $result->fetch_assoc()){
                $accomadations[] = $row;
            }

            $this->sendResponse($accomadations, 200);
        
        }


        //7
        private function getAttractions(){

            $sql = $this->conn->prepare("SELECT DISTINCT AttractionID, Name, Popularity_Rating, Opening_Time, Closing_Time FROM attractions ORDER BY Name ASC, Popularity_Rating ASC");
            $sql->execute();
            $result = $sql->get_result();
            $attractions = [];

            while($row = $result->fetch_assoc()){
                $attractions[] = $row;
            }

            $this->sendResponse($attractions, 200);
        }

        //8
        private function getRestaurants(){

            $sql = $this->conn->prepare("SELECT DISTINCT RestaurantID, Name, Rating, Type FROM restaurant ORDER BY Name ASC, Rating ASC");
            $sql->execute();
            $result = $sql->get_result();
            $restaurants = [];

            while($row = $result->fetch_assoc()){
                $restaurants[] = $row;
            }

            $this->sendResponse($restaurants, 200);
            
        }

        //extraFunctions
        private function getRecentBookings() {
            if(session_status() === PHP_SESSION_NONE)session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $stmt = $this->conn->prepare("SELECT b.BookingID, p.PackageID, p.Name AS PackageName, CONCAT(t.First_Name,' ', t.Last_Name) AS TravellerName, b.Date AS TravelDate, b.Price_paid as TotalPrice, b.status FROM booking as b JOIN package AS p ON b.PackageID = p.PackageID JOIN traveller_bookings AS tb ON b.BookingID = tb.BookingID JOIN traveler AS t ON tb.TravellerID = t.UserID WHERE t.UserID = ? ORDER BY b.Date DESC LIMIT 5");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $bookings = [];
            while($row = $result->fetch_assoc()){
                $bookings[] = $row;
            }

            $stmt->close();
            $this->sendResponse($bookings, 200);
        }

        private function getRecommendedPackages(){

            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;
            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $limit = isset($this->data['limit']) ? (int)$this->data['limit'] :3;

            $stmt = $this->conn->prepare("SELECT TravelerID FROM traveler WHERE UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $traveler = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if(!$traveler){
                $this->sendError("Traveler profile not found", 404);
                return;
            }

            $travelerID = $traveler['TravelerID'];

            $stmt = $this->conn->prepare("SELECT COUNT(*) AS cnt FROM booking WHERE TravelerID = ?");
            $stmt->bind_param("i", $travelerID);
            $stmt->execute();
            $result = $stmt->get_result();
            $hasBookings = $result->fetch_assoc()['cnt'] > 0;
            $stmt->close();

            if ($hasBookings) {
                $sql= $this->conn->prepare("SELECT p.PackageID, p.Name, p.Description, p.Price, p.Max_Group_Size, p.Offers_Group_Trip AS Is_Group_Trip, DATEDIFF(p.End_Date, p.Start_Date) AS Duration, ta.Name AS AgencyName, COALESC(AVG(r.Rating), 0) AS Duration, COUNT(r.ReviewID) AS ReviewCount
                                            FROM package AS p
                                            LEFT JOIN travel_agency AS ta ON p.Travel_AgencyID = ta.UserID
                                            LEFT JOIN review AS r ON p.PackageID = r.PackageID
                                            WHERE p.Price BETWEEN (SELECT AVG(Price_Paid) * 0.8 FROM booking WHERE TravelerID = ?) AND (SELECT AVG(Price_Paid) * 1.2 FROM booking WHERE TravelerID = ?)
                                            AND p.PackageID NOT IN (SELECT p.PackageID FROM booking WHERE TravelerID = ?)
                                            GROUP BY p.PackageID, p.Name, p.Description, p.Price, p.Start_Date, p.End_Date, p.Max_Group_Size, ta.Name
                                            ORDER BY AvgRating DESC
                                            LIMIT = ?");

                $sql->bind_param("iiii", $travelerID, $travelerID, $travelerID, $limit);
            } else {
                $sql = $this->conn->prepare("SELECT p.PackageID, p.Name, p.Description, p.Price, p.Max_Group_Size, p.Offers_Group_Trip AS Is_Group_Trip, DATEDIFF(p.End_Date, p.Start_Date) AS Duration, ta.Name AS AgencyName, COALESC(AVG(r.Rating), 0) AS Duration, COUNT(r.ReviewID) AS ReviewCount
                                            FROM package AS p
                                            LEFT JOIN travel_agency AS ta ON p.Travel_AgencyID = ta.UserID
                                            LEFT JOIN review AS r ON p.PackageID = r.PackageID
                                            GROUP BY p.PackageID, p.Name, p.Description, p.Price, p.Start_Date, p.End_Date, p.Max_Group_Size, ta.Name
                                            ORDER BY AvgRating DESC
                                            LIMIT = ?");
                $sql->bind_param("i", $limit);
            
            }

            $sql->execute();
            $result = $sql->get_result();
            $packages = [];
            while($row = $result->fetch_assoc()){
                $packages[] = $row;
            }

            $sql->close();
            
            if(empty($packages)){
                $this->sendError("No recommendations available at this time", 404);
                return;
            }
            
            $this->sendResponse($packages, 200);
        }

        private function getTravellerProfile(){

            if(session_status() === PHP_SESSION_NONE)session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }


            $stmt = $this->conn->prepare("SELECT u.Email, t.First_Name AS Name, t.Last_Name AS Surname, t.Date_of_Birth, t.Citizenship , t.Passport_Number FROM user AS u JOIN traveler AS t ON u.UserID = t.UserID WHERE u.UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $profile = $result->fetch_assoc();
            $stmt->close();

            if(!$profile){
                $this->sendError("Traveller not found", 404);
                return;
            }

            $this->sendResponse($profile, 200);
        }

        private function updateTravellerProfile(){
            if(!isset($this->data['userID'])){
                $this->sendError("Missing userID", 400);
                return;
            }  
            
            $userID = $this->data['userID'];
            $name = $this->data['name'];
            $surname = $this->data['surname'];

            if(!$name || !$surname){
                $this->sendError("Mising name or surname", 400);
                return;
            }

            $stmt = $this->conn->prepare("UPDATE traveler SET First_Name = ?, Last_Name = ? WHERE UserID = ?");
            $stmt->bind_param("ssi", $name, $surname, $userID);

            if ($stmt->execute()) {
                $this->sendResponse("Profile updated succesfully", 200);
            } else {
                $this->sendError("Update failed: ".$stmt->error, 500);
            }
            $stmt->close();
        }
        
        
        private function getAgencyProfile(){
            if(session_status() === PHP_SESSION_NONE)session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }
            $stmt = $this->conn->prepare("SELECT u.Email, ta.Name, ta.Reg_Number, ta.Verification_Status, ta.Commision_rate FROM user AS u JOIN travel_agency AS ta ON u.UserID = ta.UserID WHERE u.UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $profile = $result->fetch_assoc();
            $stmt->close();

            if(!$profile){
                $this->sendError("Agency not found", 404);
                return;
            }

            $this->sendResponse($profile, 200);
        }


        private function updateAgencyProfile(){
            if(!isset($this->data['userID'])){
                $this->sendError("Missing userID", 400);
                return;
            }  
            
            $userID              = $this->data['userID'];
            $name                = trim($this->data['name'] ?? '');
            $verification_status = trim($this->data['verification_status'] ?? '');
            $commission_rate     = trim($this->data['commission_rate'] ?? '');


            if ($name === '' || $verification_status === '' || $commission_rate === '') {
                $this->sendError("Missing name or verification status or commission rate", 400);
                return;
            }
            //I don't know of ngele will do a dropdown for this, but this is for safety checking
            if($verification_status !== 'Verified' && $verification_status !== 'Rejected'){
                $this->sendError("Invalid verification status", 400);
                return;
            }
            
            $stmt = $this->conn->prepare("UPDATE travel_agency SET Name = ?, Verification_Status = ?, Commision_rate = ? WHERE UserID = ?");
            $stmt->bind_param('ssii', $name, $verification_status, $commission_rate, $userID);
            if ($stmt->execute()) {
                $this->sendResponse("Profile updated succesfully", 200);
            } else {
                $this->sendError("Update failed: ".$stmt->error, 500);
            }
            $stmt->close();
        }

        private function getAgencyPackages(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;
            
            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $limit = isset($this->data['limit']) ? (int)$this->data['limit'] : 100;
            
            $stmt = $this->conn->prepare("
                SELECT PackageID, Name, Price, Start_Date, End_Date, 
                    Max_Group_Size, Offers_Group_Trip,
                    DATEDIFF(End_Date, Start_Date) AS Duration
                FROM package 
                WHERE Travel_AgencyID = ? 
                ORDER BY PackageID DESC 
                LIMIT ?
            ");
            $stmt->bind_param("ii", $userID, $limit);
            $stmt->execute();
            $result = $stmt->get_result();
            $packages = [];
            
            while ($row = $result->fetch_assoc()) {
                $packages[] = $row;
            }

            $stmt->close();
            $this->sendResponse($packages, 200);
        }

        private function getAgencyRecentBookings(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $limit = isset($this->data['limit']) ? (int)$this->data['limit'] : 5;

            $stmt = $this->conn->prepare("
                SELECT b.BookingID, p.Name AS PackageName, 
                    CONCAT(t.First_Name, ' ', t.Last_Name) AS TravellerName, 
                    b.Date AS TravelDate, 
                    b.Price_paid as TotalPrice, 
                    b.status, 
                    p.PackageID 
                FROM booking AS b 
                JOIN package AS p ON b.PackageID = p.PackageID 
                JOIN traveller_bookings AS tb ON b.BookingID = tb.BookingID 
                JOIN traveler AS t ON tb.TravellerID = t.UserID 
                WHERE p.Travel_AgencyID = ? 
                ORDER BY b.Date DESC 
                LIMIT ?
            ");
            $stmt->bind_param("ii", $userID, $limit);
            $stmt->execute();
            $result = $stmt->get_result();
            $bookings = [];
            while($row = $result->fetch_assoc()){
                $bookings[] = $row;
            }

            $stmt->close();
            $this->sendResponse($bookings, 200);
        }
        
        private function getAgencyStats(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $stmt = $this->conn->prepare("
                SELECT 
                    COUNT(DISTINCT p.PackageID) AS total_packages,
                    COUNT(DISTINCT b.BookingID) AS total_bookings,
                    COALESCE(AVG(r.Rating), 0) AS avg_rating,
                    COUNT(DISTINCT gt.GroupID) AS total_group_trips
                FROM travel_agency AS ta 
                LEFT JOIN package AS p ON ta.UserID = p.Travel_AgencyID 
                LEFT JOIN booking AS b ON p.PackageID = b.PackageID 
                LEFT JOIN review AS r ON p.PackageID = r.PackageID 
                LEFT JOIN group_trip AS gt ON ta.UserID = gt.Travel_AgencyID
                WHERE ta.UserID = ?
            ");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $stats = $result->fetch_assoc();
            $stmt->close();

            // Ensure all values are set
            $response = [
                'total_packages' => (int)($stats['total_packages'] ?? 0),
                'total_bookings' => (int)($stats['total_bookings'] ?? 0),
                'avg_rating' => round(($stats['avg_rating'] ?? 0), 1),
                'total_group_trips' => (int)($stats['total_group_trips'] ?? 0)
            ];

            $this->sendResponse($response, 200);
        }

        //end

        private function bookPackage(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'];

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }


            $price_paid = trim($this->data['price_paid'] ?? '');
            $date = trim($this->data['date'] ?? '');
            $package_id = trim($this->data['package_id'] ?? '');

            if( !$price_paid || !$date || !$package_id){
                $this->sendError("Missing parameters", 400);             
                return;
            }

            $stmt = $this->conn->prepare("SELECT PackageID, Price FROM package WHERE PackageID = ?");
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $package = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if(!$package){
                $this->sendError("Package not found", 404);
                return;
            }

            $stmt = $this->conn->prepare("SELECT UserID FROM traveler WHERE UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $traveller = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if(!$traveller){
                $this->sendError("Only travellers can book packages", 403);
                return;
            }



            $stmt = $this->conn->prepare("INSERT INTO booking (Price_Paid, Date, PackageID) VALUES (?, ?, ?)");
            $stmt->bind_param("isi", $price_paid, $date, $package_id);
                if(!$stmt->execute()){
                    $this->sendError("Failed to book package: " . $stmt->error, 500);
                }
            $bookingID = $this->conn->insert_id;
            $stmt->close();

            $stmt = $this->conn->prepare("INSERT INTO traveller_bookings (TravellerID, BookingID) VALUES (?,?)");
            $stmt->bind_param("ii", $userID, $bookingID);
            if(!$stmt->execute()){
                $this->conn->prepare("DELETE FROM booking WHERE BookingID = ?")->bind_param("i", $bookingID);
                $this->sendError("Failed to link booking" . $stmt->error, 500);
                return;
            }

            $stmt->close();
            $this->sendResponse(["BookingID" => $bookingID], 200);
        }

        private function createPackage() {

            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ??null;

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }

            $name = $this->data['name'] ?? '';
            $description = $this->data['description'] ?? '';
            $price = trim($this->data['price'] ?? '');
            $start_date = trim($this->data['start_date'] ?? '');
            $max_group_size = trim($this->data['max_group_size'] ?? '');
            $destinations = $this->data['destinations'] ?? [];
            $flights = $this->data['flights']?? [];
            $accomodations = $this->data['accommodations']?? [];
            $attractions = $this->data['attractions']?? [];
            $restaurants = $this->data['restaurants']?? [];


            if(!$name || !$price || !$start_date  || !$max_group_size){
                $this->sendError("Missing parameters", 400);
                return;
            }

            if(empty($destinations)){
                $this->sendError("At least one destination is required", 400);
                return;
            }

            $stmt = $this->conn->prepare("SELECT UserID FROM travel_agency WHERE UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $agency = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if(!$agency){
                $this->sendError("Invalid Travel Agency ID", 400);
                return;
            }

            /*//if package already exists, return error:
            $stmt = $this->conn->prepare("SELECT PackageID FROM package WHERE PackageID = ?");
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $package = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if($package){
                $this->sendError("Package already exists", 400);
                return;
            }
            //if all other parameters are the same as an existing package, return error:
            $stmt = $this->conn->prepare("SELECT Name, Price, Start_Date, End_Date FROM package WHERE Name = ? AND Price = ? AND Start_Date = ? AND End_Date = ?");
            $stmt->bind_param("siss", $name, $price, $start_date, $end_date);
            $stmt->execute();
            $existingPackage = $stmt->get_result()->fetch_assoc();
            $stmt->close();
            if($existingPackage){
                $this->sendError("A package with the same name, price, start date and end date already exists", 400);
                return;
            }*/
            //if successfully created package, return success message:

            $end_date = trim($this->data['end_date'] ?? $start_date);
            $offers_group = ($max_group_size && $max_group_size > 1)?1: 0;

            $stmt = $this->conn->prepare("INSERT INTO package ( Name, Description, Price, Start_Date, End_Date, Max_Group_Size, Travel_AgencyID, Offers_Group_Trip) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssissiii", $name, $description, $price, $start_date, $end_date, $max_group_size, $userID, $offers_group);
            if(!$stmt->execute()){
                $this->sendError("Failed to create package: " . $stmt->error, 500);
                return;
            }

            $packageID = $this->conn->insert_id;
            $stmt->close();

            foreach($destinations as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_destinations(PackageID, DestinationID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }

            foreach($flights as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_flights(PackageID, flightID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }
            
            foreach($accomodations as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_accomodations(PackageID, AccomodationID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }            

            foreach($attractions as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_attractions(PackageID, AttractionID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }            

            $this->sendResponse(["PackageID" => $packageID], 200);
        }

        private function updatePackage() {

            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;  

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }

            $packageID = trim($this->data['package_id'] ?? '');
            $name = $this->data['name'] ?? '';
            $description = $this->data['description'] ?? '';
            $price = trim($this->data['price'] ?? '');
            $start_date = trim($this->data['start_date'] ?? '');
            $end_date = trim($this->data['end_date'] ?? '');
            $max_group_size = trim($this->data['max_group_size'] ?? '');

            $travel_agency_id = $userID;  

            $destinations = $this->data['destinations'] ?? [];
            $flights = $this->data['flights'] ?? [];
            $accomodations = $this->data['accommodations'] ?? [];  
            $attractions = $this->data['attractions'] ?? [];
            $restaurants = $this->data['restaurants'] ?? [];

            if(!$packageID){
                $this->sendError("Missing Package ID", 400);
                return;
            }
        
            if(!$name || !$price || !$start_date || !$max_group_size){
                $this->sendError("Missing parameters", 400);
                return;
            }
            
            // Verify package exists
            $stmt = $this->conn->prepare("SELECT PackageID FROM package WHERE PackageID = ?");
            $stmt->bind_param("i", $packageID);
            $stmt->execute();
            $package = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if(!$package){
                $this->sendError("Package not found", 400);
                return;
            }

            // Verify agency exists
            $stmt = $this->conn->prepare("SELECT UserID FROM travel_agency WHERE UserID = ?");
            $stmt->bind_param("i", $travel_agency_id);
            $stmt->execute();
            $agency = $stmt->get_result()->fetch_assoc();
            $stmt->close();
            
            if(!$agency){
                $this->sendError("Travel Agency Does Not Exist", 400);
                return;
            }

            // Verify package belongs to this agency
            $stmt = $this->conn->prepare("SELECT PackageID FROM package WHERE PackageID = ? AND Travel_AgencyID = ?");
            $stmt->bind_param("ii", $packageID, $travel_agency_id);
            $stmt->execute();
            if (!$stmt->get_result()->fetch_assoc()) {
                $this->sendError("Package not found or access denied", 403);
                return;
            }
            $stmt->close();

            $offers_group = ($max_group_size && $max_group_size > 1) ? 1 : 0;

            $stmt = $this->conn->prepare("UPDATE package SET Name = ?, Description = ?, Price = ?, Start_Date = ?, End_Date = ?, Max_Group_Size = ?, Offers_Group_Trip = ? WHERE PackageID = ?");
            $stmt->bind_param("ssissiii", $name, $description, $price, $start_date, $end_date, $max_group_size, $offers_group, $packageID);
            if(!$stmt->execute()){
                $this->sendError("Failed to update package: " . $stmt->error, 500);
                return;
            }
            $stmt->close();

            // Delete existing relationships
            $this->conn->query("DELETE FROM package_destinations WHERE PackageID = $packageID");
            $this->conn->query("DELETE FROM package_flights WHERE PackageID = $packageID");
            $this->conn->query("DELETE FROM package_accomodations WHERE PackageID = $packageID");  // Keep one 'm'
            $this->conn->query("DELETE FROM package_attractions WHERE PackageID = $packageID");

            // Insert new relationships - use $accomodations variable
            foreach($destinations as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_destinations(PackageID, DestinationID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }

            foreach($flights as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_flights(PackageID, flightID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }
            
            foreach($accomodations as $id){  // Use $accomodations (one 'm')
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_accomodations(PackageID, AccomodationID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }            

            foreach($attractions as $id){
                $stmt = $this->conn->prepare("INSERT IGNORE INTO package_attractions(PackageID, AttractionID) VALUES (?,?)");
                $stmt->bind_param("ii", $packageID, $id);
                $stmt->execute();
                $stmt->close();
            }     

            $this->sendResponse("Package Updated successfully", 200);
        }

        private function deletePackage(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'];

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }

            $packageID = $this->data['package_id'];
            if(!$packageID){
                $this->sendError("Missing package ID", 400);
                return;
            }


            $stmt = $this->conn->prepare("SELECT PackageID FROM package WHERE PackageID = ? AND Travel_AgencyID = ?");
            $stmt->bind_param("ii", $packageID, $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $package = $result->fetch_assoc();
            $stmt->close();

            if(!$package){
                $this->sendError("Package not found or you do not have permission to delete this package", 404);
                return;
            }

            $stmt = $this->conn->prepare("DELETE FROM package WHERE PackageID = ?");
            $stmt->bind_param("i", $packageID);
            if(!$stmt->execute()){
                $this->sendError("Failed to delete package" . $stmt->error, 500);
                return;
            } 

            $stmt->close();
            $this->sendResponse("Package Deleted successfully", 200 );
        }
        
        private function viewPackage() {
            $package_id = trim($this->data['package_id'] ?? '');

            if (!$package_id) {
                $this->sendError("Package ID is required", 400);
                return;
            }

            // main package
            $stmt = $this->conn->prepare(
                "SELECT p.PackageID, p.Name, p.Description, p.Price,
                        p.Start_Date, p.End_Date, p.Max_Group_Size,
                        DATEDIFF(p.End_Date, p.Start_Date) AS Duration,
                        t.Name AS AgencyName,
                        COALESCE(AVG(r.Rating), 0) AS AvgRating,
                        COUNT(DISTINCT r.ReviewID) AS ReviewCount
                FROM package AS p
                LEFT JOIN travel_agency AS t ON p.Travel_AgencyID = t.UserID
                LEFT JOIN review AS r ON p.PackageID = r.PackageID
                WHERE p.PackageID = ?
                GROUP BY p.PackageID, p.Name, p.Description, p.Price,
                        p.Start_Date, p.End_Date, p.Max_Group_Size, t.Name"
            );
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $package = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if (!$package) {
                $this->sendError("Package not found", 404);
                return;
            }

            // destinations
            $stmt = $this->conn->prepare(
                "SELECT d.DestinationID, d.City_Name, d.Country_Name, d.Continent
                FROM destination AS d
                JOIN package_destinations AS pd ON d.DestinationID = pd.DestinationID
                WHERE pd.PackageID = ?"
            );
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $destinations = [];
            while ($row = $result->fetch_assoc()) $destinations[] = $row;
            $stmt->close();

            // flights
            $stmt = $this->conn->prepare(
                "SELECT f.FlightID, f.Flight_Name, f.Departure_City,
                        f.Arrival_City, f.Departure_Date, f.Departure_Time, f.Duration
                FROM flight AS f
                JOIN package_flights AS pf ON f.FlightID = pf.FlightID
                WHERE pf.PackageID = ?"
            );
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $flights = [];
            while ($row = $result->fetch_assoc()) $flights[] = $row;
            $stmt->close();

            // accommodations
            $stmt = $this->conn->prepare(
                "SELECT a.AccomodationID, a.Name, a.Type,
                        a.Check_in_time, a.Check_out_time
                FROM accomodation AS a
                JOIN package_accomodations AS pa ON a.AccomodationID = pa.AccomodationID
                WHERE pa.PackageID = ?"
            );
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $accommodations = [];
            while ($row = $result->fetch_assoc()) $accommodations[] = $row;
            $stmt->close();

            // attractions
            $stmt = $this->conn->prepare(
                "SELECT a.AttractionID, a.Name, a.Accessibility_Rating,
                        a.Popularity_Rating, a.Opening_Time, a.Closing_Time
                FROM attractions AS a
                JOIN package_attractions AS pat ON a.AttractionID = pat.AttractionID
                WHERE pat.PackageID = ?"
            );
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $attractions = [];
            while ($row = $result->fetch_assoc()) $attractions[] = $row;
            $stmt->close();

            // restaurants via destination
            $stmt = $this->conn->prepare(
                "SELECT DISTINCT r.RestaurantID, r.Name, r.Type,
                        r.Rating, r.is_vegan, r.is_halaal
                FROM restaurant AS r
                JOIN destination AS d ON r.DestinationID = d.DestinationID
                JOIN package_destinations AS pd ON d.DestinationID = pd.DestinationID
                WHERE pd.PackageID = ?"
            );
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $restaurants = [];
            while ($row = $result->fetch_assoc()) $restaurants[] = $row;
            $stmt->close();

            $this->sendResponse([
                'package'        => $package,
                'destinations'   => $destinations,
                'flights'        => $flights,
                'accommodations' => $accommodations,
                'attractions'    => $attractions,
                'restaurants'    => $restaurants
            ], 200);
        }
        
        private function getFlights(){
        

            $sql = $this->conn->prepare("SELECT DISTINCT f.FlightID, f.Flight_Name, f.Departure_City, f.Arrival_City, f.Departure_Time, f.Duration FROM flight as f ORDER BY f.Departure_City ASC, f.Arrival_City ASC, f.Departure_Time ASC");

            $sql->execute();
            $result = $sql->get_result();
            $flights = [];

            while($row = $result->fetch_assoc()){
                $flights[] = $row;
            }
        

        $this->sendResponse($flights, 200);
        }


        private function getReviews(){
            if(!isset($this->data['package_id'])){
                $this->sendError("Missing package ID", 400);
                return;
            }

            $packageID = $this->data['package_id'];

            $sql = $this->conn->prepare("SELECT * FROM  review WHERE PackageID = ?");
            $sql->bind_param("i", $packageID);
            $sql->execute();
            $result = $sql->get_result();
            $reviews = [];
            while($row = $result->fetch_assoc()){
                $reviews[] = $row;
            }
            $this->sendResponse($reviews, 200);
        }

        private function getReviewCount() {
            if (session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $stmt = $this->conn->prepare("
                SELECT COUNT(*) AS count 
                FROM review 
                WHERE TravellerID = ?
            ");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $count = $result->fetch_assoc()['count'] ?? 0;
            $stmt->close();

            $this->sendResponse(['count' => $count], 200);
        }

        private function makeReview(){
            if (session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

           $rating = trim($this->data['rating'] ?? '');
           $comment = $this->data['comment'] ?? '';
           $date_posted = trim($this->data['date_posted'] ?? '');
           $package_id = trim($this->data['package_id'] ?? '');

           
           if(!$rating || !$date_posted || !$package_id){
               $this->sendError("Missing parameters", 400);             
               return;
           }

           // Check if already reviewed
            $stmt = $this->conn->prepare("SELECT ReviewID FROM review WHERE PackageID = ? AND TravellerID = ?");
            $stmt->bind_param("ii", $package_id, $userID);
            $stmt->execute();
            $existing = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if($existing){
                $this->sendError("You have already reviewed this package", 400);
                return;
            }

           $stmt = $this->conn->prepare("INSERT INTO review (Rating, Comment, Date_Posted, PackageID, TravellerID) VALUES (?, ?, ?, ?, ?)");
           $stmt->bind_param("dssii", $rating, $comment, $date_posted, $package_id, $userID);
                if($stmt->execute()){
                    $this->sendResponse("Review submitted successfully", 200);
                } else {
                    $this->sendError("Failed to submit review: " . $stmt->error, 500);
                }
            $stmt->close();
           
        }

        private function createGroupTrip(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }

            $package_id = trim($this->data['package_id'] ?? '');
            $traveller_id = trim($this->data['traveller_id'] ?? '');

            if(!$package_id || !$traveller_id){
                $this->sendError("Missing package_id or traveller_id", 400);
                return;
            }

            $stmt = $this->conn->prepare("INSERT INTO group_trip (PackageID, TravellerID, Travel_AgencyID) VALUES (?, ?, ?)");
            $stmt->bind_param("iii", $package_id, $traveller_id, $userID);
            
            if($stmt->execute()){
                $this->sendResponse("Group trip created successfully", 200);
            } else {
                $this->sendError("Failed to create group trip: " . $stmt->error, 500);
            }
            $stmt->close();
        }

        private function updateGroupTrip(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }

            $groupTripID = trim($this->data['group_trip_id'] ?? '');
            $package_id = trim($this->data['package_id'] ?? '');
            $traveller_id = trim($this->data['traveller_id'] ?? '');

            if(!$groupTripID){
                $this->sendError("Missing group_trip_id", 400);
                return;
            }

            if(!$package_id && !$traveller_id){
                $this->sendError("No fields to update", 400);
                return;
            }

            // Verify this group trip belongs to this agency
            $stmt = $this->conn->prepare("SELECT GroupID FROM group_trip WHERE GroupID = ? AND Travel_AgencyID = ?");
            $stmt->bind_param("ii", $groupTripID, $userID);
            $stmt->execute();
            $exists = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if(!$exists){
                $this->sendError("Group trip not found or you don't have permission", 404);
                return;
            }

            // Build update query
            $updates = [];
            $params = [];
            $types = '';

            if(!empty($package_id)){
                $updates[] = "PackageID = ?";
                $params[] = $package_id;
                $types .= 'i';
            }

            if(!empty($traveller_id)){
                $updates[] = "TravellerID = ?";
                $params[] = $traveller_id;
                $types .= 'i';
            }

            $params[] = $groupTripID;
            $params[] = $userID;
            $types .= 'ii';

            $sql = $this->conn->prepare("UPDATE group_trip SET " . implode(", ", $updates) . " WHERE GroupID = ? AND Travel_AgencyID = ?");
            $sql->bind_param($types, ...$params);
            
            if($sql->execute()){
                $this->sendResponse("Group trip updated successfully", 200);
            } else {
                $this->sendError("Failed to update group trip: " . $sql->error, 500);
            }
            $sql->close();
        }

        private function deleteGroupTrip(){
            if(session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if(!$userID){
                $this->sendError("Not logged in", 401);
                return;
            }

            $groupTripID = trim($this->data['group_trip_id'] ?? '');
            if(!$groupTripID){
                $this->sendError("Missing group_trip_id", 400);
                return;
            }

            // Verify this group trip belongs to this agency
            $stmt = $this->conn->prepare("SELECT GroupID FROM group_trip WHERE GroupID = ? AND Travel_AgencyID = ?");
            $stmt->bind_param("ii", $groupTripID, $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $groupTrip = $result->fetch_assoc();
            $stmt->close();

            if(!$groupTrip){
                $this->sendError("Group trip not found or you don't have permission", 404);
                return;
            }

            // Delete from traveller_grouptrips first (junction table)
            $stmt = $this->conn->prepare("DELETE FROM traveller_grouptrips WHERE GroupID = ?");
            $stmt->bind_param("i", $groupTripID);
            $stmt->execute();
            $stmt->close();

            // Delete from group_trip
            $stmt = $this->conn->prepare("DELETE FROM group_trip WHERE GroupID = ?");
            $stmt->bind_param("i", $groupTripID);
            if(!$stmt->execute()){
                $this->sendError("Failed to delete group trip: " . $stmt->error, 500);
                return;
            }
            $stmt->close();

            $this->sendResponse("Group trip deleted successfully", 200);
        }

        private function getAgencyGroupTrips() {
            if (session_status() === PHP_SESSION_NONE) session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }

            $stmt = $this->conn->prepare("
                SELECT gt.GroupID, gt.PackageID, gt.TravellerID,
                    p.Name AS PackageName,
                    CONCAT(t.First_Name, ' ', t.Last_Name) AS TravellerName
                FROM group_trip AS gt
                LEFT JOIN package AS p ON gt.PackageID = p.PackageID
                LEFT JOIN traveler AS t ON gt.TravellerID = t.UserID
                WHERE gt.Travel_AgencyID = ?
                ORDER BY gt.GroupID DESC
            ");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $trips = [];
            while ($row = $result->fetch_assoc()) {
                $trips[] = $row;
            }
            $stmt->close();

            $this->sendResponse($trips, 200);
        }

        private function getAllTravellers() {
            $stmt = $this->conn->prepare("
                SELECT UserID, First_Name, Last_Name 
                FROM traveler 
                ORDER BY First_Name ASC
            ");
            $stmt->execute();
            $result = $stmt->get_result();
            $travellers = [];
            while ($row = $result->fetch_assoc()) {
                $travellers[] = $row;
            }
            $stmt->close();
            $this->sendResponse($travellers, 200);
        }

    }

    

    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    $dbConnection = getDBConnection();
    $api = new Tripistry($dbConnection, $data);
    $api->processRequest();
?>
