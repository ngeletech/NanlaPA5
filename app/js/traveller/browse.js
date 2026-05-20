// browse.js - Display and filter packages
document.addEventListener('DOMContentLoaded', function() {
    loadPackages();
    
    // Set up event listeners
    var applyBtn = document.getElementById('apply-filters');
    if (applyBtn) {
        applyBtn.addEventListener('click', loadPackages);
    }
    
    var sortBy = document.getElementById('sort-by');
    if (sortBy) {
        sortBy.addEventListener('change', loadPackages);
    }
    
    var clearBtn = document.getElementById('clear-filters');
    if (clearBtn) {
        clearBtn.addEventListener('click', function() {
            document.getElementById('filter-destination').value = '';
            document.getElementById('filter-price-min').value = '';
            document.getElementById('filter-price-max').value = '';
            document.getElementById('filter-duration-min').value = '';
            document.getElementById('filter-duration-max').value = '';
            document.getElementById('filter-rating').value = '';
            var groupCheckbox = document.getElementById('filter-group-trips');
            if (groupCheckbox) groupCheckbox.checked = false;
            loadPackages();
        });
    }
});

function loadPackages() {
    var container = document.getElementById('packages-container');
    var resultsCount = document.getElementById('results-count');
    var noResults = document.getElementById('no-results');
    
    if (!container) return;
    
    container.innerHTML = '<div class="loading">Loading packages...</div>';
    if (resultsCount) resultsCount.textContent = 'Loading...';
    if (noResults) noResults.style.display = 'none';
    
    var destination = document.getElementById('filter-destination') ? 
        document.getElementById('filter-destination').value.trim() : '';
    var minPrice = document.getElementById('filter-price-min') ? 
        document.getElementById('filter-price-min').value : '';
    var maxPrice = document.getElementById('filter-price-max') ? 
        document.getElementById('filter-price-max').value : '';
    var groupOnly = document.getElementById('filter-group-trips') ? 
        (document.getElementById('filter-group-trips').checked ? 1 : 0) : 0;
    var sort = document.getElementById('sort-by') ? 
        document.getElementById('sort-by').value : 'price_asc';
    
    var requestData = {
        type: 'GetPackages',
        destination: destination,
        min_price: minPrice,
        max_price: maxPrice,
        group_only: groupOnly,
        sort: sort
    };
    
    makeRequest(requestData, function(result) {
        if (result.status === 'success' && result.data && result.data.length > 0) {
            if (resultsCount) {
                resultsCount.textContent = result.data.length + ' packages found';
            }
            displayPackages(result.data);
        } else {
            container.innerHTML = '';
            if (noResults) noResults.style.display = 'block';
            if (resultsCount) resultsCount.textContent = '0 packages found';
        }
    });
}

function displayPackages(packages) {
    var container = document.getElementById('packages-container');
    if (!container) return;
    
    var html = '<div class="pkg-grid">';
    
    for (var i = 0; i < packages.length; i++) {
        var pkg = packages[i];
        var rating = parseFloat(pkg.AvgRating || 0).toFixed(1);
        var reviewCount = pkg.ReviewCount || 0;
        var price = parseFloat(pkg.Price || 0).toLocaleString('en-ZA');
        var groupBadge = pkg.Is_Group_Trip ? '<span class="group-badge">👥 Group Trip</span>' : '';
        
        html += '<div class="pkg-card">';
        html += '<div class="pkg-image">✈️</div>';
        html += '<div class="pkg-body">';
        html += '<div class="pkg-agency">' + escHtml(pkg.AgencyName) + '</div>';
        html += '<h3 class="pkg-name">' + escHtml(pkg.Name) + '</h3>';
        html += '<div class="pkg-meta">';
        html += '<span>📅 ' + pkg.Duration + ' days</span>';
        html += groupBadge;
        html += '</div>';
        html += '<div class="pkg-footer">';
        html += '<div class="pkg-price">R' + price + ' <small>/ person</small></div>';
        html += '<div class="pkg-rating">★ ' + rating + ' (' + reviewCount + ' reviews)</div>';
        html += '</div>';
        html += '<a href="/NanlaPA5/app/traveller/package-details.php?id=' + pkg.PackageID + '" class="btn-primary btn-block">View Details</a>';
        html += '</div></div>';
    }
    
    html += '</div>';
    container.innerHTML = html;
}