<%@ page import="enums.AppEnums" %>
<%@ page import="es.upm.etsiinf.is2.grupo11.handlers.Database" %>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    enums.AppEnums action = enums.AppEnums.valueOf(request.getParameter("action"));
    switch (action) {
        case LOGIN:
            String usr = request.getParameter("username");
            String pass = request.getParameter("password");
            if (usr != null && pass != null && usr.length() > 0 && pass.length() > 0) {
                //TODO comprobar usr y passd
                if (Database.getInstance().login(usr, pass)) {
                    out.println("&&&OK&&&");
                } else
                    out.println("&&&NOTOK&&&");
            } else
                out.println("&&&NOTOK&&&");
            break;
        case REGISTRO:
            String usr1 = request.getParameter("username");
            String pass1 = request.getParameter("password");
            String email = request.getParameter("email");
            String nombre = request.getParameter("nombre");
            int telf = Integer.valueOf(request.getParameter("telf"));

            if (Database.getInstance().register(usr1, pass1, email, telf, nombre))
                out.println("&&&OK&&&");
            else
                out.println("&&&NOTOK&&&");
            break;
    }
%>