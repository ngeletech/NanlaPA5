
<?php
//Validates a session ensuring that a user is logged in either wise redirected
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function requireLogin() {
    if (!isset($_SESSION['user_id'])) {
        header('Location: /NanlaPA5/app/login.php');
        exit();
    }
}

function requireTraveller() {
    requireLogin();
    if ($_SESSION['user_type'] !== 'traveller') {
        header('Location: /NanlaPA5/app/login.php');
        exit();
    }
}

function requireAgency() {
    requireLogin();
    if ($_SESSION['user_type'] !== 'agency') {
        header('Location: /NanlaPA5/app/login.php');
        exit();
    }
}

function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

function getUserType() {
    return $_SESSION['user_type'] ?? null;
}

function getUserId() {
    return $_SESSION['user_id'] ?? null;
}
?>