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
                
                <div class="form-group">
                    <label>Your rating (1-10)</label>
                    <select id="rating-select" class="form-control">
                        <option value="">Select a rating</option>
                        <option value="1">1 - Very Poor</option>
                        <option value="2">2 - Poor</option>
                        <option value="3">3 - Below Average</option>
                        <option value="4">4 - Fair</option>
                        <option value="5">5 - Average</option>
                        <option value="6">6 - Above Average</option>
                        <option value="7">7 - Good</option>
                        <option value="8">8 - Very Good</option>
                        <option value="9">9 - Excellent</option>
                        <option value="10">10 - Outstanding</option>
                    </select>
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