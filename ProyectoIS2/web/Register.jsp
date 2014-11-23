<%
    HttpSession sesion = request.getSession();
    if(sesion.getAttribute("user")!=null){
        // New location to be redirected
        String site = new String("./logged.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
    }
    else{
%>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 12/11/14
  Time: 22:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SEGECA - Registro</title>
    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/register.js"></script>
</head>
<body>

<div class="container" style="width: 500px">
    <div id="errorusername" class="alert alert-danger" role="alert" style="display: none;margin-top: 2%">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <strong>Username already exist.</strong> Please select other username.
    </div>
    <div id="errorpass" class="alert alert-danger" role="alert" style="display: none;margin-top: 2%">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <strong>Password are not the same.</strong> Please rewrite them.
    </div>
    <div id="errortelf" class="alert alert-danger" role="alert" style="display: none;margin-top: 2%">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <strong>Telephone are not valid.</strong> Please rewrite them.
    </div>

    <form name="registerform" action="index.jsp" method="post" style="padding-top: 2%" onsubmit="return register(this)">

        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">SEGECA - Registro</h3>
            </div>
            <div class="panel-body">
                <div class="input-group">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                    <input type="text" id="userName" name="userName" class="form-control" placeholder="Username"
                           required="" value="">
                </div>

                <div class="input-group" style="padding-top: 1%">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Email"
                           required="" value="">
                </div>

                <div class="input-group" style="padding-top: 1%">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                    <input type="text" id="realName" name="realName" class="form-control" placeholder="Nombre completo"
                           required="" value="">
                </div>

                <div class="input-group" style="padding-top: 1%">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></span>
                    <input type="text" id="Telefono" name="Telefono" class="form-control"
                           placeholder="Phone (9 digits)"
                           required="" value="">
                </div>

                <div class="input-group" style="padding-top: 1%">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                    <input id="password" type="password" name="password" placeholder="Password"
                           class="form-control" required="" value="">
                </div>

                <div class="input-group" style="padding-top: 1%">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                    <input id="passwordConfirm" type="password" name="passwordConfirm" placeholder="Confirm password"
                           class="form-control" required="" value="">
                </div>
                <div style="padding-top: 2%">
                    <input class="btn btn-lg btn-primary btn-block" type="submit" value="Register">
                </div>
            </div>
        </div>
    </form>

    <p class="navbar-text navbar-right"><a href="index.jsp" class="navbar-link">Click here to go back to Login</a></p>
</div>
</body>
</html>
<% } %>