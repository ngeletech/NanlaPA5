document.addEventListener('DOMContentLoaded', function () {
    var params = new URLSearchParams(window.location.search);
    var packageId = params.get('package_id');
    var bookingId = params.get('booking_id');

    if (!packageId) {
        document.getElementById('review-package-summary').innerHTML =
            '<div class="error-banner">No package selected.</div>';
        return;
    }

    // Set the hidden fields
    document.getElementById('package_id').value = packageId;
    if (bookingId) document.getElementById('booking_id').value = bookingId;

    // Load the package summary
    loadPackageSummary(packageId);

    // Form submit
    document.getElementById('review-form').addEventListener('submit', submitReview);
});

function loadPackageSummary(id) {
    makeRequest({ type: 'ViewPackage', package_id: parseInt(id) }, function (result) {
        var container = document.getElementById('review-package-summary');

        if (result.status !== 'success') {
            container.innerHTML = '<div class="error-banner">Could not load package details.</div>';
            return;
        }

        var pkg = result.data.package;
        container.innerHTML =
            '<p style="font-size:0.8rem; color:var(--text-muted); margin-bottom:4px;">Reviewing</p>' +
            '<h3 style="font-size:1.1rem; font-weight:600;">' + escHtml(pkg.Name) + '</h3>' +
            '<p style="font-size:0.85rem; color:var(--text-muted); margin-top:4px;">' + escHtml(pkg.AgencyName) + '</p>';
    });
}

function submitReview(e) {
    e.preventDefault();

    // Clear errors
    var ratingError = document.getElementById('rating-error');
    var textError = document.getElementById('review-text-error');
    var errorDiv = document.getElementById('review-error');
    var successDiv = document.getElementById('review-success');
    
    if (ratingError) ratingError.style.display = 'none';
    if (textError) textError.style.display = 'none';
    if (errorDiv) errorDiv.style.display = 'none';
    if (successDiv) successDiv.style.display = 'none';

    // Get rating from dropdown
    var ratingSelect = document.getElementById('rating-select');
    var rating = parseInt(ratingSelect.value);
    var comment = document.getElementById('review-text').value.trim();
    var packageId = parseInt(document.getElementById('package_id').value);
    var isValid = true;

    // Validate rating (1-10)
    if (!rating || rating < 1 || rating > 10) {
        if (ratingError) {
            ratingError.textContent = 'Please select a rating from 1 to 10.';
            ratingError.style.display = 'block';
        }
        isValid = false;
    }

    // Validate comment
    if (!comment || comment.length < 10) {
        if (textError) {
            textError.textContent = 'Review must be at least 10 characters.';
            textError.style.display = 'block';
        }
        isValid = false;
    }

    if (!isValid) return;

    // Disable button
    var btn = document.getElementById('review-submit-btn');
    var text = btn.querySelector('.btn-text');
    var loader = btn.querySelector('.btn-loader');
    btn.disabled = true;
    if (text) text.style.display = 'none';
    if (loader) loader.style.display = 'inline';

    // Get current date
    var today = new Date();
    var datePosted = today.toISOString().split('T')[0];

    makeRequest({
        type: 'makeReview',
        package_id: packageId,
        rating: rating,
        comment: comment,
        date_posted: datePosted
    }, function (result) {
        if (result.status === 'success') {
            var form = document.getElementById('review-form');
            if (form) form.style.display = 'none';
            
            if (successDiv) {
                successDiv.textContent = 'Review submitted! Thank you for your feedback.';
                successDiv.style.display = 'block';
            }

            setTimeout(function () {
                window.location.href = '/NanlaPA5/app/traveller/package-details.php?id=' + packageId;
            }, 2000);
        } else {
            if (errorDiv) {
                errorDiv.textContent = result.data || 'Submission failed. Please try again.';
                errorDiv.style.display = 'block';
            }
            btn.disabled = false;
            if (text) text.style.display = 'inline';
            if (loader) loader.style.display = 'none';
        }
    });
}

function escHtml(str) {
    var d = document.createElement('div');
    d.textContent = str || '';
    return d.innerHTML;
}