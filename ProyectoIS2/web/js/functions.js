/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 6/11/14
 * Time: 19:16
 * To change this template use File | Settings | File Templates.
 */

function login(form) {
    $.post("IndexFunctions.jsp", { action: "LOGIN", username: form.username.value, password: form.password.value }, function (result) {
        if (result.split("&&&")[1] != "OK") {
            $("#error").css("display", "block");
        }
        else {
            $("#error").css("display", "none");
            form.submit();
        }
    });
    return false;
}

function register(form) {
    if (form.password.value == form.passwordConfirm.value && form.Telefono.value.length == 9) {
        $("#errorpass").css("display", "none");
        $.post("IndexFunctions.jsp", { action: "REGISTRO", username: form.userName.value, password: form.password.value,
            email: form.email.value, nombre: form.realName.value, telf: form.Telefono.value}, function (result) {
            if (result.split("&&&")[1] == "OK") {
                $("#errorusername").css("display", "none");
                form.submit();
            }
            else
                $("#errorusername").css("display", "block");
        });
    } else {
        $("#errorpass").css("display", "block");
    }
    if (form.Telefono.value.length != 9) {
        $("#errortelf").css("display", "block");
        if (form.password.value == form.passwordConfirm.value)
            $("#errorpass").css("display", "none");
    } else {
        $("#errortelf").css("display", "none");
    }
    return false;
}

//$(document).ready(function () {
//    /*
//     * When the site is loaded, should make the tables if the are not initialized
//     * */
////    $.post("IndexFunctions.jsp",{ action: "START"}, function (result) {
////    });
//});