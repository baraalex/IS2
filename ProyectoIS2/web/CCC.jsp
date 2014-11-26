<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("user") == null) {
        // New location to be redirected
        String site = new String("./");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
    } else {
%>
<%@ page import="es.upm.etsiinf.is2.grupo11.handlers.Database" %>
<%@ page import="java.util.HashMap" %>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 22/11/14
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>SEGECA - CCCs</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootbox.js"></script>
    <script type="text/javascript" src="js/CCC.js"></script>

</head>
<body>
<%
    String user = (String) sesion.getAttribute("user");

%>

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
                    <li><a href="logged.jsp">Home</a></li>
                    <li class="active"><a href="#">CCC<span class="sr-only">(current)</span></a></li>
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

            <div id="errorcreate" class="alert alert-danger" role="alert" style="display: none;margin-top: 2%">
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Error:</span>
                <strong>Error at create CCC.</strong> Please try again later.
            </div>
            <div id="erroraddusr" class="alert alert-danger" role="alert" style="display: none;margin-top: 2%">
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Error:</span>
                <strong>Error adding user to CCC.</strong> Please try again later.
            </div>

            <div class="form-group">
                <label for="sel1">Select CCC to show</label>

                <div style="display: flex;">
                    <select class="form-control col-md-4" id="sel1" style="width: inherit;" onchange="cccInfo()">
                        <option value=""></option>

                        <%
                            HashMap<String, Boolean> ccc = Database.getInstance().getUserCCCs(user);
                            for (String s : ccc.keySet()) {
                        %>
                        <option value="<%=s%>"><%=s%>
                        </option>
                        <%
                            }
                        %>
                    </select>

                    <div class="col-md-4" id="deleteCCC"></div>

                    <div class="input-group col-md-4">
                        <input type="text" id="nuevoCCC" class="form-control" value="">
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="button" onclick="addCCC()"><span
                                    class="glyphicon glyphicon-plus" aria-hidden="true"></span> Añadir CCC
                            </button>
                        </span>
                    </div>
                    <!-- /input-group -->
                </div>
            </div>


            <div class="col-sm-6">
                <div class="panel panel-default" style="padding-top: 0;">
                    <div class="panel-heading">Usuarios del CCC seleccionado</div>
                    <div id="CCCInfo"></div>
                </div>
            </div>

            <div id="CCCUsradd" class="col-md-4"></div>

        </div>
    </div>
</div>
</div>
</body>
</html>
<% } %>