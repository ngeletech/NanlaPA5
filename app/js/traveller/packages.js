var allPackages = [];
var compareList = [];

document.addEventListener('DOMContentLoaded', function () {
    loadPackages();

    document.getElementById('sort-by').addEventListener('change', renderPackages);
    document.getElementById('compare-btn').addEventListener('click', showCompareView);
    document.getElementById('clear-compare').addEventListener('click', clearCompare);
    document.getElementById('back-to-browse').addEventListener('click', hideCompareView);
});

//Load packages
function loadPackages() {
    var container = document.getElementById('packages-container');
    var noResults = document.getElementById('no-results');
    var countEl   = document.getElementById('results-count');

    container.innerHTML = '<div class="loading">Loading packages...</div>';
    if (noResults) noResults.style.display = 'none';

    makeRequest({
        type:        'GetPackages',
        destination: '',
        min_price:   '',
        max_price:   '',
        group_only:  0,
        sort:        'price_asc'
    }, function (result) {
        if (!result || result.status !== 'success' || !result.data || !result.data.length) {
            container.innerHTML = '';
            if (noResults) noResults.style.display = 'block';
            if (countEl)   countEl.textContent      = '0 packages found';
            allPackages = [];
            return;
        }
        allPackages = result.data;
        if (countEl) countEl.textContent = allPackages.length + ' package(s) found';
        renderPackages();
    });
}

//Render packages

