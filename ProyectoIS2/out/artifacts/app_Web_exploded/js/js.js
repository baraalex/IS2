/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 6/11/14
 * Time: 19:16
 * To change this template use File | Settings | File Templates.
 */

function login() {
//TODO: hacer bien el login con la comprobacion de usuario y passwd
    $.post("Otro.jsp", { name: "LOGIN", username: $("#usrname").val(), password: $("#password").val() }, function (result) {
        if (result.split("&&&")[1] == "OK") {
//            alert(result.split("&&&")[1]);
            window.location = "Operations.jsp";
        }
        else
        $("#error").css("display","block")
    });
}

function register() {
    $("#login").css("display", "none");
    $("#reg").css("display", "none");
    $("#register").css("display", "block");
    $("#log").css("display", "block");
}

function loginagain() {
    $("#login").css("display", "block");
    $("#reg").css("display", "block");
    $("#register").css("display", "none");
    $("#log").css("display", "none");
}