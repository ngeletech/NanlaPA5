// packages.js - Agency view their packages
document.addEventListener('DOMContentLoaded', function() {
    loadAgencyPackages();
    
    var searchInput = document.getElementById('search-packages');
    if (searchInput) {
        searchInput.addEventListener('keyup', filterPackages);
    }
    
    var filterStatus = document.getElementById('filter-status');
    if (filterStatus) {
        filterStatus.addEventListener('change', filterPackages);
    }
    
    var sortSelect = document.getElementById('sort-packages');
    if (sortSelect) {
        sortSelect.addEventListener('change', sortPackages);
    }
});

var allPackages = [];

function loadAgencyPackages() {
    var container = document.getElementById('packages-table-wrapper');
    if (!container) return;
    
    container.innerHTML = '<div class="loading">Loading your packages...</div>';
    
    makeRequest({ type: 'GetAgencyPackages' }, function(result) {
        if (result.status === 'success' && result.data) {
            allPackages = result.data;
            displayPackagesTable(allPackages);
            
            // Update stats
            var statTotal = document.getElementById('stat-total');
            var statBookings = document.getElementById('stat-bookings');
            var statRating = document.getElementById('stat-rating');
            
            if (statTotal) statTotal.textContent = allPackages.length;
            
            var totalBookings = 0;
            for (var i = 0; i < allPackages.length; i++) {
                totalBookings += parseInt(allPackages[i].BookingCount) || 0;
            }
            if (statBookings) statBookings.textContent = totalBookings;
            
            var totalRating = 0;
            var ratedCount = 0;
            for (var i = 0; i < allPackages.length; i++) {
                if (allPackages[i].AvgRating > 0) {
                    totalRating += parseFloat(allPackages[i].AvgRating);
                    ratedCount++;
                }
            }
            var avgRating = ratedCount > 0 ? (totalRating / ratedCount).toFixed(1) : 'N/A';
            if (statRating) statRating.textContent = avgRating;
            
        } else if (result.status === 'success' && (!result.data || !result.data.length)) {
            container.innerHTML = '';
            var noPackages = document.getElementById('no-packages');
            if (noPackages) noPackages.style.display = 'block';
        } else {
            container.innerHTML = '<div class="error">Failed to load packages: ' + (result.data || 'Unknown error') + '</div>';
        }
    });
}

function displayPackagesTable(packages) {
    var container = document.getElementById('packages-table-wrapper');
    var noPackages = document.getElementById('no-packages');
    
    if (!container) return;
    
    if (!packages || packages.length === 0) {
        container.innerHTML = '';
        if (noPackages) noPackages.style.display = 'block';
        return;
    }
    
    if (noPackages) noPackages.style.display = 'none';
    
    var html = '<table class="data-table">';
    html += '<thead><tr>';
    html += '<th>Package Name</th>';
    html += '<th>Price</th>';
    html += '<th>Duration</th>';
    html += '<th>Status</th>';
    html += '<th>Bookings</th>';
    html += '<th>Rating</th>';
    html += '<th>Actions</th>';
    html += '</tr></thead><tbody>';
    
    for (var i = 0; i < packages.length; i++) {
        var pkg = packages[i];
        
        // Calculate duration from dates
        var start = new Date(pkg.Start_Date);
        var end = new Date(pkg.End_Date);
        var duration = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
        
        // Status - default to Active since table doesn't have status
        var statusText = 'Active';
        var statusClass = 'status-active';
        
        // Format price
        var price = parseFloat(pkg.Price || 0).toLocaleString('en-ZA');
        
        // Group trip icon - API returns Offers_Group_Trip
        var groupIcon = (pkg.Offers_Group_Trip == 1) ? '👥 ' : '';
        
        // Rating
        var rating = parseFloat(pkg.AvgRating || 0).toFixed(1);
        
        // Bookings
        var bookings = pkg.BookingCount || 0;
        
        html += '<tr>';
        html += '<td><strong>' + groupIcon + escHtml(pkg.Name) + '</strong></td>';
        html += '<td>R' + price + '</td>';
        html += '<td>' + duration + ' days<\/span></td>';
        html += '<td><span class="status-badge ' + statusClass + '">' + statusText + '</span></td>';
        html += '<td>' + bookings + '</td>';
        html += '<td>★ ' + rating + '</td>';
        html += '<td>';
        html += '<a href="/NanlaPA5/app/travel-agency/package-edit.php?id=' + pkg.PackageID + '" class="btn-sm">Edit</a> ';
        html += '<button onclick="deletePackage(' + pkg.PackageID + ', \'' + escHtml(pkg.Name) + '\')" class="btn-sm btn-danger">Delete</button>';
        html += '</td>';
        html += '</tr>';
    }
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

function filterPackages() {
    var searchTerm = document.getElementById('search-packages') ? 
        document.getElementById('search-packages').value.toLowerCase() : '';
    var statusFilter = document.getElementById('filter-status') ? 
        document.getElementById('filter-status').value : '';
    
    var filtered = allPackages.filter(function(pkg) {
        var matchesSearch = searchTerm === '' || 
            pkg.Name.toLowerCase().includes(searchTerm);
        // Status filter - since all packages are "Active", this will show all
        var matchesStatus = statusFilter === '' || statusFilter === 'active';
        return matchesSearch && matchesStatus;
    });
    
    displayPackagesTable(filtered);
}

function sortPackages() {
    var sortBy = document.getElementById('sort-packages') ? 
        document.getElementById('sort-packages').value : 'newest';
    
    var sorted = allPackages.slice();
    
    if (sortBy === 'price_asc') {
        sorted.sort(function(a, b) { return parseFloat(a.Price || 0) - parseFloat(b.Price || 0); });
    } else if (sortBy === 'price_desc') {
        sorted.sort(function(a, b) { return parseFloat(b.Price || 0) - parseFloat(a.Price || 0); });
    } else if (sortBy === 'rating_desc') {
        sorted.sort(function(a, b) { return parseFloat(b.AvgRating || 0) - parseFloat(a.AvgRating || 0); });
    } else if (sortBy === 'newest') {
        // No CreatedDate, so sort by PackageID
        sorted.sort(function(a, b) { return (b.PackageID || 0) - (a.PackageID || 0); });
    } else if (sortBy === 'oldest') {
        sorted.sort(function(a, b) { return (a.PackageID || 0) - (b.PackageID || 0); });
    }
    
    displayPackagesTable(sorted);
}

function deletePackage(packageId, packageName) {
    if (confirm('Are you sure you want to delete "' + packageName + '"? This cannot be undone.')) {
        makeRequest({ type: 'DeletePackage', package_id: packageId }, function(result) {
            if (result.status === 'success') {
                alert('Package deleted successfully');
                loadAgencyPackages();
            } else {
                alert('Failed to delete: ' + (result.data || 'Unknown error'));
            }
        });
    }
}