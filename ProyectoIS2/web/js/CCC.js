/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 22/11/14
 * Time: 22:25
 * To change this template use File | Settings | File Templates.
 */
function exit() {
    $.post("Functions.jsp", { action: "EXIT"}, function () {
    });
}

function cccInfo() {
    var name = $("#sel1").val();
    $.post("Functions.jsp", { action: "CCC", ccc: name}, function (result) {
        $("#CCCInfo").empty().html(result.split("&&&")[1]);
        $("#deleteCCC").empty().html(result.split("&&&")[2]);
        $("#CCCUsradd").empty().html(result.split("&&&")[3]);
    });
}

function deleteUser(user) {
    var name = $("#sel1").val();

    bootbox.dialog({
        message: "¿Quiere eliminar al usuario '" + user + "' del CCC '" + name + "'?",
        title: "Borrar usuario",
        buttons: {
            success: {
                label: "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span> OK",
                className: "btn-success",
                callback: function () {
                    $.post("Functions.jsp", { action: "DELETEUSRCCC", ccc: name, usr: user}, function () {
                        $.post("Functions.jsp", { action: "CCC", ccc: name}, function (result) {
                            $("#CCCInfo").empty().html(result.split("&&&")[1]);
                            $("#deleteCCC").empty().html(result.split("&&&")[2]);
                            $("#CCCUsradd").empty().html(result.split("&&&")[3]);

                        });
                    });
                }
            },
            danger: {
                label: "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span> Cancel",
                className: "btn-danger",
                callback: function () {
                }
            }
        }
    });
}

function deleteCCC(nameccc) {

    bootbox.dialog({
        message: "¿Quiere eliminar ael CCC '" + nameccc + "'?",
        title: "Borrar CCC",
        buttons: {
            success: {
                label: "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span> OK",
                className: "btn-success",
                callback: function () {
                    $.post("Functions.jsp", { action: "DELETECCC", ccc: nameccc}, function () {
                        window.location = "CCC.jsp";
                    });
                }
            },
            danger: {
                label: "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span> Cancel",
                className: "btn-danger",
                callback: function () {
                }
            }
        }
    });
}

function addCCC() {
    var name = $("#nuevoCCC").val();
    if (name != null && name != "") {
        $.post("Functions.jsp", { action: "ADDCCC", ccc: name}, function (result) {
            if (result.split("&&&")[1] != "OK") {
                $("#errorcreate").css("display", "block");
            } else {
                $("#errorcreate").css("display", "none");
                window.location = "CCC.jsp";
            }
        });
    }
}

function addusr(name) {
    if ($("#newuserCCC").val() != "" && name != null && name != "")
        $.post("Functions.jsp", { action: "ADDUSRCCC", usr: $("#newuserCCC").val(), ccc: name}, function (result) {
            if (result.split("&&&")[1] != "OK") {
                $("#erroraddusr").css("display", "block");
            } else {
                $("#erroraddusr").css("display", "none");
                $.post("Functions.jsp", { action: "CCC", ccc: name}, function (result) {
                    $("#CCCInfo").empty().html(result.split("&&&")[1]);
                    $("#deleteCCC").empty().html(result.split("&&&")[2]);
                    $("#CCCUsradd").empty().html(result.split("&&&")[3]);
                });
            }
        });
    else
        $("#erroraddusr").css("display", "block");
}