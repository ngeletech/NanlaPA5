let allPackages  = [];
let compareList  = [];

document.addEventListener('DOMContentLoaded', function () {
    loadPackages();

    document.getElementById('sort-by').addEventListener('change', renderPackages);
    document.getElementById('compare-btn').addEventListener('click', showCompareView);
    document.getElementById('clear-compare').addEventListener('click', clearCompare);
    document.getElementById('back-to-browse').addEventListener('click', hideCompareView);
});

function loadPackages() {
    fetch('/api/search.php?limit=100')
        .then(res => res.json())
        .then(data => {
            if (!data.success || !data.packages.length) {
                document.getElementById('packages-container').innerHTML = '';
                document.getElementById('no-results').style.display = 'block';
                document.getElementById('results-count').textContent = '0 packages';
                return;
            }
            allPackages = data.packages;
            renderPackages();
        })
        .catch(() => {
            document.getElementById('packages-container').innerHTML =
                '<p class="t-loading">Could not load packages. Please try again.</p>';
        });
}

function renderPackages() {
    const sorted    = sortPackages([...allPackages]);
    const container = document.getElementById('packages-container');
    document.getElementById('results-count').textContent = sorted.length + ' package(s)';

    if (!sorted.length) {
        container.innerHTML = '';
        document.getElementById('no-results').style.display = 'block';
        return;
    }

    document.getElementById('no-results').style.display = 'none';

    // buildPackageCard comes from main.js — pass compare options
    container.innerHTML = sorted.map(pkg => buildPackageCard(pkg, {
        showCompare:      true,
        compareSelected:  compareList.some(p => p.package_id === pkg.package_id),
        compareDisabled:  !compareList.some(p => p.package_id === pkg.package_id) && compareList.length >= 3
    })).join('');
}

function sortPackages(list) {
    const val = document.getElementById('sort-by').value;
    return list.sort((a, b) => {
        if (val === 'price_asc')    return a.price - b.price;
        if (val === 'price_desc')   return b.price - a.price;
        if (val === 'rating_desc')  return (b.avg_rating || 0) - (a.avg_rating || 0);
        if (val === 'duration_asc') return a.duration - b.duration;
        if (val === 'duration_desc')return b.duration - a.duration;
        return 0;
    });
}

function toggleCompare(checkbox, pkg) {
    if (checkbox.checked) {
        if (compareList.length >= 3) { checkbox.checked = false; return; }
        compareList.push(pkg);
    } else {
        compareList = compareList.filter(p => p.package_id !== pkg.package_id);
    }
    updateCompareTray();
    renderPackages();
}

function updateCompareTray() {
    const tray  = document.getElementById('compare-tray');
    const slots = document.getElementById('compare-slots');
    const btn   = document.getElementById('compare-btn');
    const count = document.getElementById('compare-count');

    if (!compareList.length) { tray.style.display = 'none'; return; }

    tray.style.display = 'block';
    count.textContent  = compareList.length + ' selected';
    btn.disabled       = compareList.length < 2;

    const slotHTML = [];
    for (let i = 0; i < 3; i++) {
        const pkg = compareList[i];
        slotHTML.push(pkg
            ? `<div class="t-compare-slot filled">
                   <span>${escHtml(pkg.package_name)}</span>
                   <button class="t-compare-slot-remove"
                           onclick="removeFromCompare('${pkg.package_id}')">✕</button>
               </div>`
            : `<div class="t-compare-slot">Empty slot</div>`
        );
    }
    slots.innerHTML = slotHTML.join('');
}

function removeFromCompare(id) {
    compareList = compareList.filter(p => p.package_id !== id);
    updateCompareTray();
    renderPackages();
}

function clearCompare() {
    compareList = [];
    updateCompareTray();
    renderPackages();
}

function showCompareView() {
    document.getElementById('packages-view').style.display = 'none';
    document.getElementById('compare-view').style.display  = 'block';
    document.getElementById('compare-tray').style.display  = 'none';
    renderCompareTable();
}

function hideCompareView() {
    document.getElementById('packages-view').style.display = 'block';
    document.getElementById('compare-view').style.display  = 'none';
    updateCompareTray();
}

function renderCompareTable() {
    const pkgs     = compareList;
    const minPrice = Math.min(...pkgs.map(p => Number(p.price)));
    const maxRating= Math.max(...pkgs.map(p => Number(p.avg_rating || 0)));

    const rows = [
        { label: 'Agency',      fn: p => escHtml(p.agency_name) },
        { label: 'Destination', fn: p => escHtml(p.destination) },
        { label: 'Duration',    fn: p => p.duration + ' days' },
        { label: 'Price',       fn: p => {
            const best = Number(p.price) === minPrice;
            return `<span class="${best ? 't-compare-best' : ''}">R${Number(p.price).toLocaleString()}</span>`;
        }},
        { label: 'Rating',      fn: p => {
            const best = Number(p.avg_rating || 0) === maxRating;
            return `<span class="${best ? 't-compare-best' : ''}">★ ${Number(p.avg_rating || 0).toFixed(1)}</span>`;
        }},
        { label: 'Group trips', fn: p => p.has_group_trips ? '✓ Yes' : '—' },
        { label: 'Start date',  fn: p => escHtml(p.start_date || '—') },
        { label: '',            fn: p => `<a href="/traveller/book.php?id=${p.package_id}" class="t-btn-gold" style="font-size:0.8rem; padding:0.45rem 0.9rem">Book</a>` },
    ];

    const headerCells = pkgs.map(p => `<th>${escHtml(p.package_name)}</th>`).join('');
    const bodyRows    = rows.map(row => `
        <tr>
            <td>${row.label}</td>
            ${pkgs.map(p => `<td>${row.fn(p)}</td>`).join('')}
        </tr>
    `).join('');

    document.getElementById('compare-table-container').innerHTML = `
        <div class="t-compare-table-wrap">
            <table class="t-compare-table">
                <thead><tr><th></th>${headerCells}</tr></thead>
                <tbody>${bodyRows}</tbody>
            </table>
        </div>
        <p style="font-size:0.78rem; color:var(--text-muted); margin-top:0.75rem">
            ✓ Green values indicate the best option for that category.
        </p>
    `;
}