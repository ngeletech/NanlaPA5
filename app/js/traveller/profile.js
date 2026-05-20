// profile.js - Traveller profile and dashboard
document.addEventListener('DOMContentLoaded', function() {
    loadTravellerProfile();
    loadRecentBookings();
    loadRecommendedPackages();
    
    // Set greeting with time of day
    setGreeting();
});

function setGreeting() {
    var greetingEl = document.getElementById('greeting');
    if (!greetingEl) return;
    
    var hour = new Date().getHours();
    var userName = localStorage.getItem('userName') || 'Traveller';
    var greeting = '';
    
    if (hour < 12) {
        greeting = 'Good morning, ' + userName;
    } else if (hour < 18) {
        greeting = 'Good afternoon, ' + userName;
    } else {
        greeting = 'Good evening, ' + userName;
    }
    
    greetingEl.textContent = greeting;
}

function loadTravellerProfile() {
    var container = document.getElementById('profile-container');
    if (!container) return;
    
    container.innerHTML = '<div class="loading">Loading profile...</div>';
    
    makeRequest({ type: 'GetTravellerProfile' }, function(result) {
        if (result.status === 'success' && result.data) {
            displayProfileForm(result.data);
        } else {
            container.innerHTML = '<div class="error">Failed to load profile: ' + (result.data || 'Unknown error') + '</div>';
        }
    });
}

function displayProfileForm(profile) {
    var container = document.getElementById('profile-container');
    if (!container) return;
    
    var html = '<form id="profileForm" class="profile-form">'
        + '<div class="form-group">'
        + '<label for="name">Name</label>'
        + '<input type="text" id="name" name="name" value="' + escHtml(profile.Name || '') + '" class="form-control">'
        + '<span class="field-error" id="name-error"></span>'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="surname">Surname</label>'
        + '<input type="text" id="surname" name="surname" value="' + escHtml(profile.Surname || '') + '" class="form-control">'
        + '<span class="field-error" id="surname-error"></span>'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="email">Email</label>'
        + '<input type="email" id="email" name="email" value="' + escHtml(profile.Email || '') + '" class="form-control" readonly>'
        + '<small class="form-text">Email cannot be changed</small>'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="phone">Phone Number</label>'
        + '<input type="tel" id="phone" name="phone" value="' + escHtml(profile.Phone || '') + '" class="form-control">'
        + '</div>'
        + '<div class="form-actions">'
        + '<button type="submit" class="btn-primary">Save Changes</button>'
        + '</div>'
        + '</form>';
    
    container.innerHTML = html;
    
    // Attach form submit handler
    var form = document.getElementById('profileForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            updateTravellerProfile();
        });
    }
}

function updateTravellerProfile() {
    var name = document.getElementById('name').value.trim();
    var surname = document.getElementById('surname').value.trim();
    var phone = document.getElementById('phone').value.trim();
    var isValid = true;
    
    // Clear previous errors
    document.getElementById('name-error').innerText = '';
    document.getElementById('surname-error').innerText = '';
    
    if (!name) {
        document.getElementById('name-error').innerText = 'Name is required';
        isValid = false;
    }
    
    if (!surname) {
        document.getElementById('surname-error').innerText = 'Surname is required';
        isValid = false;
    }
    
    if (!isValid) return;
    
    var submitBtn = document.querySelector('#profileForm button[type="submit"]');
    submitBtn.disabled = true;
    submitBtn.textContent = 'Saving...';
    
    makeRequest({
        type: 'UpdateTravellerProfile',
        name: name,
        surname: surname,
        phone: phone
    }, function(result) {
        if (result.status === 'success') {
            showSuccess('Profile updated successfully!');
            localStorage.setItem('userName', name + ' ' + surname);
            setGreeting();
        } else {
            showError('Failed to update: ' + (result.data || 'Unknown error'));
        }
        submitBtn.disabled = false;
        submitBtn.textContent = 'Save Changes';
    });
}

