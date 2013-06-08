package javacode;

import java.io.*;
import java.net.*;
import java.util.Hashtable;

public class Client {

    private int port = 9999;
    private String ipAdd = "localhost";
    Socket socket;
    private BufferedReader in;
    //private ObjectInputStream oin;
    private PrintWriter out;

    public static void main(String[] args) {
        Client client = new Client();
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            client.connect();
            String line = br.readLine();
            client.send(line);
            line = client.get();
            System.out.println(line);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }
//setting up conneciton with the socket.
    public int connect() {
        int id = 0;
        try {
            socket = new Socket(ipAdd, port);
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            out = new PrintWriter(socket.getOutputStream(), true);
            // getting id associated with the client from server. 
            id = Integer.parseInt(in.readLine());
        } catch (SocketException se) {
            return 0;
        } catch (IOException ioe) {
            return 0;
        }
        return id;
    }
//sends command to server
    public void send(String line) {
        out.println(line);
    }
//receives response from server
    public String get() {
        String line = "";
        try {
            line = in.readLine();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }

        return line;
    }
    
}
