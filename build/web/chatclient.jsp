<%@page import="javacode.Client"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	Client client = new Client();
        int id = client.connect();
        String player = "player"+id;
        session.setAttribute("client", client);
        session.setAttribute("id", id);
        session.setAttribute("player", player);
%>
<%= id%>

<script type="text/javascript"></script>
<script type="text/javascript" src="resources/jquery.js"></script>
<script type="text/javascript">
    $(document).ready(function (){
        
        $("#send").click(function(){
           $.post("nextpage.jsp",{data:$("#input").val()},function(data){
			$("#output").val(data);
            });
        });
        
    });
</script>

<html>
    <head>
        
    </head>
    <body>
        <br>
        <input type="text" name="input" id="input"/>
        <input type="button" value="send" id="send" />
        <input type="text" name="output" id="output" />
    </body>
</html>
