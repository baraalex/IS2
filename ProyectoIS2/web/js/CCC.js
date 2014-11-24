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
        console.log(result.split("&&&")[3]);
        $("#CCCUsradd").empty().html(result.split("&&&")[3]);

    });
}

function deleteUser(user) {
    var name = $("#sel1").val();
    $.post("Functions.jsp", { action: "DELETEUSRCCC", ccc: name, usr: user}, function () {
    });

    $.post("Functions.jsp", { action: "CCC", ccc: name}, function (result) {
        $("#CCCInfo").empty().html(result.split("&&&")[1]);
        $("#deleteCCC").empty().html(result.split("&&&")[2]);

    });
}

function deleteCCC(nameccc) {
    $.post("Functions.jsp", { action: "DELETECCC", ccc: nameccc}, function () {
        window.location = "CCC.jsp";
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

function addusr(CCC) {
    if ($("#newuserCCC").val() != "" && CCC != null && CCC != "")
        $.post("Functions.jsp", { action: "ADDUSRCCC", usr: $("#newuserCCC").val(), ccc: CCC}, function (result) {
            if (result.split("&&&")[1] != "OK") {
                $("#erroraddusr").css("display", "block");
            } else {
                $("#erroraddusr").css("display", "none");
                window.location = "CCC.jsp";
            }
        });
    else
        $("#erroraddusr").css("display", "block");
}


