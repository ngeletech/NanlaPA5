let allTrips = [];

document.addEventListener('DOMContentLoaded', function () {
    loadStats();
    loadGroupTrips();

    document.getElementById('search-trips').addEventListener('input',         renderTrips);
    document.getElementById('filter-trip-status').addEventListener('change',  renderTrips);

    document.getElementById('participants-modal').addEventListener('click', function (e) {
        if (e.target === this) closeParticipantsModal();
    });
});

function loadStats() {
    fetch('/api/packages.php?action=group_trip_stats')
        .then(res => res.json())
        .then(data => {
            if (!data.success) return;
            document.getElementById('stat-total-trips').textContent        = data.total        ?? '—';
            document.getElementById('stat-open-trips').textContent         = data.open         ?? '—';
            document.getElementById('stat-total-participants').textContent  = data.participants ?? '—';
        })
        .catch(() => {});
}

function loadGroupTrips() {
    fetch('/api/packages.php?action=group_trips')
        .then(res => res.json())
        .then(data => {
            if (!data.success || !data.trips.length) {
                showEmpty();
                return;
            }
            allTrips = data.trips;
            renderTrips();
        })
        .catch(() => showEmpty());
}

function renderTrips() {
    const search = document.getElementById('search-trips').value.toLowerCase();
    const status = document.getElementById('filter-trip-status').value;

    const filtered = allTrips.filter(t => {
        const matchSearch = !search || t.package_name.toLowerCase().includes(search);
        const matchStatus = !status || t.trip_status === status;
        return matchSearch && matchStatus;
    });

    const container = document.getElementById('group-trips-container');
    const emptyEl   = document.getElementById('no-trips');

    if (!filtered.length) {
        container.innerHTML   = allTrips.length
            ? '<p class="t-loading" style="padding:2rem">No trips match your search.</p>'
            : '';
        emptyEl.style.display = allTrips.length ? 'none' : 'block';
        return;
    }

    emptyEl.style.display = 'none';
    container.innerHTML = `
        <table class="a-table">
            <thead>
                <tr>
                    <th>Package</th>
                    <th>Trip date</th>
                    <th>Participants</th>
                    <th>Max</th>
                    <th>Spots left</th>
                    <th>Status</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                ${filtered.map(buildTripRow).join('')}
            </tbody>
        </table>
    `;
}

function buildTripRow(trip) {
    const spotsLeft   = trip.max_participants - trip.participant_count;
    const statusClass = {
        open:   'a-badge-active',
        full:   'a-badge-draft',
        closed: 'a-badge-inactive'
    }[trip.trip_status] || 'a-badge-inactive';

    return `
        <tr>
            <td><span class="a-pkg-name">${escHtml(trip.package_name)}</span></td>
            <td>${escHtml(trip.group_trip_date || '—')}</td>
            <td>${trip.participant_count}</td>
            <td>${trip.max_participants}</td>
            <td>${spotsLeft > 0 ? spotsLeft : '<span style="color:var(--error)">Full</span>'}</td>
            <td><span class="a-badge ${statusClass}">${escHtml(trip.trip_status)}</span></td>
            <td>
                <button class="a-btn-icon"
                        onclick="openParticipantsModal(${trip.group_id}, '${escHtml(trip.package_name)}')">
                    View participants
                </button>
            </td>
        </tr>
    `;
}

function openParticipantsModal(groupId, packageName) {
    document.getElementById('participants-modal-title').textContent =
        'Participants — ' + packageName;
    document.getElementById('participants-list').innerHTML =
        '<div class="t-loading">Loading...</div>';
    document.getElementById('participants-modal').style.display = 'flex';

    fetch('/api/packages.php?action=group_participants&group_id=' + encodeURIComponent(groupId))
        .then(res => res.json())
        .then(data => {
            const list = document.getElementById('participants-list');
            if (!data.success || !data.participants.length) {
                list.innerHTML = '<p style="color:var(--text-muted); font-size:0.875rem">No participants yet.</p>';
                return;
            }
            list.innerHTML = data.participants.map(p => `
                <div class="t-booking-item" style="padding:0.75rem 1rem; margin-bottom:0.5rem">
                    <div>
                        <strong style="font-size:0.875rem">${escHtml(p.first_name + ' ' + p.last_name)}</strong>
                        <p style="font-size:0.78rem; color:var(--text-muted)">${escHtml(p.email)}</p>
                    </div>
                    <span style="font-size:0.78rem; color:var(--text-muted)">${escHtml(p.join_date)}</span>
                </div>
            `).join('');
        })
        .catch(() => {
            document.getElementById('participants-list').innerHTML =
                '<p style="color:var(--error); font-size:0.875rem">Could not load participants.</p>';
        });
}

function closeParticipantsModal() {
    document.getElementById('participants-modal').style.display = 'none';
}

function showEmpty() {
    document.getElementById('group-trips-container').innerHTML = '';
    document.getElementById('no-trips').style.display          = 'block';
}