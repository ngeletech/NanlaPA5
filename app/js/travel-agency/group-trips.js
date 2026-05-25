// group-trips.js - Agency manage group trips

var allTrips = [];

document.addEventListener('DOMContentLoaded', function () {
    loadGroupTrips();
    loadPackagesDropdown();
    loadTravellersDropdown();

    var searchInput = document.getElementById('search-trips');
    if (searchInput) {
        searchInput.addEventListener('keyup', filterTrips);
    }

    var statusFilter = document.getElementById('filter-trip-status');
    if (statusFilter) {
        statusFilter.addEventListener('change', filterTrips);
    }
});

// ── Load group trips ──────────────────────────────────────────

function loadGroupTrips() {
    var container = document.getElementById('group-trips-container');
    if (!container) return;

    container.innerHTML = '<div class="loading">Loading group trips...</div>';

    makeRequest({ type: 'GetAgencyGroupTrips' }, function (result) {
        if (result.status === 'success' && result.data && result.data.length) {
            allTrips = result.data;
            updateStats(allTrips);
            renderTripsTable(allTrips);
        } else {
            container.innerHTML = '';
            var noTrips = document.getElementById('no-trips');
            if (noTrips) noTrips.style.display = 'block';
            updateStats([]);
        }
    });
}

function loadPackagesDropdown() {
    var select = document.getElementById('gt-package-select');
    if (!select) return;

    makeRequest({ type: 'GetAgencyPackages' }, function (result) {
        if (result.status !== 'success' || !result.data) return;

        select.innerHTML = '<option value="">Select a package...</option>';
        for (var i = 0; i < result.data.length; i++) {
            var pkg = result.data[i];
            var option = document.createElement('option');
            option.value = pkg.PackageID;
            option.textContent = pkg.Name;
            select.appendChild(option);
        }
    });
}

function loadTravellersDropdown() {
    var select = document.getElementById('gt-traveller');
    if (!select) return;

    makeRequest({ type: 'GetAllTravellers' }, function (result) {
        if (result.status !== 'success' || !result.data) return;

        select.innerHTML = '<option value="">Select a traveller...</option>';
        for (var i = 0; i < result.data.length; i++) {
            var traveller = result.data[i];
            var option = document.createElement('option');
            option.value = traveller.UserID;
            option.textContent = traveller.First_Name + ' ' + traveller.Last_Name;
            select.appendChild(option);
        }
    });
}

// ── Update stats ──────────────────────────────────────────────

function updateStats(trips) {
    var totalEl = document.getElementById('stat-total-trips');
    var openEl = document.getElementById('stat-open-trips');
    var participantsEl = document.getElementById('stat-total-participants');

    if (totalEl) totalEl.textContent = trips.length;

    var openCount = 0;
    for (var i = 0; i < trips.length; i++) {
        if (trips[i].Status === 'open') openCount++;
    }
    if (openEl) openEl.textContent = openCount;

    var totalParticipants = 0;
    for (var i = 0; i < trips.length; i++) {
        totalParticipants += parseInt(trips[i].ParticipantCount) || 1;
    }
    if (participantsEl) participantsEl.textContent = totalParticipants;
}

// ── Render table ──────────────────────────────────────────────

function renderTripsTable(trips) {
    var container = document.getElementById('group-trips-container');
    var noTrips = document.getElementById('no-trips');

    if (!container) return;

    if (!trips || !trips.length) {
        container.innerHTML = '';
        if (noTrips) noTrips.style.display = 'block';
        return;
    }

    if (noTrips) noTrips.style.display = 'none';

    var html = '<table class="data-table">' +
        '<thead>' +
        '<tr>' +
        '<th>Group ID</th>' +
        '<th>Package</th>' +
        '<th>Traveller</th>' +
        '<th>Status</th>' +
        '<th>Actions</th>' +
        '</tr>' +
        '</thead><tbody>';

    for (var i = 0; i < trips.length; i++) {
        var trip = trips[i];
        var statusClass = 'status-' + (trip.Status || 'open').toLowerCase();

        html += '<tr>' +
            '<td>#' + trip.GroupID + '</td>' +
            '<td>' + escHtml(trip.PackageName || '—') + '</td>' +
            '<td>' + escHtml(trip.TravellerName || '—') + '</td>' +
            '<td><span class="status-badge ' + statusClass + '">' + escHtml(trip.Status || 'Open') + '</span></td>' +
            '<td>' +
            '<button class="btn-outline" style="font-size:12px; padding:5px 10px;" onclick="editGroupTrip(' + trip.GroupID + ', ' + trip.PackageID + ', ' + trip.TravellerID + ')">Edit</button> ' +
            '<button class="btn-danger" style="font-size:12px; padding:5px 10px;" onclick="deleteGroupTrip(' + trip.GroupID + ')">Delete</button>' +
            '</td>' +
        '</tr>';
    }

    html += '</tbody></table>';
    container.innerHTML = html;
}

