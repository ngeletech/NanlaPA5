<?php
    define('DB_HOST', '');
    define('DB_USER', '');
    define('DB_PASS', '');
    define('DB_NAME', '');
    define('DB_PORT', '');


    function getDBConnection(){
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);
        if($conn->connect_error){
            http_response_code(500);
            echo json_encode([
                "status" => "error",
                "data" => "Database connection failed"
            ]);
            exit();
        }

        $conn->set_charset("utf8mb4");
        return $conn;
    }
?>