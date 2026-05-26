<?php
    define('DB_HOST', '127.0.0.1');
    define('DB_USER', 'root');
    define('DB_PASS', '');
    define('DB_NAME', 'nanla_tripistry');
    define('DB_PORT', '3306');


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
