

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javacode.Server" %>
<% 
boolean status = Server.status;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Start Page</title>
<!--        <script type="text/javascript" src="resources/jquery.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                var status = <%= status%>;
                status = status.toString().trim();
                alert(status);
            });
        </script>-->
    </head>
    <body>
    <!--<div id="container" style="width:80%;height:100%;border:solid;border-width:2px;">-->
             <div id="header" align="top" style="width:100%;height:10%;border:solid;border-width:2px;background-color: #AD7460;">
              <h1>Game Rules</h1>               
             </div>
 <div id="main" style="width:100%;height:80%;">
                <div id="tableDiv" style="width:100%;height:100%;border:solid;border-width:2px;float:left;background-color: #F5D5BC;">
                    <table>
                        
                        <tr><th>Step-1</th><td><h4> Remember the Tiles in 15 seconds and the game starts</h4></td></tr>
                        <tr><th>Step-2</th><td><h4> You can see all the online players in the right pane and wish to start the game</h4></td></tr>
                        <tr><th>Step-3</th><td><h4> After that you have 35 seconds to finish off the game by matching the tiles</h4></td></tr>
                        <tr><th>Step-4</th><td><h4>Good Luck and press click enter to start the game</h4></td></tr>
                        <tr><td></td></tr>
       
       
                    </table>
   
      
                    <center> <img src="resources\game1.png"/></td></tr></center>
              
         
   
 
   
        
        <form name="submit" action="game.jsp" method="post">
		<!--<img src="resources\pairmen.jpg" />-->
		<br>
                //player enters the game on clicking the enter button.
		<input type="submit" id="enter" value="Enter"/>
	</form>
 </div>
 </div>    
    </body>
</html>
