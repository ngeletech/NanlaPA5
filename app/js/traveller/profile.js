document.addEventListener('DOMContentLoaded', function () {
    loadTravellerProfile();
    loadRecentBookings();
    loadRecommendedPackages();
    loadReviewCount();
    setGreeting();
});

function setGreeting() {
    var greetingEl = document.getElementById('greeting');
    if (!greetingEl) return;

    var hour = new Date().getHours();
    var userName = localStorage.getItem('userName') || 'Traveller';
    var greeting = '';

    if (hour < 12) greeting = 'Good morning, '   + userName;
    else if (hour < 18) greeting = 'Good afternoon, ' + userName;
    else greeting = 'Good evening, '   + userName;

    greetingEl.textContent = greeting;
}

//Profile
function loadTravellerProfile() {
    var container = document.getElementById('profile-container');
    if (!container) return;

    container.innerHTML = '<div class="loading">Loading profile...</div>';

    makeRequest({ type: 'GetTravellerProfile' }, function (result) {
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
            '<label>Name</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Name || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Surname</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Surname || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Email</label>' +
            '<input type="email" class="form-control" value="' + escHtml(profile.Email || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Date of birth</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Date_of_Birth || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Citizenship</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Citizenship || '') + '" readonly>' +
        '</div>' +
        '<div class="form-group">' +
            '<label>Passport Number</label>' +
            '<input type="text" class="form-control" value="' + escHtml(profile.Passport_Number || '') + '" readonly>' +
        '</div>';
}

//Recent bookings 
function loadRecentBookings() {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;

    makeRequest({ type: 'GetRecentBookings', limit: 5 }, function (result) {
        if (result.status === 'success' && result.data && result.data.length) {
            displayRecentBookings(result.data);
        } else {
            container.innerHTML =
                '<div class="empty-state">No recent bookings. ' +
                '<a href="/NanlaPA5/app/traveller/browse.php">Browse packages →</a></div>';
        }
    });
}

function displayRecentBookings(bookings) {
    console.log('Bookings data:', bookings);

    var container = document.getElementById('recent-bookings-container');
    if (!container) return;

    var today = new Date().toISOString().split('T')[0];
    var upcoming = 0;

    var html = '<div class="bookings-list">';

    bookings.forEach(function (b) {
        var status      = (b.status || b.Status || 'pending').toLowerCase();
        var statusClass = {
            confirmed: 'status-confirmed',
            pending:   'status-pending',
            cancelled: 'status-cancelled'
        }[status] || 'status-pending';

        if (b.TravelDate >= today) upcoming++;

        html +=
            '<div class="booking-item" style="display:flex; justify-content:space-between; align-items:center; padding:12px 0; border-bottom:1px solid var(--border);">' +
                '<div class="booking-info">' +
                    '<div style="font-weight:600; font-size:0.9rem;">' + escHtml(b.PackageName) + '</div>' +
                    '<div style="font-size:0.8rem; color:var(--text-muted); margin-top:3px;">' +
                        ' ' + escHtml(b.TravelDate || '—') +
                    '</div>' +
                '</div>' +
                '<div style="display:flex; align-items:center; gap:8px;">' +
                    '<span class="status-badge ' + statusClass + '">' + escHtml(status) + '</span>' +
                    '<a href="/NanlaPA5/app/traveller/package-details.php?id=' + b.PackageID + '" ' +
                       'class="btn-outline" style="font-size:0.78rem; padding:4px 10px;">View</a>' +
                '</div>' +
            '</div>';
    });

    html += '</div>';
    container.innerHTML = html;

    // Update stats
    var statBookings = document.getElementById('stat-bookings');
    var statUpcoming = document.getElementById('stat-upcoming');
    if (statBookings) statBookings.textContent = bookings.length;
    if (statUpcoming) statUpcoming.textContent = upcoming;
}

// Recommended packages
function loadRecommendedPackages() {
    var container = document.getElementById('featured-packages-container');
    if (!container) return;

    makeRequest({ type: 'GetPackages' }, function (result) {
        if (result.status === 'success' && result.data && result.data.length) {
            // just show first 3
            var packages = result.data.slice(0, 3);
            container.innerHTML = packages.map(function (pkg) {
                return buildPackageCard(pkg, { showCompare: false });
            }).join('');
        } else {
            container.innerHTML = '<div class="empty-state">No recommendations yet. Start browsing!</div>';
        }
    });
}

function loadReviewCount() {
    makeRequest({ type: 'GetReviewCount' }, function (result) {
        var statReviews = document.getElementById('stat-reviews');
        if (statReviews) {
            if (result.status === 'success' && result.data) {
                statReviews.textContent = result.data.count || 0;
            } else {
                statReviews.textContent = '0';
            }
        }
    });
}