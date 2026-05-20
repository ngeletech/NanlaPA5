<?php //creating a traveller ?>
<!DOCTYPE html>
<html>
    <head>
        <title>Signup!</title>
        <link rel="stylesheet" href="/NanlaPA5/app/css/main.css">
    </head>
    <body>
        <?php include('../header.php'); ?>

        <div class="container" style="max-width:480px; margin-top:2rem;">
            <h1 style="margin-bottom:1.5rem;">Register as a Traveller!</h1>

            <form id="signupForm" method="post">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name">
                    <span class="error-message" id="nameError"></span>
                </div>
                <div class="form-group">
                    <label for="surname">Surname</label>
                    <input type="text" id="surname" name="surname">
                    <span class="error-message" id="surnameError"></span>
                </div>
                <div class="form-group">
                    <label for="DOB">Date of birth</label>
                    <input type="date" id="DOB" name="DOB">
                    <span class="error-message" id="DOBError"></span>
                </div>
                <div class="form-group">
                    <label for="passnum">Passport Number</label>
                    <input type="text" id="passnum" name="passnum">
                    <span class="error-message" id="passError"></span>
                </div>
                <div class="form-group">
                    <label>Confirm user type</label><br>
                    <input type="radio" name="user_type" value="Traveller" checked> Traveller
                    <input type="radio" name="user_type" value="Travel Agency"> Travel Agency
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
                    <label for="confirm">Confirm Password</label>
                    <input type="password" id="confirm" name="confirm">
                    <span class="error-message" id="confirmError"></span>
                </div>

                <button type="submit" class="btn-primary full-width">Sign up!</button>
            </form>

            <div id="apiResponse"></div>
        </div>

        <script src="/NanlaPA5/app/js/main.js"></script>
        <script src="/NanlaPA5/app/js/traveller/register.js"></script>
    </body>
</html>