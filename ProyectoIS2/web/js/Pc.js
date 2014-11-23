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
    $.post("Functions.jsp", { action: "ADDPC",date:form.fecha.value,descr:form.desc.value,mot:form.motivo.value,CCC:form.ccc.value}, function (result) {
        if (result.split("&&&")[1] == "OK") {
            $("#errorcreatepc").css("display", "none");
            form.submit();
        }
        else
            $("#errorcreatepc").css("display", "block");

    });
}

