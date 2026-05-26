<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'My Bookings – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">My bookings</h1>
        </div>
        <div class="tabs">
            <button class="tab active" data-tab="upcoming">Upcoming</button>
            <button class="tab" data-tab="past">Past trips</button>
            <button class="tab" data-tab="all">All bookings</button>
        </div>
        <div id="bookings-container">
            <div class="loading">Loading bookings...</div>
        </div>
        <div id="no-bookings" class="empty-state" style="display:none;">
            <p>No bookings found.</p>
            <a href="/NanlaPA5/app/traveller/browse.php" class="btn-primary">Browse packages</a>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/mybookings.js';
require_once '../footer.php';
?>