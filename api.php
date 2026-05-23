<?php

use LDAP\Result;

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
                if(!isset( $this->data['name']) || !isset( $this->data['surname']) || !isset( $this->data['DOB']) || !isset( $this->data['passnum'])){
                $this->sendError('Missing parameter',400);
                return;
                }

                $name = $this->data['name'];
                $surname = $this->data['surname'];
                $dob = $this->data['DOB'];
                $passport = $this->data['passnum'];
                $citizenship = 'Unknown';
            

                $stmt = $this->conn->prepare("INSERT INTO traveler (UserID,Passport_number, First_Name, Last_Name, Date_of_Birth, Citizenship) VALUES (?,?,?,?,?,?)");
                $stmt->bind_param("isssss", $userID, $passport, $name, $surname, $dob, $citizenship);

            } else if ($user_type === 'Travel Agency'){
                if(!isset( $this->data['name'])  || !isset( $this->data['reg_num'])){
                $this->sendError('Missing parameter',400);
                return;
                }

                $name = $this->data['name'];
                $reg_num = $this->data['reg_num'];

                $stmt = $this->conn->prepare("INSERT INTO travel_agency (UserID, Reg_Number, Name) VALUES (?,?,?)");
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

            if(!isset($this->data['search'])){
                $sql = "SELECT p.PackageID, p.Name ,p.Description ,p.Price, t.Name FROM package as p LEFT JOIN travel_agency as t on p.Travel_AgencyID = t.UserID WHERE 1=1";
                $result = $this->conn->query($sql);
                $packages = [];
                while($row = $result->fetch_assoc()){
                    $packages[] = $row;
                }
                $this->sendResponse($packages, 200);
                return; 
            } else {
                if(isset($this->data['search']['destination'])){

                } else if ($this->data['search']['accomodation']){

                }
            }

        }
        private function getDestinations(){
            //i think get destinations should work like a search where you can find packages based on a destination?

            $searchDestination = "";
            if(isset($this->data['search'])){
                $searchDestination = '%'.$this->data['search'].'%';
                $sql = $this->conn->prepare("SELECT p.Name, p.Description, p.Price, p.Start_Date FROM destination as d LEFT JOIN package_destinations as pd ON d.DestinationID = pd.DestinationID LEFT JOIN package as p on p.PackageID = pd.PackageID WHERE d.City_Name LIKE ? OR d.Country_Name LIKE ? or d.Continent LIKE ?");
                $sql->bind_param('sss', $searchDestination, $searchDestination, $searchDestination);
                $sql->execute();
                $result = $sql->get_result();
                $destinations = [];

                while($row = $result->fetch_assoc()){
                    $destinations[] = $row;
                }

                $this->sendResponse($destinations, 200);
            }
        }
           
        
        //6
        private function getAccomodations(){

            //for now just geting packages based on accomodation search
            $searchAccommodation = "";
            if(isset($this->data['search'])){
                $searchAccommodation = '%'.$this->data['search'].'%';
                $sql = $this->conn->prepare("SELECT p.Name, p.Description, p.Price, p.Start_Date FROM accomodation as a LEFT JOIN package_accomodations as pa ON a.AccomodationID = pa.AccomodationID LEFT JOIN package as p on p.PackageID = pa.PackageID WHERE a.Type LIKE ?");
                $sql->bind_param('s', $searchAccommodation);
                $sql->execute();
                $result = $sql->get_result();
                $packages = [];

                while($row = $result->fetch_assoc()){
                    $packages[] = $row;
                }

                $this->sendResponse($packages, 200);
            }


        }
        //7
        private function getAttractions(){

            //searching attractions based on destination and package 
            //searchDestination-> packageID -> attractions.
        }
        //8
        private function getRestaurants(){

            //search restuarant based on destination 

            $searchDestination = "";
            if(isset($this->data['search'])){
                $searchDestination = '%'.$this->data['search'].'%';                
                $sql = $this->conn->prepare("SELECT r.Name, r.Type, r.Rating FROM restaurant as r LEFT JOIN destination as d on r.DestinationID = d.DestinationID WHERE d.City_Name LIKE ?");
                $sql->bind_param('s', $searchDestination);
                $sql->execute();
                $result = $sql->get_result();
                $packages = [];

                while($row = $result->fetch_assoc()){
                    $packages[] = $row;
                }

                $this->sendResponse($packages, 200);
            }
            
        }
        //extraFunctions
        private function getRecentBookings() {
            
        }

        private function getRecommendedPackages(){}

        private function getTravellerProfile(){

            if(session_status() === PHP_SESSION_NONE)session_start();
            $userID = $_SESSION['user_id'] ?? null;

            if (!$userID) {
                $this->sendError("Not logged in", 401);
                return;
            }


            $stmt = $this->conn->prepare("SELECT u.Email, t.First_Name AS Name, t.Last_Name AS Surname, t.Date_of_Birth, t.Citizenship FROM user AS u JOIN traveler AS t ON u.UserID = t.UserID WHERE u.UserID = ?");
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


        private function updateAgencyProfile(){}

        private function getAgencyPackages(){
            if(!isset($this->data['userID'])){
                $this->sendError("Missing userID", 400);
                return;
            }
            $userID = $this->data['userID'];
            $limit = isset($this->data['limit']);

            $stmt = $this->conn->prepare("SELECT p.PackageID, p.Name, p.Price, COUNT(b.BookingID) as BookingCount FROM package AS p LEFT JOIN booking AS b ON p.PackageID = b.PackageID WHERE p.Travel_AgencyID = ? GROUP BY p.PackageID, p.Name, p.Price ORDER BY p.PackageID DESC LIMIT ?");
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
            if(!isset($this->data['userID'])){
                $this->sendError("Missing userID", 400);
                return;
            }
            $userID = $this->data['userID'];
            $limit = isset($this->data['limit']);

            $stmt = $this->conn->prepare("SELECT b.BookinID, p.Name AS PackageName, CONCAT(t.First_Name,' ', t.Last_Name) AS TravellerName, b.Date AS TravelDate, b.Price_paid as TotalPrice, b.status, p.PackageID FROM booking as b JOIN package AS p ON b.PackageID = p.PackageID JOIN traveller_bookings AS tb ON b.BookingID = tb.BookingID JOIN traveler AS t ON tb.TravellerID = t.UserID WHER p.Travel_AgencyID = ? ORDER BY b.Date DESC LIMIT ?");
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
            if (!isset($this->data['userID'])) {
                $this->sendError("Missing userID", 400);
                return;
            }

            $userID = $this->data['userID'];
            $stmt = $this->conn->prepare("SELECT COUNT(DISTINCT p.PackageID) AS total_packages, COUNT(DISTINCT b.BookingID) AS total_bookings, AVG(r.rating) AS avg_rating FROM travel_agency AS ta 
                    LEFT JOIN package AS p ON ta.UserID = p.Travel_AgencyID LEFT JOIN bookings AS b ON ta.UserID = b.PackageID LEFT JOIN review AS r ON p.PackageID = r.PackageID WHERE ta.UserID = ?");
            $stmt->bind_param("i", $userID);
            $stmt->execute();
            $result = $stmt->get_result();
            $stats = $result->fetch_assoc();
            $stmt->close();

            $this->sendResponse($stats,200);
        }

        //end

        private function bookPackage(){

        }

        private function createPackage() {
        }

        private function updatePackage() {
        }

        private function viewPackage(){}
        
        private function getFlights(){
        
        if(isset($this->data['search'])){
            $searchDestination = '%'.$this->data['search'].'%';
            $sql = $this->conn->prepare("SELECT f.FlightID, f.Flight_Name, f.Departure_City, f.Arrival_City, f.Departure_Time, f.Arrival_City FROM flight as f LEFT JOIN destination as d on f.Arrival_City = d.City_Name WHERE d.Flight_Name LIKE ?");
            $sql->bind_param('s', $searchDestination);
            $sql->execute();
            $result = $sql->get_result();
            $flights = [];

            while($row = $result->fetch_assoc()){
                $flights[] = $row;
            }
        }
        
        }


        private function getReviews(){
            $sql = "SELECT * FROM  review";
            $result = $this->conn->query($sql);
            $reviews = [];
            while($row = $result->fetch_assoc()){
                $reviews[] = $row;
            }
            $this->sendResponse($reviews, 200);
        }

        private function makeReview(){
           $review_id = trim($this->data['review_id'] ?? '');
           $rating = trim($this->data['rating'] ?? '');
           $comment = $this->data['comment'] ?? '';
           $date_posted = trim($this->data['date_posted'] ?? '');
           $package_id = trim($this->data['package_id'] ?? '');
           $traveler_id = trim($this->data['traveler_id'] ?? '');
           
           if(!$review_id || !$rating || !$date_posted || !$package_id || !$traveler_id){
               $this->sendError("Missing parameters", 400);             
               return;
           }

           $stmt = $this->conn->prepare("SELECT TravelerID FROM traveler WHERE UserID = ?");
           $stmt->bind_param("i", $traveler_id);
           $stmt->execute();
           $user = $stmt->get_result()->fetch_assoc();
           $stmt->close();

           if(!$user){
               $this->sendError("Invalid traveler ID", 400);
               return;
           }

           $stmt = $this->conn->prepare("INSERT INTO review (Rating, Comment, Date_Posted, PackageID, TravelerID) VALUES (?, ?, ?, ?, ?, ?)");
           $stmt->bind_param("iissii", $rating, $comment, $date_posted, $package_id, $traveler_id);
                if($stmt->execute()){
                    $this->sendResponse("Review submitted successfully", 200);
                } else {
                    $this->sendError("Failed to submit review: " . $stmt->error, 500);
                }
            $stmt->close();



           
        }

    }

    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    $dbConnection = getDBConnection();
    $api = new Tripistry($dbConnection, $data);
    $api->processRequest();
?>