var MIN_USERNAME_LENGTH = 6;
var MAX_USERNAME_LENGTH = 32;
var MIN_PASSWORD_LENGTH = 6
var MAX_PASSWORD_LENGTH = 32;

var specialCharacters = [' ', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '?', ',', ':', ';', '\"', '\'', '<', '>', '/', '[', ']', '{', '}', '\\', '|', '='];
var integers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
var invalidNameCharacters = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '?', ',', ':', ';', '\"', '\'', '<', '>', '/', '[', ']', '{', '}', '\\', '|', '='];
var validationFlags;

$(document).ready(
    function () {
        initializeValidationFlags();

        $('#UserName').change(
            function () {
                validateUserName($(this).val());
                refreshCanSubmit();
            }
        );

        $('#Email').change(
            function () {
                validateEmail($(this).val());
                refreshCanSubmit();
            }
        );

        $('#Password').change(
            function () {
                validatePassword($(this).val());
                validateConfirmPassword($('#ConfirmPassword').val());
                refreshCanSubmit();
            }
        );

        $('#ConfirmPassword').change(
            function () {
                validateConfirmPassword($(this).val());
                refreshCanSubmit();
            }
        );

        $('#FirstName').change(
            function () {
                validateFirstName($(this).val());
                refreshCanSubmit();
            }
        );

        $('#LastName').change(
            function () {
                validateLastName($(this).val());
                refreshCanSubmit();
            }
        );

        $('#Birthdate').datepicker({ changeYear: true, maxDate: new Date() });

        $('#Birthdate').change(
            function () {
                validateBirthdate($(this).val());
                refreshCanSubmit();
            }
        );
    }
);

function initializeValidationFlags() {
    validationFlags = new Array();

    validationFlags["USERNAME_LENGTH"] = false;
    validationFlags["USERNAME_CHARACTERS"] = false;
    validationFlags["EMAIL"] = false;
    validationFlags["PASSWORD_LENGTH"] = false;
    validationFlags["CONFIRM_PASSWORD_MATCH"] = false;
    validationFlags["FIRST_NAME_CHARACTERS"] = false;
    validationFlags["FIRST_NAME_LENGTH"] = false;
    validationFlags["LAST_NAME_CHARACTERS"] = false;
    validationFlags["FIRST_NAME_LENGTH"] = false;
    validationFlags["BIRTHDATE"] = false;
}

function validateUserName(username) {
    if (username.length < MIN_USERNAME_LENGTH || username.length > MAX_USERNAME_LENGTH) {
        validationFlags["USERNAME_LENGTH"] = false;
        $('#username-validation').text($.sprintf('Username must be %d to %d characters', MIN_USERNAME_LENGTH, MAX_USERNAME_LENGTH));
        return;
    }
    else {
        validationFlags["USERNAME_LENGTH"] = true;
    }

    for(var i in specialCharacters)
    {
        if (username.indexOf(specialCharacters[i]) != -1) {
            validationFlags["USERNAME_CHARACTERS"] = false;
            $('#username-validation').text('Username should have no special characters');
            return;
        }
    }

    validationFlags["USERNAME_CHARACTERS"] = true;
    $('#username-validation').text('');
}

function validateEmail(email) {
    var regexPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+[\.]{1}[a-zA-Z]{2,4}$/;

    if (!regexPattern.test(email)) {
        validationFlags["EMAIL"] = false;
        $('#email-validation').text('This email address is not valid');
    }
    else {
        validationFlags["EMAIL"] = true;
        $('#email-validation').text('');
    }
}

function validatePassword(password) {
    if (password.length < MIN_PASSWORD_LENGTH || password.length > MAX_PASSWORD_LENGTH) {
        validationFlags["PASSWORD_LENGTH"] = false;
        $('#password-validation').text($.sprintf('Password must be %d to %d characters in length', MIN_PASSWORD_LENGTH, MAX_PASSWORD_LENGTH));
    }
    else {
        validationFlags["PASSWORD_LENGTH"] = true;
        $('#password-validation').text('');
    }
}

function validateConfirmPassword(confirmPassword) {
    var password = $('#Password').val().toString();

    if (password != confirmPassword.toString()) {
        validationFlags["CONFIRM_PASSWORD_MATCH"] = false;
        $('#confirm-password-validation').text('Password and Confirm Password should be the same');
    }
    else {
        validationFlags["CONFIRM_PASSWORD_MATCH"] = true;
        $('#confirm-password-validation').text('');
    }
}

function validateFirstName(firstName) {
    firstName = firstName.trim();

    if (firstName != "") {
        validationFlags["FIRST_NAME_LENGTH"] = true;
    }
    else {
        $('#first-name-validation').text('First Name cannot be empty');
        validationFlags["FIRST_NAME_LENGTH"] = false;
        return;
    }

    for (var i in invalidNameCharacters) {
        if (firstName.indexOf(invalidNameCharacters[i]) != -1) {
            validationFlags["FIRST_NAME_CHARACTERS"] = false;
            $('#first-name-validation').text('First Name has invalid characters');
            return;
        }
    }

    for(var i in integers)
    {
        if (firstName.indexOf(integers[i]) != -1) {
            validationFlags["FIRST_NAME_CHARACTERS"] = false;
            $('#first-name-validation').text('First Name has invalid characters');
            return;
        }
    }

    validationFlags["FIRST_NAME_CHARACTERS"] = true;
    $('#first-name-validation').text('');
}

function validateLastName(lastName) {
    lastName = lastName.trim();
    if (lastName != "") {
        validationFlags["LAST_NAME_LENGTH"] = true;
    }
    else {
        $('#last-name-validation').text('Last Name cannot be empty');
        validationFlags["LAST_NAME_LENGTH"] = false;
        return;
    }

    for (var i in invalidNameCharacters) {
        if (lastName.indexOf(invalidNameCharacters[i]) != -1) {
            validationFlags["LAST_NAME_CHARACTERS"] = false;
            $('#last-name-validation').text('Last Name has invalid characters');
            return;
        }
    }

    for (var i in integers) {
        if (lastName.indexOf(integers[i]) != -1) {
            validationFlags["LAST_NAME_CHARACTERS"] = false;
            $('#last-name-validation').text('Last Name has invalid characters');
            return;
        }
    }

    validationFlags["LAST_NAME_CHARACTERS"] = true;
    $('#last-name-validation').text('');
}

function validateBirthdate(birthdate) {
    if (birthdate != "") {
        validationFlags["BIRTHDATE"] = true;
    }
    else {
        validationFlags["BIRTHDATE"] = false;
    }
}

function refreshCanSubmit() {
    $('#register-button').attr('disabled', canSubmit() ? '' : 'disabled');
}

function canSubmit() {
    for (var i in validationFlags) {
        if (!validationFlags[i]) {
            return false;
        }
    }

    return true;
}
