<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Compare Packages – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container">

        <div class="page-header">
            <h1 class="page-title">Compare packages</h1>
            <p class="subtitle">Select up to 3 packages to compare side by side</p>
        </div>

        <div class="compare-tray" id="compare-tray" style="display:none;">
            <div class="compare-tray-inner">
                <div class="compare-slots" id="compare-slots"></div>
                <div class="compare-tray-actions">
                    <span id="compare-count" class="compare-count">0 selected</span>
                    <button class="btn-primary" id="compare-btn" disabled>Compare now</button>
                    <button class="btn-outline" id="clear-compare">Clear all</button>
                </div>
            </div>
        </div>

        <div id="compare-view" style="display:none;">
            <div class="compare-header">
                <h2 class="section-title">Side-by-side comparison</h2>
                <button class="btn-outline" id="back-to-browse">← Back to packages</button>
            </div>
            <div id="compare-table-container"></div>
        </div>

        <div id="packages-view">
            <div class="results-header" style="margin-bottom:1rem">
                <span id="results-count" class="results-count">Loading...</span>
                <div class="sort-row">
                    <label for="sort-by">Sort by</label>
                    <select id="sort-by">
                        <option value="price_asc">Price: Low to High</option>
                        <option value="price_desc">Price: High to Low</option>
                        <option value="rating_desc">Highest rated</option>
                        <option value="duration_asc">Shortest first</option>
                        <option value="duration_desc">Longest first</option>
                    </select>
                </div>
            </div>

            <div class="pkg-grid" id="packages-container">
                <div class="loading">Loading packages...</div>
            </div>

            <div id="no-results" class="empty-state" style="display:none;">
                <p>No packages found.</p>
            </div>
        </div>

    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/packages.js';
require_once '../footer.php';
?>