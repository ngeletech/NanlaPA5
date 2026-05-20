function makeRequest(data, callback){
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'api.php', true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = function(){
        if(xhr.readyState === 4){
            if(xhr.status === 200){
            var result = JSON.parse(xhr.responseText);
            callback(result);
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

function clearErrors(){
    var errors = ['nameError', 'surnameError', 'emailError', 'passwordError', 'confirmError', 'typeError', 'DOBError', 'passError', 'reg_Error'];
    for(var i = 0; i < errors.length; i++){
        var elem = document.getElementById(errors[i]);
        if(elem){
            elem.innerText ='';
        }
    }
   
    var inputs =['name', 'surname', 'email', 'password', 'confirm', 'DOB', 'passnum', 'reg_num'];
    for(var i = 0; i < inputs.length; i++){
        var input = document.getElementById(inputs[i]);
        if(input){
            input.classList.remove('error');
            input.style.border = '1px solid #ccc';
        }
    }
    var apiResponse = document.getElementById('apiResponse')
    if(apiResponse){
        apiResponse.innerHTML = '';
    }
}

document.addEventListener('DOMContentLoaded', function(){
    var form = document.getElementById('firstForm');
    if(form){

        form.addEventListener('submit', function (e){
            e.preventDefault();

            var user_type = '';
            var radios = document.getElementsByName('user_type');
            for(var i = 0; i < radios.length; i++){
                if(radios[i].checked){
                    user_type = radios[i].value;
                    break;
                }
            }

            if(!user_type){
                document.getElementById('typeError').innerText = 'Please select a user type';
                return;
            }


            if(user_type === 'Traveller'){
                setTimeout(function() {
                    window.location.href = 'registerTraveller.php';
                    }, 3000);
            } else if (user_type === 'Travel Agency'){
                setTimeout(function() {
                    window.location.href = 'registerTravelAgency.php';
                    }, 3000);
            } 
        })
    }
})
document.addEventListener('DOMContentLoaded', function(){
        var form = document.getElementById('signupForm');
        
        if(form){
            form.addEventListener('submit', function (e){
                e.preventDefault();
                clearErrors();

                var isValid = true;

                var name = document.getElementById('name').value.trim();
                var email = document.getElementById('email').value.trim();
                var password = document.getElementById('password').value;
                var confirm = document.getElementById('confirm').value;

                var user_type = '';
                var radios = document.getElementsByName('user_type');
                for(var i = 0; i < radios.length; i++){
                    if(radios[i].checked){
                        user_type = radios[i].value;
                        break;
                    }
                }

                var surname = '';
                var dob = '';
                var passnum = '';

                if (user_type === 'Traveller' ) {
                    surname = document.getElementById('surname').value.trim();
                    dob = document.getElementById('dob').value;
                    passnum = document.getElementById('passnum').value.trim();
                    
                    if (surname==='') {
                        document.getElementById('surnameError').innerText = 'Please enter your surname';
                        isValid = false;
                    } else {
                        var nameRegex = /^[A-Za-z]{2,}$/;
                        if(!nameRegex.test(surname)){
                            document.getElementById('surnameError').innerText = 'Name must only contain letters and be at least 2 characthers long';
                            isValid = false;
                        }
                    }

                    if (dob === '') {
                        document.getElementById('DOBError').innerText = 'Please enter your date of birth';
                        isValid = false;
                    }
 
                    if (passnum === '') {
                        document.getElementById('passError').innerText = 'Please enter your passport number';
                        isValid = false;
                    }                       
                }

                var reg_num = '';
                if (user_type === 'Travel Agency') {
                    reg_num = document.getElementById('reg_num').value.trim();

                    if(reg_num===''){
                        document.getElementById('reg_Error').innerText= 'Please enter your registration number';
                        isValid=false;
                    } else if (isNaN(reg_num)){
                        document.getElementById('reg_Error').innerText = 'Registration number must be a number';
                        isValid = false;
                    }
                }
                if(!user_type){
                    document.getElementById('typeError').innerText = 'Please select a user type';
                    isValid = false;
                }

                if (name === '') {
                    document.getElementById('nameError').innerText = 'Please enter a name';
                    isValid = false;
                } else {
                    var nameRegex = /^[A-Za-z]{2,}$/;
                    if(!nameRegex.test(name)){
                        document.getElementById('nameError').innerText = 'Name must only contain letters and be at least 2 characthers long';
                        isValid = false;
                    }
                }
                //checking email
                var emailRegex= /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if(!emailRegex.test(email)){
                    document.getElementById('emailError').innerText = 'Please enter a valid email address';
                    isValid=false;
                }


                //password validation
                var passwordRegex = /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{9,}$/;
                if(!passwordRegex.test(password)){
                    document.getElementById('passwordError').innerHTML = 'Password must: <ul><li>Be longer than 8 characters</li><li>Contain uppercase letters</li><li>Contain lowercase letters</li><li>Contain at least one digit</li><li>Contain at least one symbol</li></ul>';
                    isValid = false;
                }
                //confirming password

                if(password !== confirm){
                    document.getElementById('confirmError').innerText ='Passwords do not match';
                    isValid = false;
                }



                if(!isValid){
                    return;
                }
                var apiReq = {
                    type: 'Register',
                    name: name,
                    email: email,
                    password: password,
                    user_type: user_type
                };

                if (user_type === 'Traveller') {
                    apiReq.surname = surname;
                    apiReq.DOB = dob;
                    apiReq.passnum = passnum;
                } else if (user_type === 'Travel Agency'){
                    apiReq.reg_num = reg_num;
                }

                var submitBtn = document.querySelector('.btn');
                submitBtn.disabled = true;
                submitBtn.textContent = 'Registering...';

                makeRequest(apiReq, function(result){
                    if(result.status === 'success'){
                        document.getElementById('apiResponse').innerHTML = 
                        '<div class = "success-message">'+
                            '<p>Registration successful! Redirecting...</p>'+
                        '</div>'

                        setTimeout(function() {
                        window.location.href = 'login.php';
                        }, 3000);
                    } else {
                        var errorMsg = result.data || 'Registration failed';
                        document.getElementById('apiResponse').innerHTML = 
                        '<div class="error-message">'+
                            '<p>' + errorMsg + '</p>' +
                        '</div>';
                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Sign up!';
                    }
                });
            });

        }


});
