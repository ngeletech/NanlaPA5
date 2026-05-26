// package-edit.js - Agency create/edit package

var selectedItems = {
    destinations: [],
    flights: [],
    accommodations: [],
    attractions: [],
    restaurants: []
};

var editMode = false;
var packageId = null;

document.addEventListener('DOMContentLoaded', function () {
    var packageIdInput = document.getElementById('package_id');
    packageId = packageIdInput ? packageIdInput.value : null;
    editMode  = packageId && packageId !== '';

    loadDropdowns();

    if (editMode) {
        loadPackageData(packageId);
    }

    var form = document.getElementById('package-form');
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            submitPackageForm();
        });
    }
});

// Load all dropdowns

function loadDropdowns() {
    loadDropdown('GetDestinations', 'destination-select', 'DestinationID', 'City_Name');
    loadDropdown('getFlights', 'flight-select', 'FlightID', 'Flight_Name');
    loadDropdown('GetAccomodations', 'accommodation-select', 'AccomodationID', 'Name');
    loadDropdown('GetAttractions', 'attraction-select', 'AttractionID', 'Name');
    loadDropdown('GetRestaurants', 'restaurant-select', 'RestaurantID', 'Name');
}

function loadDropdown(type, selectId, idField, labelField) {
    var select = document.getElementById(selectId);
    if (!select) return;

    makeRequest({ type: type }, function (result) {
        if (result.status !== 'success' || !result.data) {
            select.innerHTML = '<option value="">Failed to load</option>';
            return;
        }

        select.innerHTML = '<option value="">Select one...</option>';
        result.data.forEach(function (item) {
            var option = document.createElement('option');
            option.value = item[idField];
            option.textContent = item[labelField];
            option.dataset.json = JSON.stringify(item);
            select.appendChild(option);
        });
    });
}

// Add item to list 

function addItem(type) {
    var selectMap = {
        destination:'destination-select',
        flight: 'flight-select',
        accommodation: 'accommodation-select',
        attraction: 'attraction-select',
        restaurant: 'restaurant-select'
    };

    var listMap = {
        destination: 'destinations',
        flight: 'flights',
        accommodation: 'accommodations',
        attraction: 'attractions',
        restaurant: 'restaurants'
    };

    var idMap = {
        destination: 'DestinationID',
        flight: 'FlightID',
        accommodation: 'AccomodationID',
        attraction: 'AttractionID',
        restaurant: 'RestaurantID'
    };

    var labelMap = {
        destination: 'City_Name',
        flight: 'Flight_Name',
        accommodation: 'Name',
        attraction: 'Name',
        restaurant: 'Name'
    };

    var select = document.getElementById(selectMap[type]);
    if (!select || !select.value) return;

    var item = JSON.parse(select.options[select.selectedIndex].dataset.json);
    var idField = idMap[type];
    var labelField = labelMap[type];
    var listKey = listMap[type];

    // check not already added
    var alreadyAdded = selectedItems[listKey].some(function (i) {
        return i[idField] === item[idField];
    });

    if (alreadyAdded) {
        alert('This item is already added.');
        return;
    }

    selectedItems[listKey].push(item);
    renderItemList(listKey, idField, labelField);
}

function removeItem(type, id) {
    var idMap = {
        destinations: 'DestinationID',
        flights: 'FlightID',
        accommodations: 'AccomodationID',
        attractions: 'AttractionID',
        restaurants: 'RestaurantID'
    };

    var idField = idMap[type];
    selectedItems[type] = selectedItems[type].filter(function (item) {
        return item[idField] !== id;
    });

    var labelMap = {
        destinations: 'City_Name',
        flights: 'Flight_Name',
        accommodations: 'Name',
        attractions: 'Name',
        restaurants: 'Name'
    };

    renderItemList(type, idField, labelMap[type]);
}

function renderItemList(listKey, idField, labelField) {
    var container = document.getElementById(listKey + '-list');
    if (!container) return;

    if (!selectedItems[listKey].length) {
        container.innerHTML = '';
        return;
    }

    container.innerHTML = selectedItems[listKey].map(function (item) {
        return '<div class="item-tag">' +
            '<span>' + escHtml(item[labelField] || '') + '</span>' +
            '<button type="button" onclick="removeItem(\'' + listKey + '\', ' + item[idField] + ')">✕</button>' +
        '</div>';
    }).join('');
}

// Load existing package data

