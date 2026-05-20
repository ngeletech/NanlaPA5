<?php
require_once '../auth_check.php';
requireTraveller();
$pageTitle = 'Package Details – Tripistry';
require_once '../header.php';
?>

<main class="main">
    <div id="package-detail-container">
        <div class="loading loading-full">Loading package details...</div>
    </div>
    <div class="container">
        <div class="section" id="reviews-section">
            <h2 class="section-title">Traveller reviews</h2>
            <div id="reviews-container">
                <div class="loading">Loading reviews...</div>
            </div>
        </div>
    </div>
</main>

<?php
$pageScript = '/NanlaPA5/app/js/traveller/package-details.js';
require_once '../footer.php';
?>