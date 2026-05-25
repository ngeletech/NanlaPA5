var packagePrice = 0;

document.addEventListener('DOMContentLoaded', function () {
    var params    = new URLSearchParams(window.location.search);
    var packageId = params.get('id');

    if (!packageId) {
        document.getElementById('booking-summary').innerHTML =
            '<div class="error-banner">No package selected.</div>';
        document.getElementById('booking-form-wrapper').style.display = 'none';
        return;
    }

    document.getElementById('package_id').value = packageId;
    loadPackageSummary(packageId);

    document.getElementById('num_travellers').addEventListener('input', updateTotal);
    document.getElementById('booking-form').addEventListener('submit', submitBooking);
});

function loadPackageSummary(id) {
    makeRequest({ type: 'ViewPackage', package_id: parseInt(id) }, function (result) {
        var container = document.getElementById('booking-summary');

        if (result.status !== 'success') {
            container.innerHTML = '<div class="error-banner">Could not load package details.</div>';
            return;
        }

        var pkg      = result.data.package;
        packagePrice = parseFloat(pkg.Price || 0);

        container.innerHTML =
            '<p style="font-size:0.8rem; color:var(--text-muted); margin-bottom:4px;">Booking</p>' +
            '<h3 style="font-size:1.1rem; font-weight:600; margin-bottom:4px;">' + escHtml(pkg.Name) + '</h3>' +
            '<p style="font-size:0.85rem; color:var(--text-muted);">' +
                escHtml(pkg.AgencyName || pkg.Agency_Name) + ' · ' + (pkg.Duration || '—') + ' days' +
            '</p>';

        document.getElementById('price-per-person').textContent = 'R' + packagePrice.toLocaleString('en-ZA');
        document.getElementById('price-summary').style.display = 'block';
        updateTotal();
    });
}

function updateTotal() {
    var num   = parseInt(document.getElementById('num_travellers').value) || 1;
    var total = packagePrice * num;
    document.getElementById('price-travellers').textContent = num;
    document.getElementById('price-total').textContent = 'R' + total.toLocaleString('en-ZA');
}

function submitBooking(e) {
    e.preventDefault();

    var numError = document.getElementById('num_travellers-error');
    var dateError = document.getElementById('travel_date-error');
    if (numError) numError.innerText = '';
    if (dateError) dateError.innerText = '';

    var numTravellers = parseInt(document.getElementById('num_travellers').value);
    var travelDate = document.getElementById('travel_date').value;
    var specialRequests = document.getElementById('special_requests').value;
    var packageId = parseInt(document.getElementById('package_id').value);
    var isValid = true;

    if (!numTravellers || numTravellers < 1) {
        if (numError) numError.innerText = 'Please enter at least 1 traveller.';
        isValid = false;
    }

    if (!travelDate) {
        if (dateError) dateError.innerText = 'Please select a travel date.';
        isValid = false;
    } else {
        var selected = new Date(travelDate);
        var today    = new Date();
        today.setHours(0, 0, 0, 0);
        if (selected <= today) {
            if (dateError) dateError.innerText = 'Travel date must be in the future.';
            isValid = false;
        }
    }

    if (!isValid) return;

    var submitBtn = document.getElementById('booking-submit-btn');
    if (submitBtn) {
        submitBtn.disabled = true;
        var btnText = submitBtn.querySelector('.btn-text');
        var btnLoader = submitBtn.querySelector('.btn-loader');
        if (btnText) btnText.style.display = 'none';
        if (btnLoader) btnLoader.style.display = 'inline';
    }

    var errorDiv = document.getElementById('booking-error');
    var successDiv = document.getElementById('booking-success');
    if (errorDiv) errorDiv.style.display = 'none';
    if (successDiv) successDiv.style.display = 'none';

    makeRequest({
        type: 'BookPackage',
        package_id: packageId,
        price_paid: Math.round(packagePrice * numTravellers),
        date: travelDate
    }, function (result) {
        if (result.status === 'success') {
            if (successDiv) {
                successDiv.innerHTML = '<p>Booking confirmed! Redirecting to your bookings...</p>';
                successDiv.style.display = 'block';
            }
            setTimeout(function() {
                window.location.href = '/NanlaPA5/app/traveller/mybookings.php';
            }, 1500);
        } else {
            if (errorDiv) {
                errorDiv.innerHTML = '<p>' + (result.data || 'Booking failed. Please try again.') + '</p>';
                errorDiv.style.display = 'block';
            }
            if (submitBtn) {
                submitBtn.disabled = false;
                if (btnText) btnText.style.display = 'inline';
                if (btnLoader) btnLoader.style.display = 'none';
            }
        }
    });
}