function loadPackageData(id) {
    makeRequest({ type: 'ViewPackage', package_id: parseInt(id) }, function (result) {
        if (result.status !== 'success' || !result.data) {
            showBanner('form-error', 'Failed to load package data.', 'error');
            return;
        }

        var d   = result.data;
        var pkg = d.package;

        // fill basic fields
        var nameEl = document.getElementById('package_name');
        if (nameEl) nameEl.value = pkg.Name || '';

        var descEl = document.getElementById('description');
        if (descEl) descEl.value = pkg.Description || '';

        var priceEl = document.getElementById('price');
        if (priceEl) priceEl.value = pkg.Price || '';

        var startEl = document.getElementById('start_date');
        if (startEl) startEl.value = pkg.Start_Date || '';

        var maxEl = document.getElementById('max_participants');
        if (maxEl) maxEl.value = pkg.Max_Group_Size || '';

        // fill item lists
        if (d.destinations) {
            selectedItems.destinations = d.destinations;
            renderItemList('destinations', 'DestinationID', 'City_Name');
        }
        if (d.flights) {
            selectedItems.flights = d.flights;
            renderItemList('flights', 'FlightID', 'Flight_Name');
        }
        if (d.accommodations) {
            selectedItems.accommodations = d.accommodations;
            renderItemList('accommodations', 'AccomodationID', 'Name');
        }
        if (d.attractions) {
            selectedItems.attractions = d.attractions;
            renderItemList('attractions', 'AttractionID', 'Name');
        }
        if (d.restaurants) {
            selectedItems.restaurants = d.restaurants;
            renderItemList('restaurants', 'RestaurantID', 'Name');
        }
    });
}

// Submit form 
function submitPackageForm() {
    clearErrors();
    var valid = true;

    var name = document.getElementById('package_name').value.trim();
    var desc = document.getElementById('description').value.trim();
    var price = document.getElementById('price').value.trim();
    var startDate = document.getElementById('start_date').value;
    var endDate = document.getElementById('end_date').value;
    var maxPart = document.getElementById('max_participants').value.trim();
    var duration = document.getElementById('duration').value.trim();

    if (!name) {
        showFieldError('package_name', 'Package name is required');
        valid = false;
    }

    if (!desc) {
        showFieldError('description', 'Description is required');
        valid = false;
    }

    if (!price || isNaN(price) || parseFloat(price) <= 0) {
        showFieldError('price', 'A valid price is required');
        valid = false;
    }

    if (!startDate) {
        showFieldError('start_date', 'Start date is required');
        valid = false;
    }

    // Calculate end_date from start_date + duration
    if (!duration || parseInt(duration) < 1) {
        showFieldError('duration', 'Duration must be at least 1 day');
        valid = false;
    } else if (startDate) {
        var start = new Date(startDate);
        var calculatedEndDate = new Date(start);
        calculatedEndDate.setDate(start.getDate() + parseInt(duration) - 1);
        endDate = calculatedEndDate.toISOString().split('T')[0];
    }

    if (!selectedItems.destinations.length) {
        showFieldError('destinations', 'At least one destination is required');
        valid = false;
    }

    if (!maxPart || parseInt(maxPart) < 2) {
        showFieldError('max_participants', 'Max participants must be at least 2');
        valid = false;
    }

    if (!valid) return;

    setButtonLoading('submit-btn', 'Saving...');

    var requestData = {
        type: editMode ? 'UpdatePackage' : 'CreatePackage',
        package_id: packageId || '',
        name: name,
        description: desc,  // ADD THIS - was missing!
        price: parseFloat(price),
        start_date: startDate,
        end_date: endDate,  // ADD THIS - backend expects end_date
        max_group_size: parseInt(maxPart),
        destinations: selectedItems.destinations.map(function (d) { return d.DestinationID; }),
        flights: selectedItems.flights.map(function (f) { return f.FlightID; }),
        accommodations: selectedItems.accommodations.map(function (a) { return a.AccomodationID; }),
        attractions: selectedItems.attractions.map(function (a) { return a.AttractionID; }),
        restaurants: selectedItems.restaurants.map(function (r) { return r.RestaurantID; })
    };

    makeRequest(requestData, function (result) {
        if (result.status === 'success') {
            showBanner('form-success',
                editMode ? 'Package updated successfully!' : 'Package created successfully!',
                'success');
            setTimeout(function () {
                window.location.href = '/NanlaPA5/app/travel-agency/packages.php';
            }, 1500);
        } else {
            showBanner('form-error', result.data || 'Failed to save package.', 'error');
            resetButton('submit-btn');
        }
    });
}