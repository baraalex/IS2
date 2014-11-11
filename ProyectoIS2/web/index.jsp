<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Paper Stack</title>
    <script type="text/javascript" src="js/js.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
</head>
<body>
<div class="container">
    <section id="content">
        <form method="get" action="Operations.jsp">
            <h1>Login Form</h1>

            <div>
                <input type="text" placeholder="Username" required="" id="username" name="username"/>
            </div>
            <div>
                <input type="password" placeholder="Password" required="" id="password" name="password"/>
            </div>
            <div>
                <input type="submit" value="Log in"/>
                <a id="lost" href="#" onclick="login()">Lost your password?</a>
                <a id="reg" href="#">Register</a>
            </div>
        </form>
        <!-- form -->
        <div class="button">
            <a href="#">Download source file .</a>
        </div>
        <!-- button -->
    </section>
    <!-- content -->
</div>
<!-- container -->
</body>
</html>