function loadRecentBookings() {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;
    
    makeRequest({ type: 'GetRecentBookings', limit: 5 }, function(result) {
        if (result.status === 'success' && result.data && result.data.length > 0) {
            displayRecentBookings(result.data);
        } else {
            container.innerHTML = '<div class="empty-state">No recent bookings. <a href="/NanlaPA5/app/traveller/browse.php">Browse packages →</a></div>';
        }
    });
}

function displayRecentBookings(bookings) {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;
    
    var html = '<div class="bookings-list">';
    
    for (var i = 0; i < bookings.length; i++) {
        var b = bookings[i];
        var statusClass = '';
        var statusText = '';
        
        if (b.Status === 'confirmed') {
            statusClass = 'status-confirmed';
            statusText = 'Confirmed';
        } else if (b.Status === 'pending') {
            statusClass = 'status-pending';
            statusText = 'Pending';
        } else {
            statusClass = 'status-cancelled';
            statusText = 'Cancelled';
        }
        
        html += '<div class="booking-item">'
            + '<div class="booking-info">'
            + '<div class="booking-name">' + escHtml(b.PackageName) + '</div>'
            + '<div class="booking-details">'
            + '<span>📅 ' + b.TravelDate + '</span>'
            + '<span>👥 ' + b.NumTravellers + ' travellers</span>'
            + '</div>'
            + '</div>'
            + '<div class="booking-status">'
            + '<span class="status-badge ' + statusClass + '">' + statusText + '</span>'
            + '<a href="/NanlaPA5/app/traveller/package-details.php?id=' + b.PackageID + '" class="btn-sm">View</a>'
            + '</div>'
            + '</div>';
    }
    
    html += '</div>';
    container.innerHTML = html;
    
    // Update stats
    document.getElementById('stat-bookings').textContent = bookings.length;
    var upcoming = bookings.filter(function(b) { return b.TravelDate >= new Date().toISOString().split('T')[0]; }).length;
    document.getElementById('stat-upcoming').textContent = upcoming;
}

function loadRecommendedPackages() {
    var container = document.getElementById('featured-packages-container');
    if (!container) return;
    
    makeRequest({ type: 'GetRecommendedPackages', limit: 3 }, function(result) {
        if (result.status === 'success' && result.data && result.data.length > 0) {
            displayRecommendedPackages(result.data);
        } else {
            container.innerHTML = '<div class="empty-state">No recommendations yet. Start browsing!</div>';
        }
    });
}

function displayRecommendedPackages(packages) {
    var container = document.getElementById('featured-packages-container');
    if (!container) return;
    
    var html = '<div class="pkg-grid featured-grid">';
    
    for (var i = 0; i < packages.length; i++) {
        var p = packages[i];
        var rating = parseFloat(p.AvgRating || 0).toFixed(1);
        var price = parseFloat(p.Price || 0).toLocaleString('en-ZA');
        
        html += '<div class="pkg-card featured-card">'
            + '<div class="pkg-body">'
            + '<div class="pkg-agency">' + escHtml(p.AgencyName) + '</div>'
            + '<h4 class="pkg-name">' + escHtml(p.Name) + '</h4>'
            + '<div class="pkg-footer">'
            + '<div class="pkg-price">R' + price + '</div>'
            + '<div class="pkg-rating">★ ' + rating + '</div>'
            + '</div>'
            + '<a href="/NanlaPA5/app/traveller/package-details.php?id=' + p.PackageID + '" class="btn-primary btn-block btn-sm">View</a>'
            + '</div>'
            + '</div>';
    }
    
    html += '</div>';
    container.innerHTML = html;
}

function showSuccess(message) {
    var successDiv = document.getElementById('profile-success');
    if (successDiv) {
        successDiv.innerHTML = '<div class="success-banner">' + message + '</div>';
        successDiv.style.display = 'block';
        setTimeout(function() {
            successDiv.style.display = 'none';
        }, 3000);
    }
}

function showError(message) {
    var errorDiv = document.getElementById('profile-error');
    if (errorDiv) {
        errorDiv.innerHTML = '<div class="error-banner">' + message + '</div>';
        errorDiv.style.display = 'block';
        setTimeout(function() {
            errorDiv.style.display = 'none';
        }, 3000);
    }
}