// profile.js - Agency profile and dashboard
document.addEventListener('DOMContentLoaded', function () {
    loadAgencyProfile();
    loadAgencyStats();
    loadRecentBookings();
    loadPackagesPreview();
    setAgencyGreeting();
});

function setAgencyGreeting() {
    var greetingEl = document.getElementById('agency-greeting');
    if (!greetingEl) return;

    var agencyName = localStorage.getItem('userName') || 'Agency';
    greetingEl.textContent = 'Welcome back, ' + agencyName;
}

// Profile
function loadAgencyProfile() {
    var container = document.getElementById('profile-container');
    if (!container) return;

    container.innerHTML = '<div class="loading">Loading profile...</div>';

    makeRequest({ type: 'GetAgencyProfile' }, function (result) {
        if (result.status === 'success' && result.data) {
            displayProfileForm(result.data);
        } else {
            container.innerHTML = '<div class="error-banner">Failed to load profile.</div>';
        }
    });
}

function displayProfileForm(profile) {
    var container = document.getElementById('profile-container');
    if (!container) return;

    container.innerHTML =
        '<div class="form-group">' +
            '<label>Agency Name</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Name || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Registration Number</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Reg_Number || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Email</label>' +
            '<input type="email" class="form-control" value="' + escHtml(profile.Email || '') + '" readonly>' +
        '</div>';
}

// Stats
function loadAgencyStats() {
    makeRequest({ type: 'GetAgencyStats' }, function (result) {
        var statPackages = document.getElementById('stat-packages');
        var statBookings = document.getElementById('stat-bookings');
        var statRating = document.getElementById('stat-rating');
        var statGroupTrips = document.getElementById('stat-group-trips');

        if (result.status === 'success' && result.data) {
            if (statPackages) statPackages.textContent = result.data.total_packages || 0;
            if (statBookings) statBookings.textContent = result.data.total_bookings || 0;
            if (statRating) statRating.textContent = (result.data.avg_rating || 0).toFixed(1) + ' ★';
            if (statGroupTrips) statGroupTrips.textContent = result.data.total_group_trips || 0;
        } else {
            if (statPackages) statPackages.textContent = '—';
            if (statBookings) statBookings.textContent = '—';
            if (statRating) statRating.textContent = '—';
            if (statGroupTrips) statGroupTrips.textContent = '—';
        }
    });
}

// Recent bookings
function loadRecentBookings() {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;

    makeRequest({ type: 'GetAgencyRecentBookings', limit: 5 }, function (result) {
        if (result.status === 'success' && result.data && result.data.length) {
            displayRecentBookings(result.data);
        } else {
            container.innerHTML = '<div class="empty-state">No recent bookings yet.</div>';
        }
    });
}

function displayRecentBookings(bookings) {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;

    var html = '<div class="bookings-list">';

    bookings.forEach(function (b) {
        var status = (b.Status || b.status || 'pending').toLowerCase();
        var statusClass = {
            confirmed: 'status-confirmed',
            pending: 'status-pending',
            cancelled: 'status-cancelled'
        }[status] || 'status-pending';

        var total = parseFloat(b.TotalPrice || b.total_price || 0).toLocaleString('en-ZA');

        html +=
            '<div class="booking-item" style="display:flex; justify-content:space-between; align-items:center; padding:12px 0; border-bottom:1px solid var(--border);">' +
                '<div class="booking-info">' +
                    '<div style="font-weight:600; font-size:0.9rem;">' + escHtml(b.PackageName || b.package_name) + '</div>' +
                    '<div style="font-size:0.8rem; color:var(--text-muted); margin-top:3px;">' +
                        escHtml(b.TravellerName || b.traveller_name) + ' · ' + escHtml(b.TravelDate || b.travel_date) +
                    '</div>' +
                '</div>' +
                '<div style="display:flex; align-items:center; gap:8px;">' +
                    '<span class="status-badge ' + statusClass + '">' + status + '</span>' +
                    '<span style="font-weight:600;">R' + total + '</span>' +
                '</div>' +
            '</div>';
    });

    html += '</div>';
    container.innerHTML = html;
}

// Packages preview
function loadPackagesPreview() {
    var container = document.getElementById('packages-preview-container');
    if (!container) return;

    makeRequest({ type: 'GetAgencyPackages', limit: 3 }, function (result) {
        if (result.status === 'success' && result.data && result.data.length) {
            displayPackagesPreview(result.data);
        } else {
            container.innerHTML = '<div class="empty-state">No packages yet. <a href="/NanlaPA5/app/travel-agency/package-edit.php">Create your first package</a></div>';
        }
    });
}

function displayPackagesPreview(packages) {
    var container = document.getElementById('packages-preview-container');
    if (!container) return;

    var html = '<div class="packages-preview-list">';

    packages.forEach(function (p) {
        var price = parseFloat(p.Price || p.price || 0).toLocaleString('en-ZA');
        var packageId = p.PackageID || p.package_id;
        var packageName = p.Name || p.name;

        html +=
            '<div class="package-preview-item" style="display:flex; justify-content:space-between; align-items:center; padding:10px 0; border-bottom:1px solid var(--border);">' +
                '<div>' +
                    '<div style="font-weight:600;">' + escHtml(packageName) + '</div>' +
                    '<div style="font-size:0.75rem; color:var(--text-muted);">R' + price + ' · ' + (p.Duration || p.duration || '—') + ' days</div>' +
                '</div>' +
                '<a href="/NanlaPA5/app/travel-agency/package-edit.php?id=' + packageId + '" class="btn-outline" style="font-size:0.75rem; padding:4px 10px;">Edit</a>' +
            '</div>';
    });

    html += '</div>';
    container.innerHTML = html;
}