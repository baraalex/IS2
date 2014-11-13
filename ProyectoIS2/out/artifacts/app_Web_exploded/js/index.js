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
    window.location = "Register.jsp";
}
function goregister() {
    window.location = "Register.jsp";

}

function loginagain() {
    window.location = "index.jsp";
}

//$(document).ready(function () {
//    /*
//     * When the site is loaded, should make the tables if the are not initialized
//     * */
////    $.post("IndexFunctions.jsp",{ action: "START"}, function (result) {
////        showView(result, "mappingContent");
////        $("#divWelcome").css("display", "none");
////        document.getElementById("uploadButt").disabled = true;
//////        document.getElementById("submitButt").disabled = true;
////    });
//});