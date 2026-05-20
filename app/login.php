<?php include('header.php'); ?>
<!DOCTYPE html>
<html>
    <head>
        <title>Login – Tripistry</title>
        <link rel="stylesheet" href="/NanlaPA5/app/css/main.css">
    </head>
    <body>

        <div class="container" style="max-width: 480px; margin-top: 3rem;">

            <div class="form-header" style="margin-bottom: 1.5rem;">
                <h2>Login</h2>
                <p>Don't have an account? <a href="/NanlaPA5/app/register.php">Sign up</a></p>
            </div>

            <div id="apiResponse"></div>

            <form id="loginForm" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="input-email" placeholder="you@example.com">
                    <span class="error-message" id="emailError"></span>
                </div>

                <br>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="input-text" placeholder="Your password">
                    <span class="error-message" id="passwordError"></span>
                </div>

                <br>

                <button type="submit" class="btn-primary full-width">Log in!</button>
            </form>

        </div>

        <script src="/NanlaPA5/app/js/main.js"></script>
        <script src="/NanlaPA5/app/js/login.js"></script>
    </body>
</html>