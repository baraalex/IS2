/**
 * Created with IntelliJ IDEA.
 * User: Alejandro
 * Date: 6/11/14
 * Time: 19:16
 * To change this template use File | Settings | File Templates.
 */

function login(){
//    document.post("Otro.jsp", { name: "John", time: "2pm" },
//        function(data){
//            alert("Data Loaded: " + data);
//        })
    $.post("Otro.jsp", { name: "EJEMPLO", time: "2pm" },
        function(data){
            alert("Data Loaded: " + data);
        });

//    window.location = "Operations.jsp";
}