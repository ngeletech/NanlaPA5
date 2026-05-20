

document.addEventListener('DOMContentLoaded', function(){
    var form = document.getElementById('loginForm');
    if(form){
        form.addEventListener('submit', function(e){
            e.preventDefault();
            document.getElementById('emailError').innerText = '';
            document.getElementById('passwordError').innerText = '';
            document.getElementById('apiResponse').innerHTML = '';

            var email = document.getElementById('email').value.trim();
            var password = document.getElementById('password').value;
            var isValid = true;

            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if(!emailRegex.test(email)){
                document.getElementById('emailError').innerText = 'Please enter a valid email address';
                isValid = false;
            }
            
            if(password === ''){
                document.getElementById('passwordError').innerText = 'Please enter your password';
                isValid= false;
            }

            if(isValid){
                var submitBtn = document.querySelector('.btn');
                submitBtn.disabled = true;
                submitBtn.textContent = 'Logging in...';

                var apiReq = {
                    type: 'Login',
                    email: email,
                    password: password
                };

                makeRequest(apiReq, function(result){
                    if(result.status === 'success'){

                        localStorage.setItem('apikey', result.data.apikey);
                        localStorage.setItem('userName', result.data.name);
                        localStorage.setItem('userType', result.data.type);

                        document.getElementById('apiResponse').innerHTML = 
                            '<div class="success-message">' +
                                '<p>Login successful! Redirecting...</p>' +
                            '</div>';

                            setTimeout(function(){
                                window.location.href = 'index.php';
                            }, 1500);
                    } else {
                        document.getElementById('apiResponse').innerHTML = 
                            '<div class="">' +
                                '<p>' + result.data + '</p>' +
                            '</div>';
                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Login';
                    }
                });
            }
        });
    }
});