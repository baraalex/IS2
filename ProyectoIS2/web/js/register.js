/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 22/11/14
 * Time: 11:45
 * To change this template use File | Settings | File Templates.
 */
function register(form) {
    if (form.password.value == form.passwordConfirm.value && form.Telefono.value.length == 9) {
        $("#errorpass").css("display", "none");
        $.post("Functions.jsp", { action: "REGISTRO", username: form.userName.value, password: form.password.value,
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

$(document).ready(function () {
    $("#Telefono").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter, ., Ctrl+A, home, end, left, right
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 || (e.keyCode == 65 && e.ctrlKey === true) ||
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
});