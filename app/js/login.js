

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
                var submitBtn = document.querySelector('.btn-primary');
                submitBtn.disabled = true;
                submitBtn.textContent = 'Logging in...';

                var apiReq = {
                    type: 'Login',
                    email: email,
                    password: password
                };

                makeRequest(apiReq, function(result){
                    if(result.status === 'success'){

                        localStorage.setItem('userID', result.data.user)
                        localStorage.setItem('userName', result.data.name);
                        localStorage.setItem('userEmail', result.data.email);

                        document.getElementById('apiResponse').innerHTML = 
                            '<div class="success-message">' +
                                '<p>Login successful! Redirecting...</p>' +
                            '</div>';

                            setTimeout(function(){
                                if (result.data.type === 'Travel Agency') {
                                    window.location.href = '/NanlaPA5/app/travel-agency/profile.php';
                                } else {
                                    window.location.href = '/NanlaPA5/app/traveller/profile.php';
                                }
                            }, 1500);
                    } else {
                        document.getElementById('apiResponse').innerHTML = 
                            '<div class="">' +
                                '<p>' + result.data + '</p>' +
                            '</div>';
                        submitBtn.disabled = true;
                        submitBtn.textContent = 'Login';
                    }
                });
            }
        });
    }
});