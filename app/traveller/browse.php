<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Browse Packages – Tripistry';
require_once '../header.php';
?>

<main class="t-main">
    <div class="t-container">

        <div class="t-page-header">
            <h1 class="t-page-title">Browse packages</h1>
            <p class="t-subtitle">Find your perfect trip from our curated collection</p>
        </div>

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

        <div id="compare-view" style="display:none;">
            <div class="t-compare-header">
                <h2 class="t-section-title">Side-by-side comparison</h2>
                <button class="t-clear-btn" id="back-to-browse">← Back to packages</button>
            </div>
            <div id="compare-table-container"></div>
        </div>

        <div id="packages-view">
            <div class="t-browse-layout">

                <aside class="t-filters">
                    <div class="t-filter-header">
                        <h3>Filters</h3>
                        <button class="t-clear-btn" id="clear-filters">Clear all</button>
                    </div>
                    <div class="t-filter-group">
                        <label class="t-filter-label">Destination</label>
                        <input type="text" id="filter-destination" class="t-input" placeholder="e.g. Paris, Bali...">
                    </div>
                    <div class="t-filter-group">
                        <label class="t-filter-label">Price range (ZAR)</label>
                        <div class="t-range-row">
                            <input type="number" id="filter-price-min" class="t-input t-input-sm" placeholder="Min">
                            <span>–</span>
                            <input type="number" id="filter-price-max" class="t-input t-input-sm" placeholder="Max">
                        </div>
                    </div>
                    <div class="t-filter-group">
                        <label class="t-filter-label">Duration (days)</label>
                        <div class="t-range-row">
                            <input type="number" id="filter-duration-min" class="t-input t-input-sm" placeholder="Min">
                            <span>–</span>
                            <input type="number" id="filter-duration-max" class="t-input t-input-sm" placeholder="Max">
                        </div>
                    </div>
                    <div class="t-filter-group">
                        <label class="t-filter-label">Minimum rating</label>
                        <select id="filter-rating" class="t-input">
                            <option value="">Any rating</option>
                            <option value="4">4★ and above</option>
                            <option value="3">3★ and above</option>
                            <option value="2">2★ and above</option>
                        </select>
                    </div>
                    <div class="t-filter-group">
                        <label class="t-filter-label">Agency</label>
                        <select id="filter-agency" class="t-input">
                            <option value="">All agencies</option>
                        </select>
                    </div>
                    <div class="t-filter-group">
                        <label class="t-checkbox-label">
                            <input type="checkbox" id="filter-group-trips">
                            <span>Group trips only</span>
                        </label>
                    </div>
                    <button class="t-btn-apply" id="apply-filters">Apply filters</button>
                </aside>

                <div class="t-results">
                    <div class="t-results-header">
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
                        <p>No packages found matching your filters.</p>
                        <button class="t-clear-btn" onclick="document.getElementById('clear-filters').click()">
                            Clear filters
                        </button>
                    </div>
                </div>

            </div>
        </div>

    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/browse.js';
require_once '../footer.php';
?>