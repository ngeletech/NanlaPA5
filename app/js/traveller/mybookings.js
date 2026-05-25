var allBookings = [];
var activeTab   = 'upcoming';

document.addEventListener('DOMContentLoaded', function () {
    loadBookings();

    document.querySelectorAll('.tab').forEach(function (tab) {
        tab.addEventListener('click', function () {
            document.querySelectorAll('.tab').forEach(function (t) {
                t.classList.remove('active');
            });
            this.classList.add('active');
            activeTab = this.dataset.tab;
            renderBookings();
        });
    });
});

function loadBookings() {
    makeRequest({ type: 'GetRecentBookings' }, function (result) {
        if (result.status !== 'success') {
            showEmpty();
            return;
        }
        allBookings = result.data || [];
        renderBookings();
    });
}

function renderBookings() {
    var today = new Date();
    today.setHours(0, 0, 0, 0);

    var filtered = allBookings.filter(function (b) {
        var tripDate = new Date(b.TravelDate);
        if (activeTab === 'upcoming') return tripDate >= today;
        if (activeTab === 'past')     return tripDate <  today;
        return true;
    });

    var container = document.getElementById('bookings-container');
    var noEl = document.getElementById('no-bookings');

    if (!filtered.length) {
        container.innerHTML = '';
        noEl.style.display  = 'block';
        return;
    }

    noEl.style.display  = 'none';
    container.innerHTML = filtered.map(function (b) {
        var statusClass = {
            confirmed: 'status-confirmed',
            pending:   'status-pending',
            cancelled: 'status-cancelled'
        }[b.status] || 'status-pending';

        var canReview = true;

        return '<div class="booking-detail-card">' +
            '<div class="booking-card-header">' +
                '<div>' +
                    '<h3 style="font-size:1rem; font-weight:600;">' + escHtml(b.PackageName) + '</h3>' +
                    '<p class="booking-agency">' + escHtml(b.AgencyName) + '</p>' +
                '</div>' +
                '<span class="status-badge ' + statusClass + '">' + escHtml(b.status || 'pending') + '</span>' +
            '</div>' +
            '<div class="booking-card-body">' +
                '<div class="booking-detail-row">' +
                    '<span>Travel date</span>' +
                    '<span>' + escHtml(b.TravelDate) + '</span>' +
                '</div>' +
                '<div class="booking-detail-row total">' +
                    '<span>Total paid</span>' +
                    '<span>R' + parseFloat(b.TotalPrice || 0).toLocaleString('en-ZA') + '</span>' +
                '</div>' +
            '</div>' +
            '<div class="booking-card-footer">' +
                '<a href="/NanlaPA5/app/traveller/package-details.php?id=' + b.PackageID + '" ' +
                   'class="btn-outline">View package</a>' +
                (canReview
                    ? '<a href="/NanlaPA5/app/traveller/review.php?package_id=' + b.PackageID + '" ' + b.BookingID + '" ' +
                      'class="btn-primary">Leave review</a>'
                    : '') +
            '</div>' +
        '</div>';
    }).join('');
}

function showEmpty() {
    document.getElementById('bookings-container').innerHTML = '';
    document.getElementById('no-bookings').style.display = 'block';
}