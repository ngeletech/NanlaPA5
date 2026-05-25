var allPackages = [];

document.addEventListener('DOMContentLoaded', function () {
    loadPackages();

    document.getElementById('apply-filters').addEventListener('click', applyFilters);
    document.getElementById('sort-by').addEventListener('change', applyFilters);

    document.getElementById('clear-filters').addEventListener('click', function () {
        document.getElementById('filter-destination').value = '';
        document.getElementById('filter-price-min').value = '';
        document.getElementById('filter-price-max').value = '';
        document.getElementById('filter-duration-min').value  = '';
        document.getElementById('filter-duration-max').value  = '';
        document.getElementById('filter-rating').value = '';
        document.getElementById('filter-group-trips').checked = false;
        document.getElementById('filter-agency').value = '';
        applyFilters();
    });
});

function loadPackages() {
    var container = document.getElementById('packages-container');
    container.innerHTML = '<div class="loading">Loading packages...</div>';

    makeRequest({ type: 'GetPackages' }, function (result) {
        if (result.status === 'success' && result.data && result.data.length) {
            allPackages = result.data;
            populateAgencyFilter();
            applyFilters();
        } else {
            container.innerHTML = '';
            document.getElementById('no-results').style.display  = 'block';
            document.getElementById('results-count').textContent = '0 packages found';
        }
    });
}

function populateAgencyFilter() {
    var select = document.getElementById('filter-agency');
    var seen   = {};
    allPackages.forEach(function (pkg) {
        var name = pkg.Agency_Name || pkg.AgencyName || '';
        if (name && !seen[name]) {
            seen[name] = true;
            var opt = document.createElement('option');
            opt.value = name;
            opt.textContent = name;
            select.appendChild(opt);
        }
    });
}

function applyFilters() {
    var destination  = document.getElementById('filter-destination').value.trim().toLowerCase();
    var minPrice = parseFloat(document.getElementById('filter-price-min').value)  || 0;
    var maxPrice = parseFloat(document.getElementById('filter-price-max').value)  || Infinity;
    var minDuration  = parseInt(document.getElementById('filter-duration-min').value) || 0;
    var maxDuration  = parseInt(document.getElementById('filter-duration-max').value) || Infinity;
    var minRating = parseFloat(document.getElementById('filter-rating').value)     || 0;
    var groupOnly = document.getElementById('filter-group-trips').checked;
    var agencyFilter = document.getElementById('filter-agency').value;
    var sort = document.getElementById('sort-by').value;

    var filtered = allPackages.filter(function (pkg) {
        if (destination) {
            var haystack = [
                (pkg.Name || '').toLowerCase(),
                (pkg.Description || '').toLowerCase(),
                (pkg.Agency_Name || '').toLowerCase()
            ].join(' ');
            if (!haystack.includes(destination)) return false;
        }
        if (parseFloat(pkg.Price) < minPrice) return false;
        if (parseFloat(pkg.Price) > maxPrice) return false;
        if (parseInt(pkg.Duration) < minDuration) return false;
        if (parseInt(pkg.Duration) > maxDuration) return false;
        if (parseFloat(pkg.AvgRating || 0) < minRating) return false;
        if (groupOnly && !pkg.Is_Group_Trip) return false;
        if (agencyFilter && (pkg.Agency_Name || pkg.AgencyName) !== agencyFilter) return false;
        return true;
    });

    filtered.sort(function (a, b) {
        switch (sort) {
            case 'price_asc':    return parseFloat(a.Price)          - parseFloat(b.Price);
            case 'price_desc':   return parseFloat(b.Price)          - parseFloat(a.Price);
            case 'rating_desc':  return parseFloat(b.AvgRating || 0) - parseFloat(a.AvgRating || 0);
            case 'duration_asc': return parseInt(a.Duration)         - parseInt(b.Duration);
            case 'duration_desc':return parseInt(b.Duration)         - parseInt(a.Duration);
            default: return 0;
        }
    });

    var noEl = document.getElementById('no-results');
    var countEl = document.getElementById('results-count');

    if (!filtered.length) {
        document.getElementById('packages-container').innerHTML = '';
        noEl.style.display  = 'block';
        countEl.textContent = '0 packages found';
        return;
    }

    noEl.style.display  = 'none';
    countEl.textContent = filtered.length + ' package(s) found';
    displayPackages(filtered);
}

function displayPackages(packages) {
    document.getElementById('packages-container').innerHTML = packages.map(function (pkg) {
        return buildPackageCard(pkg, { showCompare: false });
    }).join('');
}