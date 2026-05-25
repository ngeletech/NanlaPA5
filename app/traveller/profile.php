<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Profile – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container">
        <div class="dashboard-hero">
            <div>
                <p class="eyebrow">Welcome back</p>
                <h1 class="page-title" id="greeting">Hello there</h1>
                <p class="subtitle">Ready for your next adventure?</p>
            </div>
            <a href="/NanlaPA5/app/traveller/browse.php" class="btn-primary">Browse packages →</a>
        </div>
        <div class="two-column">
            <div class="col col-profile">
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">Profile details</h2>
                    </div>
                    <div id="profile-error" class="error-banner" style="display:none;"></div>
                    <div id="profile-success" class="success-banner" style="display:none;"></div>
                    <div class="form-card" id="profile-container">
                        <div class="loading">Loading profile...</div>
                    </div>
                </div>
            </div>
            <div class="col col-dashboard">
                <div class="stats-grid">
                    <div class="stat-card"><span class="stat-num" id="stat-bookings">—</span><span class="stat-label">Total bookings</span></div>
                    <div class="stat-card"><span class="stat-num" id="stat-upcoming">—</span><span class="stat-label">Upcoming trips</span></div>
                    <div class="stat-card"><span class="stat-num" id="stat-reviews">—</span><span class="stat-label">Reviews left</span></div>
                </div>
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">Recent bookings</h2>
                        <a href="/NanlaPA5/app/traveller/mybookings.php" class="link">View all</a>
                    </div>
                    <div id="recent-bookings-container"><div class="loading">Loading bookings...</div></div>
                </div>
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">Recommended for you</h2>
                        <a href="/NanlaPA5/app/traveller/browse.php" class="link">See all</a>
                    </div>
                    <div class="pkg-grid" id="featured-packages-container">
                        <div class="loading">Loading packages...</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/profile.js';
require_once '../footer.php';
?>