<?php
require_once '../auth_check.php';
requireAgency();
$editMode  = isset($_GET['id']) && !empty($_GET['id']);
$pageTitle = $editMode ? 'Edit Package – Tripistry' : 'Create Package – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container container-narrow">
        <div class="page-header">
            <div>
                <h1 class="page-title"><?= $editMode ? 'Edit package' : 'Create new package' ?></h1>
                <p class="subtitle"><?= $editMode ? 'Update your package details below' : 'Fill in the details to list a new package' ?></p>
            </div>
            <a href="/NanlaPA5/app/travel-agency/packages.php" class="btn-outline">← Back to packages</a>
        </div>
        <div id="form-error" class="error-banner" style="display:none;"></div>
        <div id="form-success" class="success-banner" style="display:none;"></div>
        <form id="package-form" novalidate>
            <input type="hidden" id="package_id" name="package_id"
                   value="<?= $editMode ? htmlspecialchars($_GET['id']) : '' ?>">
            <input type="hidden" name="action" value="<?= $editMode ? 'update' : 'create' ?>">
            <div class="form-card">
                <h2 class="form-section-title">Basic details</h2>
                <div class="form-group">
                    <label for="package_name">Package name</label>
                    <input type="text" id="package_name" name="package_name" placeholder="e.g. 7 Days in Tuscany">
                    <span class="field-error" id="package_name-error"></span>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" placeholder="Describe what travellers can expect..." rows="4"></textarea>
                    <span class="field-error" id="description-error"></span>
                </div>
                <div class="form-grid-3">
                    <div class="form-group">
                        <label for="price">Price per person (ZAR)</label>
                        <input type="number" id="price" name="price" placeholder="e.g. 25000" min="0" step="0.01">
                        <span class="field-error" id="price-error"></span>
                    </div>
                    <div class="form-group">
                        <label for="duration">Duration (days)</label>
                        <input type="number" id="duration" name="duration" placeholder="e.g. 7" min="1">
                        <span class="field-error" id="duration-error"></span>
                    </div>
                    <div class="form-group">
                        <label for="start_date">Start date</label>
                        <input type="date" id="start_date" name="start_date">
                        <span class="field-error" id="start_date-error"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="draft">Draft — not visible to travellers</option>
                        <option value="active">Active — visible to travellers</option>
                        <option value="inactive">Inactive — hidden from travellers</option>
                    </select>
                </div>
            </div>
            <div class="form-card">
                <h2 class="form-section-title">Destinations</h2>
                <div class="item-list" id="destinations-list"></div>
                <div class="add-row">
                    <select id="destination-select"><option value="">Loading destinations...</option></select>
                    <button type="button" class="btn-add" onclick="addItem('destination')">+ Add</button>
                </div>
                <span class="field-error" id="destinations-error"></span>
            </div>
            <div class="form-card">
                <h2 class="form-section-title">Flights <span class="optional">optional</span></h2>
                <div class="item-list" id="flights-list"></div>
                <div class="add-row">
                    <select id="flight-select"><option value="">Loading flights...</option></select>
                    <button type="button" class="btn-add" onclick="addItem('flight')">+ Add</button>
                </div>
            </div>
            <div class="form-card">
                <h2 class="form-section-title">Accommodation <span class="optional">optional</span></h2>
                <div class="item-list" id="accommodations-list"></div>
                <div class="add-row">
                    <select id="accommodation-select"><option value="">Loading accommodation...</option></select>
                    <button type="button" class="btn-add" onclick="addItem('accommodation')">+ Add</button>
                </div>
            </div>
            <div class="form-card">
                <h2 class="form-section-title">Attractions <span class="optional">optional</span></h2>
                <div class="item-list" id="attractions-list"></div>
                <div class="add-row">
                    <select id="attraction-select"><option value="">Loading attractions...</option></select>
                    <button type="button" class="btn-add" onclick="addItem('attraction')">+ Add</button>
                </div>
            </div>
            <div class="form-card">
                <h2 class="form-section-title">Restaurants <span class="optional">optional</span></h2>
                <div class="item-list" id="restaurants-list"></div>
                <div class="add-row">
                    <select id="restaurant-select"><option value="">Loading restaurants...</option></select>
                    <button type="button" class="btn-add" onclick="addItem('restaurant')">+ Add</button>
                </div>
            </div>
            <div class="form-card">
                <h2 class="form-section-title">Group trip settings</h2>
                <div class="toggle-row">
                    <div>
                        <p class="toggle-label">Enable group trips</p>
                        <p class="toggle-sub">Allow multiple travellers to join as a group</p>
                    </div>
                    <label class="toggle">
                        <input type="checkbox" id="is_group_trip" name="is_group_trip" onchange="toggleGroupOptions(this)">
                        <span class="toggle-slider"></span>
                    </label>
                </div>
                <div id="group-options" style="display:none; margin-top:1.25rem">
                    <div class="form-grid-2">
                        <div class="form-group">
                            <label for="max_participants">Max participants</label>
                            <input type="number" id="max_participants" name="max_participants" placeholder="e.g. 20" min="2">
                            <span class="field-error" id="max_participants-error"></span>
                        </div>
                        <div class="form-group">
                            <label for="group_trip_date">Group trip date</label>
                            <input type="date" id="group_trip_date" name="group_trip_date">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <a href="/NanlaPA5/app/travel-agency/packages.php" class="btn-outline">Cancel</a>
                <button type="submit" class="btn-primary" id="submit-btn">
                    <span class="btn-text"><?= $editMode ? 'Save changes' : 'Create package' ?></span>
                    <span class="btn-loader" style="display:none;">Saving...</span>
                </button>
            </div>
        </form>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/agency/package-edit.js';
require_once '../footer.php';
?>