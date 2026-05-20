<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Compare Packages – Tripistry';
require_once '../header.php';
?>

<main class="t-main">
    <div class="t-container">

        <div class="t-page-header">
            <h1 class="t-page-title">Compare packages</h1>
            <p class="t-subtitle">Select up to 3 packages to compare side by side</p>
        </div>

        <!-- Compare tray (shows when packages are selected) -->
        <div class="t-compare-tray" id="compare-tray" style="display:none;">
            <div class="t-compare-tray-inner">
                <div class="t-compare-slots" id="compare-slots"></div>
                <div class="t-compare-tray-actions">
                    <span id="compare-count" class="t-compare-count">0 selected</span>
                    <button class="t-btn-gold" id="compare-btn" disabled>Compare now</button>
                    <button class="t-clear-btn" id="clear-compare">Clear all</button>
                </div>
            </div>
        </div>

        <!-- Compare view (shown after clicking Compare now) -->
        <div id="compare-view" style="display:none;">
            <div class="t-compare-header">
                <h2 class="t-section-title">Side-by-side comparison</h2>
                <button class="t-clear-btn" id="back-to-browse">← Back to packages</button>
            </div>
            <div id="compare-table-container"></div>
        </div>

        <!-- Package list view -->
        <div id="packages-view">
            <div class="t-results-header" style="margin-bottom:1rem">
                <span id="results-count" class="t-results-count">Loading...</span>
                <div class="t-sort-row">
                    <label for="sort-by">Sort by</label>
                    <select id="sort-by" class="t-input t-input-sm">
                        <option value="price_asc">Price: Low to High</option>
                        <option value="price_desc">Price: High to Low</option>
                        <option value="rating_desc">Highest rated</option>
                        <option value="duration_asc">Shortest first</option>
                        <option value="duration_desc">Longest first</option>
                    </select>
                </div>
            </div>

            <div class="t-pkg-grid" id="packages-container">
                <div class="t-loading">Loading packages...</div>
            </div>

            <div id="no-results" class="t-no-results" style="display:none;">
                <p>No packages found.</p>
            </div>
        </div>

    </div>
</main>

<?php
$pageScript = '/js/traveller/packages.js';
require_once '../footer.php';
?>