<?php
    session_start();
    session_destroy();
    header('Location: /NanlaPA5/app/login.php');
    exit();
?>