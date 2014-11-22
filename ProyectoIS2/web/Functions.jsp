<%@ page import="es.upm.etsiinf.is2.grupo11.enums.AppEnums" %>
<%@ page import="es.upm.etsiinf.is2.grupo11.handlers.Database" %>
<%@ page import="java.util.HashMap" %>
<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 6/11/14
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    AppEnums action = .AppEnums.valueOf(request.getParameter("action"));
    switch (action) {
        case LOGIN:
            String usr = request.getParameter("username");
            String pass = request.getParameter("password");
            if (usr != null && pass != null && usr.length() > 0 && pass.length() > 0) {
                //TODO comprobar usr y passd
                if (Database.getInstance().login(usr, pass)) {
                    request.getSession().setAttribute("user", usr);
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
        case EXIT:
            System.out.println("sale");
            request.getSession().setAttribute("user", null);
            break;
        case CCSINFO:
            String user = (String) request.getSession().getAttribute("user");
            HashMap<String, Boolean> info = Database.getInstance().getUserCCCs(user);
            out.println("&&&");
            for (String s : info.keySet()) {
                out.println("<div style=\"height: 38;\"> <span class=\"label label-success form-control\" style=\"font-size: large;\">" + s
                        + "</span></div>");
            }
            out.println("&&&");

            break;
        case INFO:
            String user2 = (String) request.getSession().getAttribute("user");

            HashMap<String, String> infouser = Database.getInstance().getUser(user2);
            out.println("&&&");
            if (infouser.get("Tipo").equals("1"))
                out.println("<h1 style=\"padding-bottom: 5%;\"><span class=\"label label-danger\">Administrador</span></h1>");
            for (String s : infouser.keySet()) {
                if (!s.equals("Tipo")) {
                    out.println("<div class=\"input-group input-group-lg\" style=\"padding-bottom: 5;\">" +
                            "  <span class=\"input-group-addon\">" + s + "</span>");
                    out.println(
                            "<span class=\"label label-primary form-control\" style=\"font-size: large;\">" +
                                    infouser.get(s) + "</span>");
                    out.println(
                            "    </div><!-- /input-group -->");
                }
            }
            out.println("&&&");
            break;
    }
%>