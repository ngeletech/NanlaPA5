document.addEventListener('DOMContentLoaded', function () {
    var params    = new URLSearchParams(window.location.search);
    var packageId = params.get('id');

    if (!packageId) {
        document.getElementById('package-detail-container').innerHTML =
            '<div class="container"><div class="error-banner">No package selected.</div></div>';
        return;
    }

    loadPackageDetail(packageId);
    loadReviews(packageId);
});

function loadPackageDetail(id) {
    makeRequest({ type: 'ViewPackage', package_id: parseInt(id) }, function (result) {
        if (result.status !== 'success') {
            document.getElementById('package-detail-container').innerHTML =
                '<div class="container"><div class="error-banner">Package not found.</div></div>';
            return;
        }

        var d = result.data;
        var pkg = d.package;

        if (!pkg) {
            document.getElementById('package-detail-container').innerHTML =
                '<div class="container"><div class="error-banner">Package data missing.</div></div>';
            return;
        }

        renderPackageDetail(pkg, d);
    });
}

function renderPackageDetail(pkg, d) {
    var rating = parseFloat(pkg.AvgRating || 0).toFixed(1);
    var price  = parseFloat(pkg.Price || 0).toLocaleString('en-ZA');

    document.title = (pkg.Name || 'Package') + ' – Tripistry';

    // hero
    var html =
        '<div class="detail-hero">' +
            '<div class="detail-hero-info">' +
                '<p class="detail-breadcrumb">' +
                    '<a href="/NanlaPA5/app/traveller/browse.php">Browse</a> / ' +
                    escHtml(pkg.Name) +
                '</p>' +
                '<h1 class="detail-title">' + escHtml(pkg.Name) + '</h1>' +
                '<p class="detail-agency">By ' + escHtml(pkg.AgencyName || '') + '</p>' +
                '<div class="detail-meta">' +
                    '<span>📅 ' + (pkg.Duration || '?') + ' days</span>' +
                    (pkg.Start_Date ? '<span>🗓 From ' + escHtml(pkg.Start_Date) + '</span>' : '') +
                    '<span>★ ' + rating + ' (' + (pkg.ReviewCount || 0) + ' reviews)</span>' +
                    (pkg.Max_Group_Size ? '<span>👥 Max ' + pkg.Max_Group_Size + ' people</span>' : '') +
                '</div>' +
            '</div>' +
            '<div class="detail-price-card">' +
                '<div class="price-amount">R' + price + '</div>' +
                '<div class="price-label">per person</div>' +
                '<a href="/NanlaPA5/app/traveller/book.php?id=' + pkg.PackageID + '" ' +
                   'class="btn-primary full-width" style="margin-top:1rem">Book now</a>' +
                '<p class="price-note">No hidden fees</p>' +
            '</div>' +
        '</div>';

    html += '<div class="container"><div class="detail-body">';

    // description
    html +=
        '<div class="detail-section">' +
            '<h2>About this package</h2>' +
            '<p class="detail-description">' +
                escHtml(pkg.Description || 'No description provided.') +
            '</p>' +
        '</div>';

    // destinations
    if (d.destinations && d.destinations.length) {
        html += '<div class="detail-section"><h2>Destinations</h2><div class="tag-list">';
        d.destinations.forEach(function (dest) {
            html += '<span class="tag">' +
                escHtml(dest.City_Name) + ', ' + escHtml(dest.Country_Name) +
            '</span>';
        });
        html += '</div></div>';
    }

    // flights
    if (d.flights && d.flights.length) {
        html += '<div class="detail-section"><h2>Included flights</h2><div class="flights-list">';
        d.flights.forEach(function (f) {
            html +=
                '<div class="flight-card">' +
                    '<div class="flight-route">' +
                        '<span class="flight-city">' + escHtml(f.Departure_City) + '</span>' +
                        '<span class="flight-arrow">✈</span>' +
                        '<span class="flight-city">' + escHtml(f.Arrival_City) + '</span>' +
                    '</div>' +
                    '<div class="flight-info">' +
                        '<span>' + escHtml(f.Flight_Name || '') + '</span>' +
                        (f.Departure_Date ? '<span>' + escHtml(f.Departure_Date) + '</span>' : '') +
                        (f.Departure_Time ? '<span>' + escHtml(f.Departure_Time) + '</span>' : '') +
                        (f.Duration       ? '<span>'  + escHtml(String(f.Duration)) + 'h</span>' : '') +
                    '</div>' +
                '</div>';
        });
        html += '</div></div>';
    }

    // accommodations
    if (d.accommodations && d.accommodations.length) {
        html += '<div class="detail-section"><h2>Accommodation</h2><div class="accommodation-list">';
        d.accommodations.forEach(function (a) {
            html +=
                '<div class="accommodation-card">' +
                    '<div class="acc-header">' +
                        '<strong>' + escHtml(a.Name) + '</strong>' +
                        '<span class="acc-type">' + escHtml(a.Type || '') + '</span>' +
                    '</div>' +
                    '<div class="acc-info">' +
                        (a.Check_in_time  ? '<span>Check-in: '  + escHtml(a.Check_in_time)  + '</span>' : '') +
                        (a.Check_out_time ? '<span>Check-out: ' + escHtml(a.Check_out_time) + '</span>' : '') +
                    '</div>' +
                '</div>';
        });
        html += '</div></div>';
    }

    // attractions
    if (d.attractions && d.attractions.length) {
        html += '<div class="detail-section"><h2>Attractions</h2><div class="attractions-grid">';
        d.attractions.forEach(function (a) {
            html +=
                '<div class="attraction-card">' +
                    '<strong>' + escHtml(a.Name) + '</strong>' +
                    '<div class="attraction-info">' +
                        (a.Popularity_Rating
                            ? '<span>Popularity: '    + escHtml(String(a.Popularity_Rating))    + '/10</span>'
                            : '') +
                        (a.Accessibility_Rating
                            ? '<span>Accessibility: ' + escHtml(String(a.Accessibility_Rating)) + '/10</span>'
                            : '') +
                        (a.Opening_Time ? '<span>Opens: '  + escHtml(a.Opening_Time) + '</span>' : '') +
                        (a.Closing_Time ? '<span>Closes: ' + escHtml(a.Closing_Time) + '</span>' : '') +
                    '</div>' +
                '</div>';
        });
        html += '</div></div>';
    }

    // restaurants
    if (d.restaurants && d.restaurants.length) {
        html += '<div class="detail-section"><h2>Restaurants</h2><div class="restaurants-grid">';
        d.restaurants.forEach(function (r) {
            var tags = [];
            if (parseInt(r.is_halaal) === 1) tags.push('Halaal');
            if (parseInt(r.is_vegan)  === 1) tags.push('Vegan');
            html +=
                '<div class="restaurant-card">' +
                    '<strong>' + escHtml(r.Name) + '</strong>' +
                    '<div class="rest-type">' + escHtml(r.Type || '') + '</div>' +
                    (tags.length ? '<div class="rest-tags">' + tags.join(' · ') + '</div>' : '') +
                    (r.Rating
                        ? '<div class="rest-rating">★ ' + parseFloat(r.Rating).toFixed(1) + '</div>'
                        : '') +
                '</div>';
        });
        html += '</div></div>';
    }

    html += '</div></div>'; // close detail-body + container

    document.getElementById('package-detail-container').innerHTML = html;
}

