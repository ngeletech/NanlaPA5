<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Browse Packages – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container">

        <div class="page-header">
            <h1 class="page-title">Browse packages</h1>
            <p class="subtitle">Find your perfect trip from our curated collection</p>
        </div>

        <div class="browse-layout">

            <aside class="filters">
                <div class="filter-header">
                    <h3>Filters</h3>
                    <button class="clear-btn" id="clear-filters">Clear all</button>
                </div>

                <div class="filter-group">
                    <label>Destination</label>
                    <input type="text" id="filter-destination" placeholder="e.g. Paris, Bali...">
                </div>

                <div class="filter-group">
                    <label>Price range (ZAR)</label>
                    <div class="range-row">
                        <input type="number" id="filter-price-min" placeholder="Min">
                        <span>–</span>
                        <input type="number" id="filter-price-max" placeholder="Max">
                    </div>
                </div>

                <div class="filter-group">
                    <label>Duration (days)</label>
                    <div class="range-row">
                        <input type="number" id="filter-duration-min" placeholder="Min">
                        <span>–</span>
                        <input type="number" id="filter-duration-max" placeholder="Max">
                    </div>
                </div>

                <div class="filter-group">
                    <label>Minimum rating</label>
                    <select id="filter-rating">
                        <option value="">Any rating</option>
                        <option value="9">9+ Excellent</option>
                        <option value="8">8+ Very good</option>
                        <option value="7">7+ Good</option>
                        <option value="5">5+ Average</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Agency</label>
                    <select id="filter-agency">
                        <option value="">All agencies</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="checkbox-label">
                        <input type="checkbox" id="filter-group-trips">
                        <span>Group trips only</span>
                    </label>
                </div>

                <button class="btn-primary full-width" id="apply-filters">Apply filters</button>
            </aside>

            <div class="results">
                <div class="results-header">
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
                    <p>No packages found matching your filters.</p>
                    <button class="btn-outline" onclick="document.getElementById('clear-filters').click()">Clear filters</button>
                </div>
            </div>

        </div>

    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/browse.js';
require_once '../footer.php';
?>