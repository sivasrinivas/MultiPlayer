
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
                var interval = setInterval(function(){
                    $.post("comm.jsp",{command:"scores"},function(data){
                        var scores = data.toString();
                        scores = scores.trim();
                        
                        $("#scores").html(scores);
                    });
                }, 1000);
            });
        </script>
    </head>
    <body>
        <h1>Scores</h1>
        <div id="scores">
            
        </div>
    </body>
</html>
