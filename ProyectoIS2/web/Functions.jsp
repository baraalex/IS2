<%@ page import="es.upm.etsiinf.is2.grupo11.enums.AppEnums" %>
<%@ page import="es.upm.etsiinf.is2.grupo11.enums.PCestados" %>
<%@ page import="es.upm.etsiinf.is2.grupo11.handlers.Database" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
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
            String usr = request.getParameter("username").toLowerCase();
            String pass = request.getParameter("password");


            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] array = md.digest(pass.getBytes("UTF-8"));

                StringBuilder sb = new StringBuilder();
                for (byte anArray : array) {
                    sb.append(Integer.toHexString((anArray & 0xFF) | 0x100).substring(1, 3));
                }
                pass = sb.toString();
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }

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
            String usr1 = request.getParameter("username").toLowerCase();
            String pass1 = request.getParameter("password");
            String email = request.getParameter("email");
            String nombre = request.getParameter("nombre");
            int telf = Integer.valueOf(request.getParameter("telf"));

            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] array = md.digest(pass1.getBytes("UTF-8"));

                StringBuilder sb = new StringBuilder();
                for (byte anArray : array) {
                    sb.append(Integer.toHexString((anArray & 0xFF) | 0x100).substring(1, 3));
                }
                pass1 = sb.toString();
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }

            if (Database.getInstance().register(usr1, pass1, email, telf, nombre))
                out.println("&&&OK&&&");
            else
                out.println("&&&NOTOK&&&");
            break;
        case EXIT:
            request.getSession().setAttribute("user", null);
            break;
        case INICIO:
            String user = (String) request.getSession().getAttribute("user");

            HashMap<String, String> infouser = Database.getInstance().getUser(user);
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

            HashMap<String, Boolean> info = Database.getInstance().getUserCCCs(user);
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
        case CCC:
            String ccc = request.getParameter("ccc");
            HashMap<String, String> users = Database.getInstance().getCCCUserss(ccc);
            out.println("&&&");
            String user3 = (String) request.getSession().getAttribute("user");

            for (String s : users.keySet()) {
                out.println("<div class=\"input-group\">");
                if (users.get(s).equals("Administrador"))
                    out.println("<span class=\"label label-warning form-control\" style=\"font-size: large;\">" + s +
                            " <b style=\"font-size: small;\">(Administrador)</b></span><span class=\"input-group-addon\"></span>");
                else {
                    out.println("<span class=\"label label-default form-control\" style=\"font-size: large;\">" + s);
                    if (!users.get(s).equals("Usuario"))
                        out.println(" (" + users.get(s) + ")");
                    out.println("</span>");

                    if (users.get(user3).equals("Administrador"))
                        out.println("<span class=\"input-group-btn\">" +
                                "<button class=\"btn btn-default\" type=\"button\" onclick=\"deleteUser('" + s + "')\">Borrar del CCC</button>" +
                                "</span>");
                    else
                        out.println("<span class=\"input-group-addon\"></span>");
                }
                out.println("</div>");
            }
            out.println("&&&");

            if (!ccc.equals("") && users.get(user3).equals("Administrador")) {
                out.println("<button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteCCC('" + ccc +
                        "')\">Borrar CCC</button>");
                out.println("&&&");
                out.println("<div class=\"input-group\" style=\"width: 100%;\">" +
                        "<div><select name=\"newuserCCC\" class=\"form-control\" id=\"newuserCCC\" style=\"width: initial;\">" +
                        "<option value=\"\"></option>");
                ArrayList<String> userstoadd = Database.getInstance().getUsers();
                for (String s : userstoadd) {
                    if (!users.keySet().contains(s))
                        out.println("<option value='" + s + "'>" + s + "</option>");
                }

                out.println("</select><span class=\"input-group-btn\"><button class=\"btn btn-info\" type=\"button\"" +
                        "onclick=\"addusr('" + ccc + "')\">" +
                        "<span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span> Añadir Usuario CCC</button>" +
                        "</span></div>");
                out.println("<div><div class=\"radio\"><label>" +
                        "<input type=\"radio\" name=\"opciones\" id=\"opciones_1\" value=\"Usuario\" checked>" +
                        "Usuario Normal</label></div>");

                if (!users.containsValue("Presidente"))
                    out.println("<div class=\"radio\"><label>" +
                            "<input type=\"radio\" name=\"opciones\" id=\"opciones_2\" value=\"Presidente\">" +
                            "Presidente</label></div>");

                if (!users.containsValue("Secretario"))
                    out.println("<div class=\"radio\"><label>" +
                            "<input type=\"radio\" name=\"opciones\" id=\"opciones_3\" value=\"Secretario\">" +
                            "Secretario</label></div></div>");

                out.println("</div>");
            } else {
                out.println("<div></div> ");
                out.println("&&&");
                out.println("<div></div> ");
            }

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
                    "<select name=\"ccc\" class=\"form-control\" id=\"ccc\" style=\"width: initial;\">" +
                    "<option value=\"\"></option>";

            String b = "</select></div><div style=\"padding-top: 2%\">" +
                    "<input class=\"btn btn-lg btn-primary btn-block\" type=\"submit\" value=\"AddPC\">\n" +
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
        case USERPC:
            out.println("&&&");
            HashMap<Integer, HashMap<String, String>> userPC =
                    Database.getInstance().getUserPC((String) request.getSession().getAttribute("user"));
            out.println("<div class=\"col-md-6\"><div class=\"panel panel-primary\"><div class=\"panel-heading\">" +
                    "Tus PC</div><div class=\"panel-body\" style=\"overflow: auto;height: 70%;\"><div class=\"list-group\">");
            for (int i : userPC.keySet()) {
                String estado = userPC.get(i).get("Estado");
                if (estado.equals(PCestados.evaluacion.toString())) {
                    out.println("<a href=\"#\" class=\"list-group-item list-group-item-info\" style=\"color:#000000;overflow: auto;\" onclick=\"InfoPc('" + i + "')\">");
                } else if (estado.equals(PCestados.aceptado.toString())) {
                    out.println("<a class=\"list-group-item list-group-item-success\" style=\"color:#000000;overflow: auto;\">");

                } else if (estado.equals(PCestados.rechazado.toString())) {
                    out.println("<a class=\"list-group-item list-group-item-danger\" style=\"color:#000000;overflow: auto;\">");

                }
                out.println("<b>Id: </b><span class=\"badge\" style=\"float: initial;\">" + i + "</span><br>");
                for (String s : userPC.get(i).keySet()) {
                    if (!s.equals("Historial"))
                        out.println("<b>" + s + ": </b>" + userPC.get(i).get(s) + "<br>");
                    else
                        out.println("<b>" + s + ": </b>" + userPC.get(i).get(s).replaceAll("&&&", "->") + "<br>");
                }

                out.println(" </a>");
            }
            out.println("</div></div></div></div>");
            HashMap<String, Boolean> userccc = Database.getInstance().getUserCCCs((String) request.getSession().getAttribute("user"));
            out.println("<div class=\"col-md-6\"><div class=\"panel panel-primary\"><div class=\"panel-heading\">" +
                    "PC de CCC que administras</div><div class=\"panel-body\" style=\"overflow: auto;height: 70%;\"><div class=\"list-group\">");
            for (String s : userccc.keySet())
                if (userccc.get(s)) {
                    HashMap<Integer, HashMap<String, String>> cccPC = Database.getInstance().getcccPC(s);
                    for (int i : cccPC.keySet()) {
                        String estado = cccPC.get(i).get("Estado");
                        if (estado.equals(PCestados.evaluacion.toString())) {
                            out.println("<a href=\"#\" class=\"list-group-item list-group-item-info\" style=\"color:#000000;overflow: auto;\" onclick=\"InfoPcEstado('" + i + "')\">");
                        } else if (estado.equals(PCestados.aceptado.toString())) {
                            out.println("<a class=\"list-group-item list-group-item-success\" style=\"color:#000000;overflow: auto;\">");

                        } else if (estado.equals(PCestados.rechazado.toString())) {
                            out.println("<a class=\"list-group-item list-group-item-danger\" style=\"color:#000000;overflow: auto;\">");

                        }
                        out.println("<b>Id: </b><span class=\"badge\" style=\"float: initial;\">" + i + "</span><br>");
                        for (String st : cccPC.get(i).keySet()) {
                            if (!st.equals("Historial"))
                                out.println("<b>" + st + ": </b>" + cccPC.get(i).get(st) + "<br>");
                            else
                                out.println("<b>" + st + ": </b>" + cccPC.get(i).get(st).replaceAll("&&&", "->") +
                                        "<br>");
                        }

                        out.println(" </a>");
                    }
                }
            out.println("</div></div></div></div>");

            out.println("&&&");
            break;
        case ADDUSRCCC:
            String addduserccc = request.getParameter("usr");
            String ccctoadd = request.getParameter("ccc");
            String roltoadd = request.getParameter("rol");
            System.out.println("Rol: " + roltoadd);
            System.out.println("ccc: " + ccctoadd);
            if (!Database.getInstance().addUserCCC(ccctoadd, addduserccc, roltoadd))
                out.println("&&&NOTOK&&&");
            else
                out.println("&&&OK&&&");

            break;

        case PCINFO:
            out.println("&&&");
            String id = request.getParameter("id");

            HashMap<String, String> info2 = Database.getInstance().getPC(id);
            out.println("<div class=\"col-md-6\"><div class=\"panel panel-primary\"><div class=\"panel-heading\">" +
                    "Informacion de la PC</div><div class=\"panel-body\"><div class=\"list-group\">");
            out.println("<a class=\"list-group-item list-group-item-info\" style=\"color:#000000;overflow: auto;\">");
            out.println("<b>Id: </b><span class=\"badge\" style=\"float: initial;\">" + id + "</span><br>");
            for (String st : info2.keySet()) {
                out.println("<b>" + st + ": </b>" + info2.get(st) + "<br>");
            }
            out.println(" </a>");
            out.println("</div></div></div></div>");

            out.println("<div class=\"radio\"><label>" +
                    "<input type=\"radio\" name=\"estado\" id=\"opciones_2\" value=\"" + PCestados.aceptado + "\" checked>" +
                    "Aceptado</label></div>");

            out.println("<div class=\"radio\"><label>" +
                    "<input type=\"radio\" name=\"estado\" id=\"opciones_3\" value=\"" + PCestados.rechazado + "\">" +
                    "Rechazado</label></div></div>");

            out.println("</div>");

            out.println("<button type=\"button\" class=\"btn btn-default\" onclick=\"modificarEstadoPc('" + id +
                    "')\">Cambiar Estado</button>");

            out.println("&&&");

            break;

        case MODIFYPCESTADO:
            String id2 = request.getParameter("id");
            PCestados estado = PCestados.valueOf(request.getParameter("estado"));
            System.out.println(id2 + ": " + estado);
            if (Database.getInstance().modifyPCEstado(Integer.valueOf(id2), estado))
                out.println("&&&OK&&&");
            else
                out.println("&&&NOTOK&&&");
            break;
        case PCINFO2:
            out.println("&&&");
            String id3 = request.getParameter("id");

            HashMap<String, String> info3 = Database.getInstance().getPC(id3);
            out.println("<div class=\"col-md-6\"><div class=\"panel panel-primary\"><div class=\"panel-heading\">" +
                    "Informacion de la PC</div><div class=\"panel-body\"><div class=\"list-group\">");
            out.println("<a class=\"list-group-item list-group-item-info\" style=\"color:#000000;overflow: auto;\">");
            out.println("<b>Id: </b><span class=\"badge\" style=\"float: initial;\">" + id3 + "</span><br>");
            for (String st : info3.keySet()) {
                out.println("<b>" + st + ": </b>" + info3.get(st) + "<br>");
            }
            out.println(" </a>");
            out.println("</div></div></div></div>");


            String o = "<div class=\"col-md-6\"><form name=\"petmodif\" action=\"#\" method=\"post\" onsubmit=\"return ModifyPC(this,'" + id3 + "')\">" +
                    "<div class=\"panel panel-success\"><div class=\"panel-heading\"><h3 class=\"panel-title\">" +
                    "Modificar PC</h3></div><div class=\"panel-body\"><div class=\"input-group\" style=\"padding-top: 1%\">" +
                    "<span class=\"input-group-addon\"><span class=\"glyphicon glyphicon-pencil\"></span></span>" +
                    "<textarea type=\"text\" id=\"desc\" name=\"desc\" class=\"form-control\" " +
                    "placeholder=\"Descripcion breve (Max 500 caracteres)\" value=\"\" maxlength=\"500\">" +
                    "</textarea></div><div class=\"input-group\" style=\"padding-top: 1%\"><span class=\"input-group-addon\">" +
                    "<span class=\"glyphicon glyphicon-pencil\"></span></span><textarea type=\"text\" id=\"motivo\" " +
                    "name=\"motivo\" class=\"form-control\" placeholder=\"Motivo de la Peticion de cambio\" " +
                    "value=\"\" maxlength=\"2000\"></textarea></div><div style=\"padding-top: 2%\">" +
                    "<input class=\"btn btn-lg btn-primary btn-block\" type=\"submit\" value=\"Modify\">\n" +
                    "</div></div></div></form></div>";

            out.println(o);


            out.println("&&&");

            break;

        case MODIFYPC:
            String id4 = request.getParameter("id");
            String descrpc = request.getParameter("descr");
            String motivopc = request.getParameter("mot");
            System.out.println("id: " + id4 + " Descrip: " + descrpc + " Motivo: " + motivopc);

            if ((!descrpc.equals("") || !motivopc.equals("")) && Database.getInstance().modifyPC(Integer.valueOf(id4), motivopc, descrpc))
                out.println("&&&OK&&&");
            else
                out.println("&&&NOTOK&&&");

            break;

    }
%>