function renderPackages() {
    var container = document.getElementById('packages-container');
    var noResults = document.getElementById('no-results');
    if (!container) return;

    var sorted = sortPackages(allPackages.slice());

    if (!sorted.length) {
        container.innerHTML = '';
        if (noResults) noResults.style.display = 'block';
        return;
    }

    if (noResults) noResults.style.display = 'none';

    container.innerHTML = sorted.map(function (pkg) {
        return buildPackageCard(pkg, {
            showCompare:     true,
            compareSelected: compareList.some(function (p) {
                return p.PackageID === pkg.PackageID;
            }),
            compareDisabled: !compareList.some(function (p) {
                return p.PackageID === pkg.PackageID;
            }) && compareList.length >= 3
        });
    }).join('');

    // attach compare checkbox listeners
    document.querySelectorAll('.compare-checkbox').forEach(function (cb) {
        cb.addEventListener('change', function () {
            var pkg = JSON.parse(this.dataset.package.replace(/&#39;/g, "'"));
            toggleCompare(this, pkg);
        });
    });
}

//Sort

function sortPackages(list) {
    var sortBy = document.getElementById('sort-by').value || 'price_asc';
    return list.sort(function (a, b) {
        switch (sortBy) {
            case 'price_asc':    return (a.Price || 0) - (b.Price || 0);
            case 'price_desc':   return (b.Price || 0) - (a.Price || 0);
            case 'rating_desc':  return (b.AvgRating || 0) - (a.AvgRating || 0);
            case 'duration_asc': return (a.Duration || 0) - (b.Duration || 0);
            case 'duration_desc':return (b.Duration || 0) - (a.Duration || 0);
            default: return 0;
        }
    });
}

//Compare 

function toggleCompare(checkbox, pkg) {
    if (checkbox.checked) {
        if (compareList.length >= 3) {
            checkbox.checked = false;
            alert('You can compare up to 3 packages at a time');
            return;
        }
        compareList.push(pkg);
    } else {
        compareList = compareList.filter(function (p) {
            return p.PackageID !== pkg.PackageID;
        });
    }
    updateCompareTray();
    renderPackages();
}

function updateCompareTray() {
    var tray       = document.getElementById('compare-tray');
    var slots      = document.getElementById('compare-slots');
    var compareBtn = document.getElementById('compare-btn');
    var countSpan  = document.getElementById('compare-count');

    if (!tray) return;

    if (!compareList.length) {
        tray.style.display = 'none';
        return;
    }

    tray.style.display = 'block';
    if (countSpan)  countSpan.textContent = compareList.length + '/3 selected';
    if (compareBtn) compareBtn.disabled   = compareList.length < 2;

    if (!slots) return;

    var slotHTML = [];
    for (var i = 0; i < 3; i++) {
        var pkg = compareList[i];
        if (pkg) {
            slotHTML.push(
                '<div class="compare-slot filled">' +
                    '<span>' + escHtml(pkg.Name || pkg.package_name || '') + '</span>' +
                    '<button class="compare-slot-remove" data-id="' + pkg.PackageID + '">✕</button>' +
                '</div>'
            );
        } else {
            slotHTML.push('<div class="compare-slot">Empty slot</div>');
        }
    }
    slots.innerHTML = slotHTML.join('');

    document.querySelectorAll('.compare-slot-remove').forEach(function (btn) {
        btn.addEventListener('click', function () {
            removeFromCompare(parseInt(this.dataset.id));
        });
    });
}

function removeFromCompare(packageId) {
    compareList = compareList.filter(function (p) {
        return p.PackageID !== packageId;
    });
    updateCompareTray();
    renderPackages();
}

function clearCompare() {
    compareList = [];
    updateCompareTray();
    renderPackages();
}

function showCompareView() {
    document.getElementById('packages-view').style.display  = 'none';
    document.getElementById('compare-view').style.display   = 'block';
    document.getElementById('compare-tray').style.display   = 'none';
    renderCompareTable();
}

function hideCompareView() {
    document.getElementById('packages-view').style.display = 'block';
    document.getElementById('compare-view').style.display  = 'none';
    updateCompareTray();
}

function renderCompareTable() {
    var container = document.getElementById('compare-table-container');
    if (!container || !compareList.length) return;

    var pkgs = compareList;
    var minPrice  = Math.min.apply(null, pkgs.map(function (p) { return Number(p.Price || 0); }));
    var maxRating = Math.max.apply(null, pkgs.map(function (p) { return Number(p.AvgRating || 0); }));

    var rows = [
        { label: 'Agency', fn: function (p) { return escHtml(p.AgencyName || '—'); } },
        { label: 'Duration', fn: function (p) { return (p.Duration || 0) + ' days'; } },
        { label: 'Price', fn: function (p) {
            var isBest = Number(p.Price) === minPrice;
            return '<span class="' + (isBest ? 'compare-best' : '') + '">R' +
                Number(p.Price || 0).toLocaleString('en-ZA') + '</span>';
        }},
        { label: 'Rating', fn: function (p) {
            var r      = Number(p.AvgRating || 0);
            var isBest = r === maxRating && r > 0;
            return '<span class="' + (isBest ? 'compare-best' : '') + '">★ ' + r.toFixed(1) + '</span>';
        }},
        { label: 'Group trips', fn: function (p) { return p.Is_Group_Trip ? ' Available' : 'None'; } },
        { label: 'Start date',  fn: function (p) { return escHtml(p.Start_Date || 'Flexible'); } },
        { label: '',            fn: function (p) {
            return '<a href="/NanlaPA5/app/traveller/book.php?id=' + p.PackageID +
                   '" class="btn-primary">Book now</a>';
        }}
    ];

    var headerCells = pkgs.map(function (p) {
        return '<th>' + escHtml(p.Name || '') + '</th>';
    }).join('');

    var bodyRows = rows.map(function (row) {
        return '<tr>' +
            '<td class="compare-label">' + row.label + '</td>' +
            pkgs.map(function (p) { return '<td>' + row.fn(p) + '</td>'; }).join('') +
        '</tr>';
    }).join('');

    container.innerHTML =
        '<div class="compare-table-wrap">' +
            '<table class="compare-table">' +
                '<thead><tr><th></th>' + headerCells + '</tr></thead>' +
                '<tbody>' + bodyRows + '</tbody>' +
            '</table>' +
        '</div>' +
        '<p class="compare-note">★ Green values indicate the best option for that category.</p>';
}