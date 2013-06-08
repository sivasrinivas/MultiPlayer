
<%@page import="javacode.Client" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String line = request.getParameter("data");
    Client client = (Client)session.getAttribute("client");
    client.send(line);
    line = client.get();
%>
<%=line%>