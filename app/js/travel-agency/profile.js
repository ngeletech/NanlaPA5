// profile.js - Agency profile and dashboard
document.addEventListener('DOMContentLoaded', function() {
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

function loadAgencyProfile() {
    var container = document.getElementById('profile-container');
    if (!container) return;
    
    container.innerHTML = '<div class="loading">Loading profile...</div>';
    
    makeRequest({ type: 'GetAgencyProfile' }, function(result) {
        if (result.status === 'success' && result.data) {
            displayAgencyProfile(result.data);
        } else {
            container.innerHTML = '<div class="error">Failed to load profile</div>';
        }
    });
}

function displayAgencyProfile(profile) {
    var container = document.getElementById('profile-container');
    if (!container) return;
    
    var nameValue = profile.Name || '';
    var regValue = profile.Registration_Number || '';
    var emailValue = profile.Email || '';
    var phoneValue = profile.Phone || '';
    var descValue = profile.Description || '';
    
    var html = '<form id="profileForm" class="profile-form">'
        + '<div class="form-group">'
        + '<label for="name">Agency Name</label>'
        + '<input type="text" id="name" name="name" value="' + escHtml(nameValue) + '" class="form-control">'
        + '<span class="field-error" id="name-error"></span>'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="reg_number">Registration Number</label>'
        + '<input type="text" id="reg_number" name="reg_number" value="' + escHtml(regValue) + '" class="form-control" readonly>'
        + '<small class="form-text">Registration number cannot be changed</small>'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="email">Email</label>'
        + '<input type="email" id="email" name="email" value="' + escHtml(emailValue) + '" class="form-control" readonly>'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="phone">Phone Number</label>'
        + '<input type="tel" id="phone" name="phone" value="' + escHtml(phoneValue) + '" class="form-control">'
        + '</div>'
        + '<div class="form-group">'
        + '<label for="description">Agency Description</label>'
        + '<textarea id="description" name="description" rows="3" class="form-control">' + escHtml(descValue) + '</textarea>'
        + '</div>'
        + '<div class="form-actions">'
        + '<button type="submit" class="btn-primary">Save Changes</button>'
        + '</div>'
        + '</form>';
    
    container.innerHTML = html;
    
    var form = document.getElementById('profileForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            updateAgencyProfile();
        });
    }
}

function updateAgencyProfile() {
    var name = document.getElementById('name').value.trim();
    var phone = document.getElementById('phone').value.trim();
    var description = document.getElementById('description').value.trim();
    var isValid = true;
    
    var nameError = document.getElementById('name-error');
    if (nameError) nameError.innerText = '';
    
    if (!name) {
        if (nameError) nameError.innerText = 'Agency name is required';
        isValid = false;
    }
    
    if (!isValid) return;
    
    var submitBtn = document.querySelector('#profileForm button[type="submit"]');
    if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.textContent = 'Saving...';
    }
    
    makeRequest({
        type: 'UpdateAgencyProfile',
        name: name,
        phone: phone,
        description: description
    }, function(result) {
        if (result.status === 'success') {
            showSuccess('Profile updated successfully!');
            localStorage.setItem('userName', name);
            setAgencyGreeting();
        } else {
            showError('Failed to update: ' + (result.data || 'Unknown error'));
        }
        if (submitBtn) {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Save Changes';
        }
    });
}

function loadAgencyStats() {
    makeRequest({ type: 'GetAgencyStats' }, function(result) {
        if (result.status === 'success' && result.data) {
            var statPackages = document.getElementById('stat-packages');
            var statBookings = document.getElementById('stat-bookings');
            var statGroupTrips = document.getElementById('stat-group-trips');
            var statRating = document.getElementById('stat-rating');
            
            if (statPackages) statPackages.textContent = result.data.total_packages || 0;
            if (statBookings) statBookings.textContent = result.data.total_bookings || 0;
            if (statGroupTrips) statGroupTrips.textContent = result.data.total_group_trips || 0;
            
            var rating = parseFloat(result.data.avg_rating || 0).toFixed(1);
            if (statRating) statRating.textContent = rating + ' ★';
        }
    });
}

function loadRecentBookings() {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;
    
    makeRequest({ type: 'GetAgencyRecentBookings', limit: 5 }, function(result) {
        if (result.status === 'success' && result.data && result.data.length > 0) {
            displayAgencyRecentBookings(result.data);
        } else {
            container.innerHTML = '<div class="empty-state">No recent bookings yet.</div>';
        }
    });
}

function displayAgencyRecentBookings(bookings) {
    var container = document.getElementById('recent-bookings-container');
    if (!container) return;
    
    var html = '<table class="data-table">'
        + '<thead>'
        + '<tr>'
        + '<th>Package</th>'
        + '<th>Traveller</th>'
        + '<th>Date</th>'
        + '<th>Travellers</th>'
        + '<th>Total</th>'
        + '<th>Status</th>'
        + '</tr>'
        + '</thead><tbody>';
    
    for (var i = 0; i < bookings.length; i++) {
        var b = bookings[i];
        var total = parseFloat(b.TotalPrice || 0).toLocaleString('en-ZA');
        var statusClass = (b.Status === 'confirmed') ? 'status-confirmed' : 'status-pending';
        
        html += '<tr>'
            + '<td>' + escHtml(b.PackageName) + '</td>'
            + '<td>' + escHtml(b.TravellerName) + '</td>'
            + '<td>' + b.TravelDate + '</td>'
            + '<td>' + b.NumTravellers + '</td>'
            + '<td>R' + total + '</td>'
            + '<td><span class="status-badge ' + statusClass + '">' + b.Status + '</span></td>'
            + '</tr>';
    }
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

function loadPackagesPreview() {
    var container = document.getElementById('packages-preview-container');
    if (!container) return;
    
    makeRequest({ type: 'GetAgencyPackages', limit: 3 }, function(result) {
        if (result.status === 'success' && result.data && result.data.length > 0) {
            displayPackagesPreview(result.data);
        } else {
            container.innerHTML = '<div class="empty-state">No packages yet. <a href="/NanlaPA5/app/travel-agency/package-edit.php">Create your first package</a></div>';
        }
    });
}

function displayPackagesPreview(packages) {
    var container = document.getElementById('packages-preview-container');
    if (!container) return;
    
    var html = '<table class="data-table">'
        + '<thead>'
        + '<tr>'
        + '<th>Package Name</th>'
        + '<th>Price</th>'
        + '<th>Duration</th>'
        + '<th>Bookings</th>'
        + '<th></th>'
        + '</tr>'
        + '</thead><tbody>';
    
    for (var i = 0; i < packages.length; i++) {
        var p = packages[i];
        var price = parseFloat(p.Price || 0).toLocaleString('en-ZA');
        var groupIcon = p.Is_Group_Trip ? '👥 ' : '';
        
        html += '<tr>'
            + '<td>' + groupIcon + escHtml(p.Name) + '</td>'
            + '<td>R' + price + '</td>'
            + '<td>' + p.Duration + ' days</td>'
            + '<td>' + (p.BookingCount || 0) + '</td>'
            + '<td><a href="/NanlaPA5/app/travel-agency/package-edit.php?id=' + p.PackageID + '" class="btn-sm">Edit</a></td>'
            + '</tr>';
    }
    
    html += '</tbody></table>';
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