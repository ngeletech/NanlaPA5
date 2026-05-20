// main.js - Core API request function
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
                    callback({
                        status: 'error',
                        data: 'Invalid server response'
                    });
                }
            } else {
                callback({
                    status: 'error',
                    data: 'Server error: ' + xhr.status
                });
            }
        }
    };
    
    xhr.send(JSON.stringify(data));
}

// Helper function to escape HTML
function escHtml(str) {
    if (!str) return '';
    var div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
}

// Helper function to clear form errors
function clearErrors() {
    var errors = document.querySelectorAll('.error-message, .field-error');
    errors.forEach(function(el) {
        el.innerText = '';
    });
}