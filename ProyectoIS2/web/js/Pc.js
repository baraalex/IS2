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
