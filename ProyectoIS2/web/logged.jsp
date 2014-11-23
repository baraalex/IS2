<%
    HttpSession sesion = request.getSession();
    if(sesion.getAttribute("user")==null){
        // New location to be redirected
        String site = new String("./");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
    }
    else{
%>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>

<html lang="en">
<head>
    <title>SEGECA - Home</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/sessions.js"></script>

</head>
<body>
<div class="container">
    <nav class="navbar navbar-default" role="navigation" style="margin-bottom: 0">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" style="cursor: default">SEGECA IS2</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Home<span class="sr-only">(current)</span></a></li>
                    <li><a href="CCC.jsp">CCC</a></li>
                    <li><a href="PC.jsp">PC</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right" onclick="exit()">
                    <li><a class="navbar-brand" href="index.jsp">exit</a></li>
                </ul>
            </div>

            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"></h3>
        </div>
        <div class="panel-body">

            <div class="col-sm-8">
                <div class="panel panel-default" style="padding-top: 0;">
                    <div class="panel-heading">Informacion Personal</div>
                    <div class="panel-body">
                        <div id="personal"></div>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-default" style="padding-top: 0;">
                    <div class="panel-heading">Tus CCCs</div>
                    <div id="cccs"></div>
                </div>
            </div>


        </div>
    </div>
</div>
</body>
</html>
<% } %>