import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

class ComunicacaoTCP {
  
  private Socket socket;
  private PrintWriter out;
  private BufferedReader in;
  private EstadoJogo state;
  private volatile boolean running = false;
  
  public ComunicacaoTCP(EstadoJogo state) {
    this.state = state;
  }
  
  public boolean connect(String host, int port) {
    try {

      socket = new Socket(host, port);

      out = new PrintWriter(socket.getOutputStream(), true);

      in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

      System.out.println("Connected to server at " + host + ":" + port);

      return true;

    } catch(IOException e) {
      System.err.println("Connection error: " + e);
      return false;
    }
  }
  
  public synchronized void send(String message) {
    if (out != null) {
      out.println(message);
    }
  }
  
  public void listen() {
    running = true;
    try {
      
      String msg;

      while (running && in != null && (msg = in.readLine()) != null) {
        synchronized (state) {
          handleServerMessage(msg);
        }
      }
    } catch(IOException e) {
      if (running) {
        System.err.println("Receive error: " + e);
      }
    } finally {
      running = false;
    }
  }
  
  private void handleServerMessage(String msg) {
    if (msg.equals("User Logged in")) {
      state.state = EstadoJogo.LOBBY;
      state.statusMsg = "";
    } 
    else if (msg.equals("Account Created")) {
      state.statusMsg = "Success!";
    } 
    else if (msg.equals("account_deleted") || msg.equals("User Logged Out")) {
      state.state = EstadoJogo.MENU;
      state.username = "";
      state.password = "";
      state.players.clear();
      state.queueTimer = -1;
    } 
    else if (msg.equals("joined_queue")) {
      state.state = EstadoJogo.QUEUE;
      state.queueTimer = -1;
    } 
    else if (msg.equals("left")) {
      state.state = EstadoJogo.LOBBY;
      state.queueTimer = -1;
    } 
    else if (msg.equals("game_start")) {
      state.state = EstadoJogo.GAME;
      state.players.clear();
      state.gameTimer = 120;
      state.queueTimer = -1;
    } 
    else if (msg.startsWith("timer ")) {
      state.gameTimer = Integer.parseInt(msg.substring(6).trim());
    } 
    else if (msg.startsWith("queue_timer ")) {
      state.queueTimer = Integer.parseInt(msg.substring(12).trim());
    }
    else if (msg.startsWith("MAP ")) {
      parseObjects(msg.substring(4));
    } 
    else if (msg.equals("game_over")) {
      state.state = EstadoJogo.LOBBY;
      state.statusMsg = "Fim da partida!";
      state.players.clear();
      state.queueTimer = -1;
    } 
    else if (msg.startsWith("PLAYERS ")) {
      parsePlayers(msg.substring(8));
    } else if(msg.startsWith("TOP ")) {
      state.topScores = msg.substring(4);
    } 
    else {
      state.statusMsg = msg;
    }
  }
  

  // macetado
  private void parseObjects(String data) {
    state.worldObjects.clear();
    
    String[] obs = split(data, "|");
    
    for (String s : obs) {
      String[] parts = split(s, " ");
      if (parts.length == 4) {
        state.worldObjects.put(parts[0] + "," + parts[1], 
          new EstadoJogo.ObjetoJogo(Float.parseFloat(parts[0]), Float.parseFloat(parts[1]), 
                                   parts[2], Float.parseFloat(parts[3])));
      }
    }
  }
  
  private void parsePlayers(String msg) {
    state.players.clear();

    String[] playersData = split(msg, "|");

    for (String p : playersData) {
      
      p = trim(p);
      if (p.length() == 0) continue;

      String[] parts = split(p, " ");

      if (parts.length >= 5) {
        state.players.put(parts[0], new Jogador(
          Float.parseFloat(parts[1]),
          Float.parseFloat(parts[2]),
          Float.parseFloat(parts[4]),
          Float.parseFloat(parts[3]),
          Integer.parseInt(parts[5])
        ));
      }
    }
  }
  

  ////////////////////////////////////////////// utils
  private String[] split(String str, String delimiter) {
    return str.split(java.util.regex.Pattern.quote(delimiter));
  }
  
  private String trim(String str) {
    return str.trim();
  }
  ////////////////////////////////////////////////////
  
  
  
  public void close() {
    running = false;
    try {
      if (socket != null) socket.close();
    } catch(IOException e) {
      System.err.println("Close error: " + e);
    }
  }
}
