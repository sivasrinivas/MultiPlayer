

<%@page import="javacode.Client"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//creates an object for client and set it as session attribute for further use of communicating with server
    Client client = new Client();
    int id = client.connect();
    String player = "player" + id;
    session.setAttribute("client", client);
    session.setAttribute("id", id);
    session.setAttribute("player", player);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Game Page</title>

        <link rel="stylesheet" type="text/css" href="resources/style.css"></link>
        <script type="text/javascript" src="resources/jquery.js"></script>
        <script type="text/javascript" src="resources/jquery.min.js"></script>
        <script type="text/javascript" src="resources/jquery.timer.js"></script>
        <script type="text/javascript" src="resources/imagescript.js"></script>
        <script type="text/javascript">
            var playersTimer;
            var score = 0;
            var count = 0;
            keys1 = [];
            keys2 = [];
            values1 = [];
            values2 = [];
            $(document).ready(function() {
                $("#table").hide();
                $("#dummytable").hide();
                // Wait for the start command from server, if it receives game starts automatically
                $.post("comm.jsp", {command: "wait"}, function(data) {
                    var resp = data.toString();
                    resp = resp.trim();
                    // Game starts when start command is received from server.
                    if (resp === "start") {
                        $("#startButton").hide();
                        var seconds = 3, second = 1;
                        var interval = setInterval(function() {
                            document.getElementById("gamestart").innerHTML = 'Game Starts in  ' + (seconds - second) + ' seconds';
                            if (second >= seconds) {
                                clearInterval(interval);
                                $("#gamestart").hide();
                                $("#dummytable").show();
                                //get the random number from server to shuffle tiles
                                setSeed();
                                //once game starts, timer will be started
                                timer.play();
                            }
                            second++;
                        }, 1000);
                    }
                    //Once the game starts, the player needs to wait for the next session
                    else if (resp === "inprogress") {
                        alert("Game in progress...try after sometime...");
                    }
                });
                //start button clicked, start command sent to server via comm.jsp
                $("#startButton").click(function() {
                    $.post("comm.jsp", {command: "start"}, function(data) {
                        var resp = data.toString().trim();
                        if (resp === "inprogress") {
                            alert("Game in progress...try after sometime...");
                        }
                    });
                });

                var timer = $.timer(function() {
                    count++;
                    $('.count').html(count);
                    if (count === 1) {
                        timing();
                        //tile images and corresponding rear numbers displayed
                        setDummyImages(keys1, values1);
                    }
                    if (count === 15) {
                        $("#dummytable").hide();
                        $("div.imgdiv").css({"height": "100px", "width": "100px"});
                        //tiles will be shuffled and new table with shuffled tiles will be shown
                        $("#table").show(1000);
                        setImages(keys2, values2);
                    }
                    if (count === 40) {
                        //game ends when count hits 40
                        clearInterval(playersTimer);
                        timer.stop();
                        stopPlaying();
                    }

                });
                timer.set({time: 1000, autostart: false});
                //Player decides to leave, clicks exit button. exit command sent to server to close client socket
                $("#exit").click(function() {
                    var result = window.confirm("Do you really want to exit?");
                    if (result == true) {
                        clearInterval(playersTimer);
                        $.post("comm.jsp", {command: "exit"}, function(data) {

                        });
                        timer.stop();
                        window.close();
                    } else {
                    }
                });
            });
        </script>
        <script type="text/javascript">
            
            //timer to update players list concurrently
            function timing(){
                playersTimer = setInterval(function(){
                    $.post("comm.jsp",{command:"players"},function(data){
                        var playersList = data.toString();
                        playersList = playersList.trim();
                        $("#playersList").html(playersList);
                    });
                },1000);
            }
            //shuffles the tiles by getting the seed from server.
            function setSeed() {
                $.post("comm.jsp", {command: "seed"}, function(data) {
                    
                    shuffle = function(o){ //v1.0
                        for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
                        return o;
                    };

                    var seed = data.toString();
                    seed = seed.trim();
                    keys1.push("aaple", "banana", "clouds", "deer", "dog", "eagle", "light", "tea", "train", "zebra");
                    values1.push(1, 2, 3, 4, 5, 1, 2, 3, 4, 5);
                   
                    keys2.push("aaple", "banana", "clouds", "deer", "dog", "eagle", "light", "tea", "train", "zebra");
                    values2.push(1, 2, 3, 4, 5, 1, 2, 3, 4, 5);
                    
                    var temp1, temp2;
                    for (var i = 0; i < 10; i++) {
                        temp1 = keys2[parseInt(seed.substr(i, 1))];
                        keys2[parseInt(seed.substr(i, 1))] = keys2[i];
                        keys2[i] = temp1;

                        temp2 = values2[parseInt(seed.substr(i, 1))];
                        values2[parseInt(seed.substr(i, 1))] = values2[i];
                        values2[i] = temp2;
                    }
                    
                });
            }
            //alerting the score and sending the score to results.jsp afetr game ends
            function stopPlaying() {
                $.post("comm.jsp", {command: "gameend", sc: score}, function(data) {
                    //                    var data = data.toString().trim();
                    alert("Your score is :" + score);
                    //score will be shown and redirects to results page automatically
                    window.location = "results.jsp";
                });
            }
            
        </script>

    </head>
    <body>
        <div id="container" style="width:80%;height:100%;border:solid;border-width:2px;">
            <div id="header" align="top" style="width:100%;height:10%;border:solid;border-width:2px;background-color: #AD7460;">
                <table style="width: 100%">
                    <tr ><td><h1><div id="welcome" style="width: 70%;height: 100%;text-align: center;">Welcome <%= player%></div></h1></td>   
                        <td><h3><div id="gamestart" style="width: 20%;height: 100%;text-align: right;" ></div></h3></td>
                        <td> <h1> <div class="count" style="width: 20%;height: 100%;text-align: right;"></div></h1></td>
                    </tr>
                </table>
            </div>


            <div id="main" style="width:100%;height:80%;">
                <div id="tableDiv" style="width:70%;height:100%;border:solid;border-width:2px;float:left;background-color: #F5D5BC;">

                    <table id="table" style="alignment-adjust: middle;">
                        <tbody>
                            <tr>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img0" class="image" src="resources/card.jpg" onclick="showImage(0);"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img1" class="image" src="resources/card.jpg" onclick="showImage(1);"/>
                                    </div>

                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img2" class="image" src="resources/card.jpg" onclick="showImage(2);" />
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img3" class="image" src="resources/card.jpg" onclick="showImage(3);" />
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img4" class="image" src="resources/card.jpg" onclick="showImage(4);" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img5" class="image" src="resources/card.jpg" onclick="showImage(5);" />
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img6" class="image" src="resources/card.jpg" onclick="showImage(6);" />
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img7" class="image" src="resources/card.jpg" onclick="showImage(7);" />
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img8" class="image" src="resources/card.jpg" onclick="showImage(8);" />
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="img9" class="image" src="resources/card.jpg" onclick="showImage(9);" />
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <br><br>
                    <table id="dummytable" style="alignment-adjust: middle;" >
                        <tbody>
                            <tr>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg0" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg0" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg1" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg1" class="image" src="resources/tick.jpg"/>
                                    </div>

                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg2" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg2" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg3" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg3" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg4" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg4" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg5" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg5" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg6" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg6" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg7" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg7" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg8" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg8" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="imgdiv">
                                        <img id="dimg9" class="image" src="resources/card.jpg"/>
                                        <br>
                                        <img id="dnimg9" class="image" src="resources/tick.jpg"/>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>


                </div>
                <div id="players" style="width:29%;height:100%;border:solid;border-width:2px;float:right;background-color: #D6A354;">
                    <h1>Players List</h1>
                    <div id="playersList"></div>
                    <!--<iframe src="players.jsp"></iframe>-->
                </div>

            </div>

            <div id="footer" align="bottom" style="width:100%;height:10%;border:solid;border-width:2px;background-color:#A84A5C">

                <center>  <input type="button" name="startButton" id="startButton" value="Start Game" "/></center>
                <center><input id="exit" style="alignment-adjust: central;" type="button" value="Exit"></input></center>
                <h2><div id="timer"></div></h2>
                <br>
                <!--end of footer-->
            </div>
            <!--End of container-->
        </div>
    </body>
</html>
