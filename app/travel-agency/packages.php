<?php
require_once '../auth_check.php';
requireAgency();
$pageTitle = 'My Packages – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container">
        <div class="page-header">
            <div>
                <h1 class="page-title">My packages</h1>
                <p class="subtitle">Manage your travel packages</p>
            </div>
            <a href="/NanlaPA5/app/travel-agency/package-edit.php" class="btn-primary">+ Create new package</a>
        </div>
        <div id="agency-error" class="error-banner" style="display:none;"></div>
        <div id="agency-success" class="success-banner" style="display:none;"></div>
        <div class="stats-grid" id="package-stats">
            <div class="stat-card"><span class="stat-num" id="stat-total">—</span><span class="stat-label">Total packages</span></div>
            <div class="stat-card"><span class="stat-num" id="stat-bookings">—</span><span class="stat-label">Total bookings</span></div>
            <div class="stat-card"><span class="stat-num" id="stat-rating">—</span><span class="stat-label">Average rating</span></div>
        </div>
        <div class="table-toolbar">
            <input type="text" id="search-packages" class="search-input" placeholder="Search packages...">
            <select id="filter-status">
                <option value="">All statuses</option>
                <option value="active">Active</option>
                <option value="draft">Draft</option>
                <option value="inactive">Inactive</option>
            </select>
            <select id="sort-packages">
                <option value="newest">Newest first</option>
                <option value="oldest">Oldest first</option>
                <option value="price_asc">Price: Low to High</option>
                <option value="price_desc">Price: High to Low</option>
                <option value="rating_desc">Highest rated</option>
            </select>
        </div>
        <div class="table-wrapper" id="packages-table-wrapper">
            <div class="loading">Loading packages...</div>
        </div>
        <div id="no-packages" class="empty-state" style="display:none;">
            <p>You haven't created any packages yet.</p>
            <a href="/NanlaPA5/app/travel-agency/package-edit.php" class="btn-primary">Create your first package</a>
        </div>
        <div class="modal-overlay" id="delete-modal" style="display:none;">
            <div class="modal">
                <h3 class="modal-title">Delete package</h3>
                <p class="modal-body">Are you sure you want to delete <strong id="delete-pkg-name"></strong>? This cannot be undone.</p>
                <div class="modal-actions">
                    <button class="btn-outline" id="cancel-delete">Cancel</button>
                    <button class="btn-danger" id="confirm-delete">Delete package</button>
                </div>
            </div>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/agency/packages.js';
require_once '../footer.php';
?>