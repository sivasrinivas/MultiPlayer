package javacode;

import java.net.*;
import java.io.*;
import java.util.ArrayList;
import java.util.concurrent.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.awt.*;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jfree.chart.*;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 * Demo Server: Contains a multi-threaded socket server sample code.
 */
public class Server {

    final int MAX = 50;
    static final int port = 9999;
    static int count = 1;
    boolean status = false;
    long timeSeed;
    ArrayList<PrintWriter> writerList;
    ArrayList<Socket> socketList;
    ArrayList<Integer> idList;
    ArrayList<Integer> scoreIds;
    ArrayList<Integer> scoreValues;
    Lock lock;
    Timer timer;

    public Server() {
        //creates array lists to maintain clients' printwriter list, socket list, idlist and a lock. lock is to prevent data races
        this.writerList = new ArrayList<PrintWriter>();
        this.socketList = new ArrayList<Socket>();
        this.idList = new ArrayList<Integer>();
        this.lock = new ReentrantLock();
    }

    public static void main(String[] args) {
        /*
         *using an executor service to start threads
         * using a cached thread pool where cached threads can be re used or new ones can be created as needed.
         */
        ExecutorService executor = Executors.newCachedThreadPool();
        ServerSocket ss = null;
        try {
            ss = new ServerSocket(port);
            Server server = new Server();
            while (true) {
                Socket socket = ss.accept();
                //creates a thread for each client by passing client socket and an id
                executor.execute(server.new Handler(count, socket));
                count++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                //closing the server socket
                if (ss != null) {
                    ss.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
/*
 * a class for handiling of client thread which implements runnable interface
 */
    private class Handler implements Runnable {

        private int id = 0;
        private Socket socket;
        private BufferedReader in;
        private PrintWriter out;

        //constructor for initilization of client's id and socket 
        public Handler(int id, Socket socket) {
            this.id = id;
            this.socket = socket;
        }

        @Override
        public void run() {
            try {
                talkOnSocket(socket);
            } finally {
                try {
                    if (socket != null) {
                        socket.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        public void talkOnSocket(Socket socket) {
            try {
                String line;
                System.out.println("Connected Thread" + id);
                in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                out = new PrintWriter(socket.getOutputStream(), true);

                out.println(id);

                lock.lock();
                try {
                    //each client's printwriter, socket and id are added to shared arraylists of Server
                    writerList.add(out);
                    socketList.add(socket);
                    idList.add(id);
                } finally {
                    lock.unlock();
                }

                while ((line = in.readLine()) != null) {

                    //if any one of waiting player clicks 'start game', a start command is sent to all players which starts the game for all the players.
                    if (line.equalsIgnoreCase("start")) {
                        if (status != true) {
                            //status of game is set to true to indicate that game is in progress
                            status = true;
                            timer = new Timer();
                            //seed/random number which is sent to client for shuffling of tiles
                            timeSeed = System.nanoTime();
                            timer.schedule(new TimerTask() {
                                public void run() {
                                    System.out.println("status setting to false");
                                    status = false;
                                }
                            }, 48000);
                            //for the present game session, ids and scores of the players will be maintained in following array lists which are shared
                            scoreIds = new ArrayList<Integer>();
                            scoreValues = new ArrayList<Integer>();
                            System.out.println("status set to " + status);
                            System.out.println("Thread " + id + " started");
                            for (PrintWriter print : writerList) {
                                print.println(line);
                            }

                        } else {
                            out.println("inprogress");
                        }

                    } 
                    //sends the present players list to client
                    else if (line.equalsIgnoreCase("players")) {
                        String playersSt = "";
                        System.out.println("Sending player list");
                        lock.lock();
                        try {
                            for (int i : idList) {
                                playersSt += "Player" + i + "<br>";
                            }
                        } finally {
                            lock.unlock();
                        }
                        out.println(playersSt);

                    } 
                    //a 10 digit random nuber by using system time is generated and sent to each player which will be used in shuffling the tiles
                    else if (line.equalsIgnoreCase("seed")) {
                        String seed = String.valueOf(timeSeed).substring(0, 10);
                        System.out.println("Sending seed");
                        out.println(seed);

                    }
                    /*
                     *gameend command will be received when timer hits 40 on client side, which stops the game, set status of game to false 
                     * and collect coressponding player's score 
                     */
                    else if (line.equalsIgnoreCase("gameend")) {
                        timer.cancel();
                        line = in.readLine();
                        int score = Integer.parseInt(line);
                        System.out.println(id + " Score: " + score);
                        lock.lock();
                        try {
                            //adds the player's score to arraylist
                            scoreIds.add(id);
                            scoreValues.add(score);
                        } finally {
                            lock.unlock();
                        }

                        if (status == true) {
                            status = false;
                            System.out.println("status set to false");
                            System.out.println("Game end by " + id);

                            generatepng();
                        }

                    } 
                    else if (line.equalsIgnoreCase("getscores")) {
                        String result = "";
                        for (int id : scoreIds) {
                            result = result + "Player" + id + " : " + scoreValues.get(scoreIds.indexOf(id)) + "<br>";
                        }
                        System.out.println("Getting scores : " + result);
                        out.println(result);
                    } 
                    //exit command will be received when a player click exit button whle game in progress. 
                    //players exits and his id, socket and printwrite are removed from corresponding array lists
                    else if (line.equalsIgnoreCase("exit")) {
                        System.out.println("Exit command");
                        lock.lock();
                        try {
                            int index = socketList.indexOf(socket);
                            System.out.println("Player exits");
                            idList.remove(index);
                            writerList.remove(index);
                            socketList.remove(index);

                        } finally {
                            lock.unlock();
                        }
                        //socket of the exited player is closed
                        socket.close();
                    }
                }
            } catch (SocketException se) {
                lock.lock();
                try {
                    int index = socketList.indexOf(socket);
                    if (index != -1) {
                        //if by any means exception comes, corresponding player will be removed from players list
                        System.out.println("Player exits");
                        idList.remove(index);
                        writerList.remove(index);
                        socketList.remove(index);
                    }
                } finally {
                    lock.unlock();
                }

            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        }
    }

    public class CheckClients implements Runnable {

        public void run() {

            lock.lock();
            try {
                for (int i = 0; i < socketList.size(); i++) {
                    if (socketList.get(i).isClosed()) {
                        socketList.remove(i);
                        idList.remove(i);
                        writerList.remove(i);
                    }
                }
            } finally {
                lock.unlock();
            }
        }
    }

    /*
     * generates a graphical representaion of players and their performance/score
     */
    public boolean generatepng() {

        try {
            Thread.sleep(2000);
        } catch (InterruptedException ex) {
            Logger.getLogger(Server.class.getName()).log(Level.SEVERE, null, ex);
        }
        JFreeChart chart = null;
        BarRenderer renderer = null;
        CategoryPlot plot = null;
        DefaultCategoryDataset dataset = null;

        final CategoryAxis ca = new CategoryAxis("USER ID");
        final ValueAxis va = new NumberAxis("SCORES");
        renderer = new BarRenderer();

        try {
            String temp = "SCORES";
            System.out.println(scoreIds);
            System.out.println(scoreValues);

            //DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            dataset = new DefaultCategoryDataset();
            for (int i = 0; i < scoreIds.size(); i++) {
                dataset.setValue(scoreValues.get(i), temp, scoreIds.get(i));
            }


            plot = new CategoryPlot(dataset, ca, va, renderer);
            chart = ChartFactory.createBarChart("IQ LEVELS OF PARTICIPANTS", "USER_ID", "POINTS", dataset, PlotOrientation.VERTICAL, false, true, false);

            Paint p1 = new GradientPaint(0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));
            renderer.setSeriesPaint(1, p1);
            plot.setRenderer(renderer);

            final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
            final File tempfile = new File("web/resources/iqimg.png");
            boolean exists = tempfile.exists();
            if (exists) {

                System.out.println(exists);
                tempfile.delete();
            }

            final File file1 = new File("web/resources/iqimg.png");
            ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
            
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }

    }
}
