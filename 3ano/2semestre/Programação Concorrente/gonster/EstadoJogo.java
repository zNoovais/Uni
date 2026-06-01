import java.util.HashMap;


// isto é como a thread de rede e de render comunicam
class EstadoJogo {
  
  public static final int MENU = 0;
  public static final int LOGIN = 1;
  public static final int REGISTER = 2;
  public static final int LOBBY = 3;
  public static final int QUEUE = 4;
  public static final int GAME = 5;
  public static final int SAIR = 6;
  
  public int state = MENU;
  
  public String username = "";
  public String password = "";
  public boolean typingUser = true;
  
  public String statusMsg = "";
  public int gameTimer = 120;
  public int queueTimer = -1;
  
  public HashMap<String, Jogador> players = new HashMap<>();
  public HashMap<String, ObjetoJogo> worldObjects = new HashMap<>();
  
  public boolean up = false;
  public boolean left = false;
  public boolean right = false;

  public String topScores = "";
  
  public static class ObjetoJogo 
  {
    public float x, y, mass;
    public String type;

    public ObjetoJogo(float x, float y, String type, float mass) {
      this.x = x;
      this.y = y;
      this.type = type;
      this.mass = mass;
    }
  }
  
  public void reset() {
    username = "";
    password = "";
    statusMsg = "";
    queueTimer = -1;
    players.clear();
    worldObjects.clear();
    up = false;
    left = false;
    right = false;
  }
}
