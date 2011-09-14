var MIN_USERNAME_LENGTH = 6;
var specialCharacters = [' ', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '?', ',', ':', ';', '\"', '\'', '<', '>', '/', '[', ']', '{', '}', '\\', '|', '='];
var integers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

$(document).ready(
    function () {
        $('#username').keyup(
            function () {
                validateUserName($(this).val());
            }
        );

        $('#email').keyup(
            function () {
                validateEmail($(this).val());
            }
        );

        $('#password').keyup(
            function () {
                validatePassword($(this).val());
            }
        );

        $('#confirm-password').keyup(
            function () {
                validateConfirmPassword($(this).val());
            }
        );

        $('#first-name').keyup(
            function () {
                validateFirstName($(this).val());
            }
        );

        $('#last-name').keyup(
            function () {
                validateLastName($(this).val());
            }
        );
    }
);

function validateUserName(username) {
    if (username.length < 6 || username.length > 32) {
        $('#username-validation').text('Username must be 6 to 32 characters');
        return;
    }

    for(var i in specialCharacters)
    {
        if (username.indexOf(specialCharacters[i]) != -1) {
            $('#username-validation').text('Username should have no special characters');
            return;
        }
    }

    $('#username-validation').text('');
    $('#register-button').attr('disabled', ''); //enable the register button
}

function validateEmail(email) {
    var regexPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+[\.]{1}[a-zA-Z]{2,4}$/;

    if (!regexPattern.test(email)) {
        $('#email-validation').text('This email address is not valid');
    }
    else {
        $('#email-validation').text('');
    }
}

function validatePassword(password) {
    if (password.length < 8) {
        $('password-validation').text('Password must be 8 to 32 characters in length');
    }
    else {
        $('password-validation').text('');
    }
}

function validateConfirmPassword(confirmPassword) {
    var password = $('#password').val().toString();

    if (password != confirmPassword.toString()) {
        $('confirm-password-validation').text('Password and Confirm Password should be the same');
    }
    else {
        $('confirm-password-validation').text('');
    }
}

function validateFirstName(firstName) {
    for (var i in specialCharacters) {
        if (firstName.indexOf(specialCharacters[i]) != -1) {
            $('#first-name-validation').text('First Name has invalid characters');
            return;
        }
    }

    for(var i in integers)
    {
        if (firstName.indexOf(integers[i]) != -1) {
            $('#first-name-validation').text('First Name has invalid characters');
            return;
        }
    }

    $('#first-name-validation').text('');
}

function validateLastName(lastName) {
    for (var i in specialCharacters) {
        if (lastName.indexOf(specialCharacters[i]) != -1) {
            $('#last-name-validation').text('Last Name has invalid characters');
            return;
        }
    }

    for (var i in integers) {
        if (lastName.indexOf(integers[i]) != -1) {
            $('#last-name-validation').text('Last Name has invalid characters');
            return;
        }
    }

    $('#last-name-validation').text('');
}