// ── Filter ────────────────────────────────────────────────────

function filterTrips() {
    var search = document.getElementById('search-trips') ?
        document.getElementById('search-trips').value.toLowerCase() : '';
    var status = document.getElementById('filter-trip-status') ?
        document.getElementById('filter-trip-status').value : '';

    var filtered = [];
    for (var i = 0; i < allTrips.length; i++) {
        var trip = allTrips[i];
        var matchesSearch = search === '' ||
            (trip.PackageName && trip.PackageName.toLowerCase().indexOf(search) !== -1);
        var matchesStatus = status === '' || (trip.Status || 'open').toLowerCase() === status;
        if (matchesSearch && matchesStatus) {
            filtered.push(trip);
        }
    }

    renderTripsTable(filtered);
}

// ── Modal functions ───────────────────────────────────────────

var editingGroupId = null;

function openCreateModal() {
    editingGroupId = null;
    document.getElementById('gt-modal-title').textContent = 'Create group trip';
    document.getElementById('gt-package-select').value = '';
    document.getElementById('gt-traveller').value = '';
    document.getElementById('gt-modal').style.display = 'flex';
}

function editGroupTrip(groupId, packageId, travellerId) {
    editingGroupId = groupId;
    document.getElementById('gt-modal-title').textContent = 'Edit group trip';
    document.getElementById('gt-package-select').value = packageId;
    document.getElementById('gt-traveller').value = travellerId;
    document.getElementById('gt-modal').style.display = 'flex';
}

function closeGroupTripModal() {
    var modal = document.getElementById('gt-modal');
    if (modal) modal.style.display = 'none';
    editingGroupId = null;
}

function saveGroupTrip() {
    var packageId = document.getElementById('gt-package-select').value;
    var travellerId = document.getElementById('gt-traveller').value;

    if (!packageId) { alert('Please select a package'); return; }
    if (!travellerId) { alert('Please select a traveller'); return; }

    var requestData = {
        type: editingGroupId ? 'UpdateGroupTrip' : 'CreateGroupTrip',
        group_trip_id: editingGroupId,
        package_id: parseInt(packageId),
        traveller_id: parseInt(travellerId)
    };

    makeRequest(requestData, function (result) {
        if (result.status === 'success') {
            closeGroupTripModal();
            var successDiv = document.getElementById('gt-success');
            if (successDiv) {
                successDiv.textContent = editingGroupId ? 'Group trip updated successfully.' : 'Group trip created successfully.';
                successDiv.style.display = 'block';
                setTimeout(function() {
                    successDiv.style.display = 'none';
                }, 3000);
            }
            loadGroupTrips();
        } else {
            var errorDiv = document.getElementById('gt-error');
            if (errorDiv) {
                errorDiv.textContent = result.data || 'Failed to save group trip.';
                errorDiv.style.display = 'block';
                setTimeout(function() {
                    errorDiv.style.display = 'none';
                }, 3000);
            }
        }
    });
}

function deleteGroupTrip(groupId) {
    if (!confirm('Are you sure you want to delete this group trip? This cannot be undone.')) return;

    makeRequest({ type: 'DeleteGroupTrip', group_trip_id: groupId }, function (result) {
        if (result.status === 'success') {
            var successDiv = document.getElementById('gt-success');
            if (successDiv) {
                successDiv.textContent = 'Group trip deleted.';
                successDiv.style.display = 'block';
                setTimeout(function() {
                    successDiv.style.display = 'none';
                }, 3000);
            }
            loadGroupTrips();
        } else {
            var errorDiv = document.getElementById('gt-error');
            if (errorDiv) {
                errorDiv.textContent = result.data || 'Failed to delete.';
                errorDiv.style.display = 'block';
                setTimeout(function() {
                    errorDiv.style.display = 'none';
                }, 3000);
            }
        }
    });
}