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
        case EJEMPLO:
            System.out.println("pasa");
            break;
    }
%>