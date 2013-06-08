

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javacode.Client" %>
<%
String id = session.getAttribute("id").toString();
%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Players</title>
        <script type="text/javascript" src="resources/jquery.js"></script>
        <script type="text/javascript">
            $(document).ready(function (){
                var id=<%= id%>;
                id = parseInt(id.toString().trim());
                var i=0;
                var playerInterval = setInterval(function(){
                    //sends players command to comm.jsp to fetch the players list.
                    $.post("comm.jsp",{command:"players"},function(data){
                        var playersList = data.toString();
                        playersList = playersList.trim();
                        
                        $("#players").html(playersList);
                    });
                }, 3000);
            });
        </script>
    </head>
    <body>
        <h1>Players List</h1>
        <div id="players">
            
        </div>
    </body>
</html>