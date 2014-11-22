/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 6/11/14
 * Time: 19:16
 * To change this template use File | Settings | File Templates.
 */

function login(form) {
    $.post("Functions.jsp", { action: "LOGIN", username: form.username.value, password: form.password.value }, function (result) {
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