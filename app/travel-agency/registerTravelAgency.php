<?php //creating a travel agency ?>
<!DOCTYPE html>
<html>
    <head>
        <title>Signup!</title>
        <link rel="stylesheet" href="/NanlaPA5/app/css/main.css">
    </head>
    <body>
        <?php include('../header.php'); ?>
        <div class="container" style="max-width:480px; margin-top:2rem;">
            <h1 style="margin-bottom:1.5rem;">Register as a Travel Agency</h1>
            <form id="signupForm" method="post">
                <div class="form-group">
                    <label for="name">Agency name</label>
                    <input type="text" id="name" name="name">
                    <span class="error-message" id="nameError"></span>
                </div>
                <div class="form-group">
                    <label for="reg_num">Registration number</label>
                    <input type="text" id="reg_num" name="reg_num">
                    <span class="error-message" id="reg_Error"></span>
                </div>
                <div class="form-group">
                    <label>Confirm user type</label><br>
                    <input type="radio" name="user_type" value="Traveller"> Traveller
                    <input type="radio" name="user_type" value="Travel Agency" checked> Travel Agency
                    <span class="error-message" id="typeError"></span>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email">
                    <span class="error-message" id="emailError"></span>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password">
                    <span class="error-message" id="passwordError"></span>
                </div>
                <div class="form-group">
                    <label for="confirm">Confirm password</label>
                    <input type="password" id="confirm" name="confirm">
                    <span class="error-message" id="confirmError"></span>
                </div>
                <button type="submit" class="btn-primary full-width">Sign up!</button>
            </form>
            <div id="apiResponse"></div>
        </div>
        <script src="/NanlaPA5/app/js/main.js"></script>
        <script src="/NanlaPA5/app/js/register.js"></script>
    </body>
</html>