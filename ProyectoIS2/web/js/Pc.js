/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 23/11/14
 * Time: 18:23
 * To change this template use File | Settings | File Templates.
 */
function exit() {
    $.post("Functions.jsp", { action: "EXIT"}, function () {
    });
}

function newPCform() {
    $.post("Functions.jsp", { action: "ADDPCFORM"}, function (result) {
        $("#PCs").empty().html(result.split("&&&")[1]);
    });
}

function newPC(form) {
    if (form.ccc.value == "") {
        $("#errorcreatepc").css("display", "block");
        return false;
    }

    $.post("Functions.jsp", { action: "ADDPC", date: form.fecha.value, descr: form.desc.value, mot: form.motivo.value, CCC: form.ccc.value}, function (result) {
        if (result.split("&&&")[1] == "OK") {
            $("#errorcreatepc").css("display", "none");
            form.submit();
        }
        else {
            $("#errorcreatepc").css("display", "block");
            return false;
        }
    });

}

function verPC() {
    $.post("Functions.jsp", { action: "USERPC"}, function (result) {
        $("#PCs").empty().html(result.split("&&&")[1]);
    });
}

function InfoPcEstado(ID) {
    $.post("Functions.jsp", { action: "PCINFO", id: ID}, function (result) {
        $("#PCs").empty().html(result.split("&&&")[1]);
    });
}

function modificarEstadoPc(ID) {
    var radios = document.getElementsByName('estado');
    var estate = "";

    for (var i = 0, length = radios.length; i < length && estate == ""; i++) {
        if (radios[i].checked) {
            estate = radios[i].value;
            break;
        }
    }
    $.post("Functions.jsp", { action: "MODIFYPCESTADO", id: ID, estado: estate}, function (result) {
        if (result.split("&&&")[1] == "OK") {
            verPC();
        } else {
            $("#errormodifypc").css("display", "block");
        }
    });
}

function InfoPc(ID) {
    $.post("Functions.jsp", { action: "PCINFO2", id: ID}, function (result) {
        $("#PCs").empty().html(result.split("&&&")[1]);
    });
}


function ModifyPC(form, Id) {

    if (form.desc.value == "" && form.motivo.value == "") {
        $("#errormodifypc").css("display", "block");
        return false;
    }
    else {
        $.post("Functions.jsp", { action: "MODIFYPC", descr: form.desc.value, mot: form.motivo.value, id: Id}, function (result) {
            if (result.split("&&&")[1] == "OK") {
                $("#errorcreatepc").css("display", "none");
                form.submit();
            }
            else {
                $("#errormodifypc").css("display", "block");
                return false;
            }
        });
    }
}

$(document).ready(function () {
    verPC();
});