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
    $.post("Functions.jsp", { action: "CCSINFO"}, function (result) {
        $("#cccs").empty().html(result.split("&&&")[1]);
    });
    $.post("Functions.jsp", { action: "INFO"}, function (result) {
        $("#personal").empty().html(result.split("&&&")[1]);
    });
});