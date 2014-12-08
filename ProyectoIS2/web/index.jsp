<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("user") != null) {
        // New location to be redirected
        String site = new String("./logged.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        System.out.println("logged");
    } else {
        System.out.println("no log");
%>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<html lang="en"> <!--<![endif]-->
<head>
    <title>SEGECA - Login Form</title>
    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>

</head>
<body>
<div class="container" style="width: 500px">

    <div id="error" class="alert alert-danger" role="alert" style="display: none;margin-top: 2%">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <strong>Wrong pasword or username.</strong> Please login again.
    </div>
    <form name="log" action="logged.jsp" onsubmit="return login(this)" method="post" style="padding-top: 2%">

        <div class="panel panel-success">
            <div class="panel-heading">
                <h1 style="text-align: center;">SEGECA Login Page</h1>
            </div>
            <div class="panel-body">
                <div class="input-group">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                    <input type="text" id="usrname" name="username" class="form-control" placeholder="Username"
                           required="" <%
                        if(request.getParameter("userName")!=null){
                            %> value="<%=request.getParameter("userName").toLowerCase()%>" <%}
                        %>>
                </div>

                <div class="input-group" style="padding-top: 1%">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                    <input id="password" type="password" name="password" value="" placeholder="Password"
                           class="form-control" required="">
                </div>

                <div style="padding-top: 2%">
                    <input class="btn btn-lg btn-primary btn-block" type="submit" value="Login">
                </div>
            </div>
        </div>
    </form>

    <p class="navbar-text navbar-right">Are you not registered? <a href="Register.jsp" class="navbar-link">Click here to
        Register</a></p>
</div>
</body>
</html>
<% } %>