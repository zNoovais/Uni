import processing.core.PApplet;

class Cliente extends PApplet{

  private EstadoJogo gameState;

  // private ComunicacaoTCP network;

  private Postman postman;

  private Render uiRender;
  
  private Inputer inputHandler;

  public Cliente(EstadoJogo gameState, Postman postman, ComunicacaoTCP network) {
    this.gameState = gameState;
    this.postman = postman;
    // this.network = network;
  }

  @Override
  public void settings() {
    size(1250, 1000);
  }

  @Override
  public void setup() {
    uiRender = new Render(this, gameState);
    inputHandler = new Inputer(this, gameState, postman);
  }

  @Override
  public void draw() {
    background(20, 25, 35);

    if(frameCount % 300 == 0) {
      postman.send("get_top");
    }
    
    sendGameInput();
    uiRender.render();
  }

  @Override
  public void keyPressed() {
    boolean escapePressed = key == ESC;
    if (escapePressed) {
      key = 0;
    }

    inputHandler.handleKeyPressed(key, keyCode, escapePressed);

    if (gameState.state == EstadoJogo.SAIR) {
      exit();
    }
  }

  @Override
  public void keyReleased() {
    inputHandler.handleKeyReleased(key);
  }

  private void sendGameInput() {
    boolean left;
    boolean right;
    boolean up;
    boolean inGame;

    synchronized (gameState) {
      inGame = gameState.state == EstadoJogo.GAME;
      left = gameState.left;
      right = gameState.right;
      up = gameState.up;
    }

    if (!inGame) return;

    if (left) postman.send("move left");
    if (right) postman.send("move right");
    if (up) postman.send("move up");
    if(frameCount % 300 == 0) {
      postman.send("get_top");
    }
  }



  @Override
  public void dispose() {
    if (postman != null) {
      postman.stop();
    }
    // if (network != null) {
    //   network.close();
    // }
  }
}
