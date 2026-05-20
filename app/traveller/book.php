<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Book Package – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container container-narrow">
        <div class="page-header">
            <h1 class="page-title">Confirm your booking</h1>
        </div>
        <div class="booking-card" id="booking-summary">
            <div class="loading">Loading package details...</div>
        </div>
        <div id="booking-error" class="error-banner" style="display:none;"></div>
        <div id="booking-success" class="success-banner" style="display:none;"></div>
        <div class="form-card" id="booking-form-wrapper">
            <h2 class="form-section-title">Booking details</h2>
            <form id="booking-form" novalidate>
                <input type="hidden" id="package_id" name="package_id">
                <div class="form-group">
                    <label for="num_travellers">Number of travellers</label>
                    <input type="number" id="num_travellers" name="num_travellers" min="1" max="20" value="1">
                    <span class="field-error" id="num_travellers-error"></span>
                </div>
                <div class="form-group">
                    <label for="travel_date">Travel date</label>
                    <input type="date" id="travel_date" name="travel_date">
                    <span class="field-error" id="travel_date-error"></span>
                </div>
                <div class="form-group">
                    <label for="special_requests">Special requests <span class="optional">(optional)</span></label>
                    <textarea id="special_requests" name="special_requests"
                              placeholder="Dietary requirements, accessibility needs, etc." rows="3"></textarea>
                </div>
                <div class="price-summary" id="price-summary" style="display:none;">
                    <div class="price-row"><span>Price per person</span><span id="price-per-person">—</span></div>
                    <div class="price-row"><span>Travellers</span><span id="price-travellers">—</span></div>
                    <div class="price-row price-total"><span>Total</span><span id="price-total">—</span></div>
                </div>
                <button type="submit" class="btn-primary full-width" id="booking-submit-btn">
                    <span class="btn-text">Confirm booking</span>
                    <span class="btn-loader" style="display:none;">Processing...</span>
                </button>
            </form>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/book.js';
require_once '../footer.php';
?>