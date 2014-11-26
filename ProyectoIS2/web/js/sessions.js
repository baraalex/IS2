/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 22/11/14
 * Time: 18:09
 * To change this template use File | Settings | File Templates.
 */

function exit() {
    $.post("Functions.jsp", { action: "EXIT"}, function () {
    });
}

$(document).ready(function () {
    $.post("Functions.jsp", { action: "INICIO"}, function (resultado) {
        $("#personal").empty().html(resultado.split("&&&")[1]);
        $("#cccs").empty().html(resultado.split("&&&")[2]);
    });
});