//used on all pages

//API Request

function makeRequest(data, callback) {
    var xhr = new XMLHttpRequest();
    var apiUrl = '/NanlaPA5/app/api.php';

    xhr.open('POST', apiUrl, true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                try {
                    var result = JSON.parse(xhr.responseText);
                    callback(result);
                } catch (e) {
                    callback({ status: 'error', data: 'Invalid server response' });
                }
            } else {
                callback({ status: 'error', data: 'Server error: ' + xhr.status });
            }
        }
    };

    xhr.send(JSON.stringify(data));
}

//HTML Escaping

function escHtml(str) {
    if (!str) return '';
    var div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
}

//Form Errors

function clearErrors() {
    document.querySelectorAll('.error-message, .field-error').forEach(function(el) {
        el.innerText = '';
        el.style.display = 'none';
    });
    var jsError = document.getElementById('js-error');
    if (jsError) jsError.style.display = 'none';
}

function showFieldError(fieldId, message) {
    var errorEl = document.getElementById(fieldId + '-error');
    if (errorEl) {
        errorEl.textContent = message;
        errorEl.style.display = 'block';
    }
    var input = document.getElementById(fieldId) ||
                document.querySelector('[name="' + fieldId + '"]');
    if (input) input.classList.add('input-error');
}

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());
}

// Banners

function showBanner(elementId, message, type) {
    var el = document.getElementById(elementId);
    if (!el) return;
    el.textContent  = message;
    el.style.display = 'block';
    el.classList.remove('error-banner', 'success-banner');
    el.classList.add(type === 'success' ? 'success-banner' : 'error-banner');
}

function hideBanner(elementId) {
    var el = document.getElementById(elementId);
    if (el) el.style.display = 'none';
}

//Button Loading State

function setButtonLoading(btnOrId, loadingText) {
    var btn = typeof btnOrId === 'string'
        ? document.getElementById(btnOrId)
        : btnOrId;
    if (!btn) return;
    var textEl   = btn.querySelector('.btn-text');
    var loaderEl = btn.querySelector('.btn-loader');
    if (textEl)   textEl.style.display   = 'none';
    if (loaderEl) {
        loaderEl.textContent  = loadingText || 'Loading...';
        loaderEl.style.display = 'inline';
    }
    btn.disabled = true;
}

function resetButton(btnOrId) {
    var btn = typeof btnOrId === 'string'
        ? document.getElementById(btnOrId)
        : btnOrId;
    if (!btn) return;
    var textEl   = btn.querySelector('.btn-text');
    var loaderEl = btn.querySelector('.btn-loader');
    if (textEl)   textEl.style.display   = 'inline';
    if (loaderEl) loaderEl.style.display = 'none';
    btn.disabled = false;
}

//Password Toggle

function togglePassword(inputId, btn) {
    var input = document.getElementById(inputId);
    if (!input) return;
    if (input.type === 'password') {
        input.type        = 'text';
        btn.style.opacity = '1';
    } else {
        input.type        = 'password';
        btn.style.opacity = '0.5';
    }
}

//Package Card Builder

function buildPackageCard(pkg, options) {
    options = options || {};
    var showCompare = options.showCompare !== false;
    var compareSelected = options.compareSelected || false;
    var compareDisabled = options.compareDisabled || false;

    var packageName = escHtml(pkg.package_name || pkg.Name || pkg.name || '');
    var packageId = pkg.package_id || pkg.PackageID;
    var destination = escHtml(pkg.destination || 'Various destinations');
    var price = Number(pkg.price || pkg.Price || 0).toLocaleString();
    var duration = pkg.duration || pkg.Duration || '—';
    var rating = Number(pkg.avg_rating || pkg.AvgRating || 0).toFixed(1);
    var agencyName  = escHtml(pkg.AgencyName  || pkg.Agency_Name || pkg.agency_name || '');

    var compareCheckbox = showCompare ? (
        '<label class="compare-checkbox-label">' +
            '<input type="checkbox" class="compare-checkbox"' +
            ' value="' + packageId + '"' +
            ' data-package=\'' + JSON.stringify(pkg).replace(/'/g, "&#39;") + '\'' +
            (compareSelected ? ' checked'  : '') +
            (compareDisabled ? ' disabled' : '') + '>' +
            ' Compare' +
        '</label>'
    ) : '';

    return (
        '<div class="pkg-card" data-id="' + packageId + '">' +
            '<div class="pkg-card-body">' +
                '<div class="pkg-agency">'  + agencyName  + '</div>' +
                '<div class="pkg-name">'    + packageName + '</div>' +
                '<div class="pkg-meta">' +
                    '<span> ' + duration    + ' days</span>' +
                    '<span> ' + destination + '</span>' +
                '</div>' +
                '<div class="pkg-footer">' +
                    '<div class="pkg-price">R' + price + '<small>/ person</small></div>' +
                    '<div class="pkg-rating">★ ' + rating + '</div>' +
                '</div>' +
            '</div>' +
            '<div class="pkg-card-actions">' +
                '<a href="/NanlaPA5/app/traveller/package-details.php?id=' + packageId + '"' +
                   ' class="btn-outline full-width">View details</a>' +
                compareCheckbox +
            '</div>' +
        '</div>'
    );
}