function loadReviews(id) {
    makeRequest({ type: 'GetReview', package_id: parseInt(id) }, function (result) {
        var container = document.getElementById('reviews-container');

        if (result.status !== 'success' || !result.data || !result.data.length) {
            container.innerHTML =
                '<p style="color:var(--text-muted);padding:1rem 0">No reviews yet for this package.</p>';
            return;
        }

        var html = '<div class="reviews-list">';
        result.data.forEach(function (r) {
            var stars = '';
            for (var i = 1; i <= 10; i++) {
                stars += i <= parseInt(r.Rating) ? '★' : '☆';
            }
            html +=
                '<div class="review-card">' +
                    '<div class="review-header">' +
                        '<div class="reviewer-avatar">' +
                            escHtml((r.TravellerName || 'T')[0].toUpperCase()) +
                        '</div>' +
                        '<div class="reviewer-info">' +
                            '<span class="reviewer-name">' +
                                escHtml(r.TravellerName || 'Traveller') +
                            '</span>' +
                            '<span class="review-date">' +
                                escHtml(r.Date_Posted || '') +
                            '</span>' +
                        '</div>' +
                        '<div class="review-stars">' + stars + '</div>' +
                    '</div>' +
                    '<p class="review-comment">' + escHtml(r.Comment || '') + '</p>' +
                '</div>';
        });
        html += '</div>';

        container.innerHTML = html;
    });
}