
<% response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
response.setHeader("Pragma","no-cache"); //HTTP 1.0 
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javacode.Client"%>
<%
    Client client = (Client) session.getAttribute("client");
    client.send("getscores");
    String scoresList = client.get().trim();
    client.send("exit");

%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="resources/jquery.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                
            });


        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Player - Score</h1>
        <div id="scores"></div>
        <!--Server generates players scores graph -->
        <img src="resources/iqimg.png" width="600" height="400" border="0" alt="COULD NOT FETCH IMAGE">
    </body>
</html>
