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
    <title>Registro</title>
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
</head>
<body>

<section class="container">
    <div id="register" class="login">
        <h1>Register</h1>

        <form name="regist" METHOD="post" action="index.jsp">
            <p><input type="text" name="userName" value="" placeholder="Username" required=""></p>

            <p><input type="email" name="email" value="" placeholder="Email" required=""></p>

            <p><input type="text" name="realName" value="" placeholder="Nombre completo" required=""></p>

            <p><input type="text" name="realName" value="" placeholder="Telefono" required=""></p>

            <p><input type="password" name="password" value="" placeholder="Password" required=""></p>

            <p><input type="password" name="passwordConfirm" value="" placeholder="Confirm password" required=""></p>

            <p class="submit">
                <input type="submit" name="commit" value="Login" onclick="register(this.form)">
            </p>
        </form>
    </div>
    <div id="log" class="login-help" style="cursor: pointer;">
        <p><a onclick="loginagain()">Click here to go back to Login</a>.</p>
    </div>
</section>
</body>
</html>