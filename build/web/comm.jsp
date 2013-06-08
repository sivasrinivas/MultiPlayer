

<%@page import="java.util.concurrent.locks.ReentrantLock"%>
<%@page import="java.util.concurrent.locks.Lock"%>
<%@page import="javacode.Client" %>
<%@page import="java.util.Hashtable" %>
<%@page import="java.util.concurrent.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    Lock lock = new ReentrantLock();

    String resp = "";
    String command = request.getParameter("command");
    Client client = (Client) session.getAttribute("client");
    if (command.equalsIgnoreCase("wait")) {
        // waiting for the start command from server
        resp = client.get();
    } else if (command.equalsIgnoreCase("start")) {
        // start button clicked, sent to server
        client.send(command);
    } else if (command.equalsIgnoreCase("seed")) {
        //requesting seed and getting the seed in response.
        client.send(command);
        resp = client.get();
    } else if (command.equalsIgnoreCase("score")) {
        client.send(command);
        resp = client.get();
    } else if (command.equalsIgnoreCase("players")) {
        //requesting players list and getting the updated list.
        client.send(command);
        resp = client.get();
    } else if (command.equalsIgnoreCase("gameend")) {
        //sending gameend command when the game ends.
        String score = request.getParameter("sc");
        client.send(command);
        //sending the score to server once the game ends. 
        client.send(score);
        //resp = client.get();
    } else if (command.equalsIgnoreCase("exit")) {
        //sending the exit command when the player wishes to exit the game.
        client.send(command);
    }
%>
<%= resp%>
