<%@ page import="es.upm.etsiinf.is2.grupo11.enums.AppEnums" %>
<%@ page import="es.upm.etsiinf.is2.grupo11.handlers.Database" %>
<%@ page import="java.util.ArrayList" %>
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
    AppEnums action = AppEnums.valueOf(request.getParameter("action"));
    switch (action) {
        case LOGIN:
            String usr = request.getParameter("username");
            String pass = request.getParameter("password");
            if (usr != null && pass != null && usr.length() > 0 && pass.length() > 0) {
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
            request.getSession().setAttribute("user", null);
            break;
        case CCSINFO:
            String user = (String) request.getSession().getAttribute("user");
            HashMap<String, Boolean> info = Database.getInstance().getUserCCCs(user);
            out.println("&&&");
            out.println("<ul class=\"list-group\" style=\"margin-bottom: 0;\">");
            for (String s : info.keySet()) {
                if (info.get(s))
                    out.println("<li class=\"list-group-item list-group-item-info\">" + s + " <b style=\"font-size: small;\">(Administrador)</b></li>");
                else
                    out.println("<li class=\"list-group-item\">" + s + "</li>");

            }
            out.println("</ul>");
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
        case CCC:
            String ccc = request.getParameter("ccc");
            HashMap<String, Boolean> users = Database.getInstance().getCCCUserss(ccc);
            out.println("&&&");

            for (String s : users.keySet()) {
                out.println("<div class=\"input-group\">");
                if (users.get(s))
                    out.println("<span class=\"label label-warning form-control\" style=\"font-size: large;\">" + s +
                            " <b style=\"font-size: small;\">(Administrador)</b></span><span class=\"input-group-addon\"></span>");
                else
                    out.println("<span class=\"label label-default form-control\" style=\"font-size: large;\">" + s +
                            "</span>" + "<span class=\"input-group-btn\">\n" +
                            "<button class=\"btn btn-default\" type=\"button\" onclick=\"deleteUser('" + s + "')\">Borrar del CCC</button>" +
                            "</span>");
                out.println("</div>");
            }
            out.println("&&&");

            String user3 = (String) request.getSession().getAttribute("user");
            if (!ccc.equals("") && users.get(user3))
                out.println("<button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteCCC('" + ccc +
                        "')\">Borrar CCC</button>");

            out.println("&&&");

            break;

        case DELETEUSRCCC:
            String CCC = request.getParameter("ccc");
            String user_ = request.getParameter("usr");
            Database.getInstance().deleteUserCCC(CCC, user_);
            break;
        case DELETECCC:
            String deleteccc = request.getParameter("ccc");
            Database.getInstance().deleteCCC(deleteccc);
            break;
        case ADDCCC:
            String addccc = request.getParameter("ccc");
            if (!Database.getInstance().createCCC(addccc, (String) request.getSession().getAttribute("user")))
                out.println("&&&NOTOK&&&");
            else
                out.println("&&&OK&&&");
            break;
        case ADDPCFORM:
            String a = "<form name=\"nuevapet\" action=\"#\" method=\"post\" style=\"padding-top: 2%\" onsubmit=\"return newPC(this)\">" +
                    "<div class=\"panel panel-success\"><div class=\"panel-heading\"><h3 class=\"panel-title\">" +
                    "Nueva PC</h3></div><div class=\"panel-body\"><div class=\"input-group\">" +
                    "<span class=\"input-group-addon\"><span class=\"glyphicon glyphicon-calendar\"></span></span>" +
                    "<input type=\"date\" id=\"fecha\" name=\"fecha\" class=\"form-control\" placeholder=\"Fecha\" " +
                    "required=\"\" value=\"\"></div><div class=\"input-group\" style=\"padding-top: 1%\">" +
                    "<span class=\"input-group-addon\"><span class=\"glyphicon glyphicon-pencil\"></span></span>" +
                    "<textarea type=\"text\" id=\"desc\" name=\"desc\" class=\"form-control\" " +
                    "placeholder=\"Descripcion breve (Max 500 caracteres)\" required=\"\" value=\"\" maxlength=\"500\">" +
                    "</textarea></div><div class=\"input-group\" style=\"padding-top: 1%\"><span class=\"input-group-addon\">" +
                    "<span class=\"glyphicon glyphicon-pencil\"></span></span><textarea type=\"text\" id=\"motivo\" " +
                    "name=\"motivo\" class=\"form-control\" placeholder=\"Motivo de la Peticion de cambio\" " +
                    "required=\"\" value=\"\" maxlength=\"2000\"></textarea></div>" +
                    "<div class=\"input-group\" style=\"padding-top: 1%\">" +
                    "<select name=\"ccc\" class=\"form-control\" id=\"ccc\" style=\"width: inherit;\">" +
                    "<option value=\"\"></option>";

            String b = "</select></div><div style=\"padding-top: 2%\">" +
                    "<input class=\"btn btn-lg btn-primary btn-block\" type=\"submit\" value=\"Register\">\n" +
                    "</div></div></div></form>";
            out.println("&&&");
            out.println(a);
            ArrayList<String> cccs = Database.getInstance().getCCCs();
            for (String s : cccs) {
                out.println("<option value='" + s + "'>" + s + "</option>");
            }
            out.println(b);
            out.println("&&&");
            break;
        case ADDPC:
            String date = request.getParameter("date");
            String descr = request.getParameter("descr");
            String motivo = request.getParameter("mot");
            String ccc_ = request.getParameter("CCC");

            if (ccc_ != null && !ccc_.equals("") && Database.getInstance().createPC(date.replace("-", "/"), descr,
                    motivo, ccc_, (String) request.getSession().getAttribute("user"), null)) {
                out.println("&&&OK&&&");
            } else
                out.println("&&&NOTOK&&&");
            break;


    }
%>