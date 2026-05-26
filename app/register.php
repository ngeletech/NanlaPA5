<!DOCTYPE html>
<html>
    <head>
        <title>Signup!</title>
        <link rel="stylesheet" href="/NanlaPA5/app/css/main.css">
    </head>

    <body>
        <?php include('header.php'); ?>

        <div class="container" style="max-width:480px; margin-top:2rem;">

            <h2 style="margin-bottom:1.5rem;">Register For A Tripistry Account!</h2>

            <form id="firstForm" method="post">
                <p style="margin-bottom:1rem;">Please select a user type.</p>

                <div class="form-group">
                    <label>Type</label><br><br>
                    <input type="radio" name="user_type" value="Traveller"> Traveller
                    <input type="radio" name="user_type" value="Travel Agency"> Travel Agency
                    <span class="error-message" id="typeError"></span>
                </div>
                <br>
                <button type="submit" class="btn-primary">I have selected a type!</button>
            </form>

            <div id="apiResponse"></div>
        </div>

        <script src="/NanlaPA5/app/js/main.js"></script>
        <script src="/NanlaPA5/app/js/register.js"></script>
    </body>
</html>