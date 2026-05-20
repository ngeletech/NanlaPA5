<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Leave a Review – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div class="container container-narrow">
        <div class="page-header">
            <h1 class="page-title">Leave a review</h1>
        </div>
        <div class="booking-card" id="review-package-summary">
            <div class="loading">Loading...</div>
        </div>
        <div id="review-error" class="error-banner" style="display:none;"></div>
        <div id="review-success" class="success-banner" style="display:none;"></div>
        <div class="form-card">
            <form id="review-form" novalidate>
                <input type="hidden" id="booking_id" name="booking_id">
                <input type="hidden" id="package_id" name="package_id">
                <input type="hidden" id="rating-value" name="rating" value="0">
                <div class="form-group">
                    <label>Your rating</label>
                    <div class="star-selector" id="star-selector">
                        <span class="star" data-value="1">★</span>
                        <span class="star" data-value="2">★</span>
                        <span class="star" data-value="3">★</span>
                        <span class="star" data-value="4">★</span>
                        <span class="star" data-value="5">★</span>
                    </div>
                    <span class="field-error" id="rating-error"></span>
                </div>
                <div class="form-group">
                    <label for="review-text">Your review</label>
                    <textarea id="review-text" name="review_text"
                              placeholder="Share your experience..." rows="5"></textarea>
                    <span class="field-error" id="review-text-error"></span>
                </div>
                <button type="submit" class="btn-primary full-width" id="review-submit-btn">
                    <span class="btn-text">Submit review</span>
                    <span class="btn-loader" style="display:none;">Submitting...</span>
                </button>
            </form>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/review.js';
require_once '../footer.php';
?>