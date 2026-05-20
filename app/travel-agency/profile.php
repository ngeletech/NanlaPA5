<?php
require_once '../auth_check.php';
requireAgency();
$pageTitle = 'Profile – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container">
        <div class="dashboard-hero">
            <div>
                <p class="eyebrow">Agency dashboard</p>
                <h1 class="page-title" id="agency-greeting">Welcome back</h1>
                <p class="subtitle">Manage your packages and track your bookings</p>
            </div>
            <a href="/NanlaPA5/app/travel-agency/package-edit.php" class="btn-primary">+ Create new package</a>
        </div>
        <div class="two-column">
            <div class="col col-profile">
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">Agency profile</h2>
                    </div>
                    <div id="profile-error" class="error-banner" style="display:none;"></div>
                    <div id="profile-success" class="success-banner" style="display:none;"></div>
                    <div id="profile-container"><div class="loading">Loading profile...</div></div>
                </div>
            </div>
            <div class="col col-dashboard">
                <div class="stats-grid">
                    <div class="stat-card"><span class="stat-num" id="stat-packages">—</span><span class="stat-label">Active packages</span></div>
                    <div class="stat-card"><span class="stat-num" id="stat-bookings">—</span><span class="stat-label">Total bookings</span></div>
                    <div class="stat-card"><span class="stat-num" id="stat-rating">—</span><span class="stat-label">Average rating</span></div>
                    <div class="stat-card"><span class="stat-num" id="stat-group-trips">—</span><span class="stat-label">Group trips</span></div>
                </div>
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">Recent bookings</h2>
                    </div>
                    <div class="table-wrapper" id="recent-bookings-container">
                        <div class="loading">Loading bookings...</div>
                    </div>
                </div>
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">My packages</h2>
                        <a href="/NanlaPA5/app/travel-agency/packages.php" class="link">View all →</a>
                    </div>
                    <div class="table-wrapper" id="packages-preview-container">
                        <div class="loading">Loading packages...</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/agency/profile.js';
require_once '../footer.php';
?>