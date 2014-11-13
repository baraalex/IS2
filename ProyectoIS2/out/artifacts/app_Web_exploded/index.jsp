<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%--<!DOCTYPE html>--%>
<%--<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->--%>
<%--<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->--%>
<%--<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->--%>
<%--<!--[if gt IE 8]><!-->--%>
<html lang="en"> <!--<![endif]-->
<head>
    <%--<meta charset="utf-8">--%>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--%>
    <title>Login Form</title>
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>

    <%--<!--[if lt IE 9]><!--<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>--><![endif]-->--%>
</head>
<body>
<section class="container">

    <div id="error" style="display: none; width:80%;margin: -20px auto 21px;line-height: 40px;font-size: 15px;font-weight: bold;
color: #555;text-align: center;text-shadow: 0 1px white;background: #f3f3f3;">
        <h1>Username or password invalid. Please login again</h1>
    </div>

    <div id="login" class="login" style="display: block">
        <h1>Login to Web App</h1>

        <form name="log" action="Operations.jsp" onsubmit="return login(this)"  method="post">
            <p><input id="usrname" type="text" name="username" value="" placeholder="Username" required=""></p>

            <p><input id="password" type="password" name="password" value="" placeholder="Password" required=""></p>

            <p class="submit">
                <input type="submit" name="commit" value="Login" >
            </p>
        </form>

    </div>
    <div id="reg" class="login-help" style="cursor: default;">
        <p>Are you not registered? <a style="cursor: pointer;" onclick="goregister()">Click here to Register</a>.</p>
    </div>
</section>
</body>
</html>
