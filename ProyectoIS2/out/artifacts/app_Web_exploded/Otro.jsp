<%@ page import="enums.Ejemplo" %>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    Ejemplo ej = Ejemplo.valueOf(request.getParameter("name"));
    switch (ej) {
        case LOGIN:
            String usr = request.getParameter("username");
            String pass = request.getParameter("password");
            System.out.println("user: " + usr);
            System.out.println("pass: " + pass);
            if (usr != null && pass != null && usr.length() > 0 && pass.length() > 0) {
               //TODO comprobar usr y passd
                System.out.println("ok");
                out.println("&&&OK&&&");
            } else
                out.println("&&&NOTOK&&&");
            System.out.println("pasa");
            break;
        case REGISTRO:
            break;

    }
%>