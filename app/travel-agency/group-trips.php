<?php
require_once '../auth_check.php';
requireAgency();
$pageTitle  = 'Group Trips – Tripistry';
$pageScript = '/NanlaPA5/app/js/agency/group-trips.js';
require_once '../header.php';
?>

<main class="main">
    <div class="container">
        <div class="page-header">
            <div>
                <h1 class="page-title">Group trips</h1>
                <p class="subtitle">Manage group travel offerings for your packages</p>
            </div>
        </div>
        <div id="gt-error" class="error-banner" style="display:none;"></div>
        <div id="gt-success" class="success-banner" style="display:none;"></div>
        <div class="stats-grid stats-grid-3">
            <div class="stat-card"><span class="stat-num" id="stat-total-trips">—</span><span class="stat-label">Total group trips</span></div>
            <div class="stat-card"><span class="stat-num" id="stat-open-trips">—</span><span class="stat-label">Open for joining</span></div>
            <div class="stat-card"><span class="stat-num" id="stat-total-participants">—</span><span class="stat-label">Total participants</span></div>
        </div>
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">All group trips</h2>
            </div>
            <div class="table-toolbar">
                <input type="text" id="search-trips" class="search-input" placeholder="Search by package name...">
                <select id="filter-trip-status">
                    <option value="">All statuses</option>
                    <option value="open">Open</option>
                    <option value="full">Full</option>
                    <option value="closed">Closed</option>
                </select>
            </div>
            <div class="table-wrapper" id="group-trips-container">
                <div class="loading">Loading group trips...</div>
            </div>
            <div id="no-trips" class="empty-state" style="display:none;">
                <p>No group trips found.</p>
                <a href="/NanlaPA5/app/travel-agency/packages.php" class="btn-primary">Go to packages</a>
            </div>
        </div>
        <div class="modal-overlay" id="participants-modal" style="display:none;">
            <div class="modal modal-narrow">
                <h3 class="modal-title" id="participants-modal-title">Participants</h3>
                <div id="participants-list" class="participants-list">
                    <div class="loading">Loading...</div>
                </div>
                <div class="modal-actions">
                    <button class="btn-outline" onclick="closeParticipantsModal()">Close</button>
                </div>
            </div>
        </div>
    </div>
</main>

<?php require_once '../footer.php'; ?>