import processing.core.PApplet;

class Inputer {
  
  private EstadoJogo state;
  private Postman postman;
  private PApplet p;
  
  public Inputer(PApplet p, EstadoJogo state, Postman postman) {
    this.p = p;
    this.state = state;
    this.postman = postman;
  }
  
  public void handleKeyPressed(char key, int keyCode, boolean escapePressed) {
    synchronized (state) {
      if (escapePressed) {
        handleEscape();
        return;
      }

      switch(state.state) {
        case EstadoJogo.MENU:
          handleMenuInput(key);
          break;
        case EstadoJogo.LOGIN:
        case EstadoJogo.REGISTER:
          handleAuthInput(key, keyCode);
          break;
        case EstadoJogo.LOBBY:
          handleLobbyInput(key);
          break;
        case EstadoJogo.GAME:
          handleGameInput(key, true);
          break;
      }
    }
  }
  
  public void handleKeyReleased(char key) {
    synchronized (state) {
      if (state.state == EstadoJogo.GAME) {
        handleGameInput(key, false);
      }
    }
  }
  
  private void handleEscape() {
      switch (state.state) {
          case EstadoJogo.QUEUE:
              postman.send("leave_queue " + state.username);
              state.state = EstadoJogo.LOBBY;
              break;
          case EstadoJogo.GAME:
              postman.send("leave_game " + state.username);
              state.state = EstadoJogo.LOBBY;
              state.players.clear();
              state.worldObjects.clear();
              state.up = false;
              state.left = false;
              state.right = false;
              break;
          case EstadoJogo.LOBBY:
              postman.send("logout " + state.username);
              state.state = EstadoJogo.MENU;
              state.username = "";
              state.password = "";
              break;
          case EstadoJogo.LOGIN:
            postman.send("get_top");
              state.state = EstadoJogo.MENU;
              break;
          case EstadoJogo.REGISTER:
              state.state = EstadoJogo.MENU;
              break;
          default:
              break;
      }
  }
  
  private void handleMenuInput(char key) {
      switch (key) {
          case '1':
              state.state = EstadoJogo.LOGIN;
              break;
          case '2':
              state.state = EstadoJogo.REGISTER;
              break;
          case 's':
          case 'S':
              state.state = EstadoJogo.SAIR;
              break;
          default:
              break;
      }
  }
  
  private void handleAuthInput(char key, int keyCode) {
    if (keyCode == PApplet.TAB) {
      state.typingUser = !state.typingUser;
    } 
    else if (key == PApplet.ENTER) {
      if (state.state == EstadoJogo.LOGIN) {
        postman.send("login " + state.username + " " + state.password);
      } 
      else {
        postman.send("create_account " + state.username + " " + state.password);
      }
    } 
    else if (key == PApplet.BACKSPACE) {
      if (state.typingUser && state.username.length() > 0) {
        state.username = state.username.substring(0, state.username.length() - 1);
      } 
      else if (!state.typingUser && state.password.length() > 0) {
        state.password = state.password.substring(0, state.password.length() - 1);
      }
    } 
    else if (keyCode != PApplet.CODED) {
      if (state.typingUser) {
        state.username += key;
      } 
      else {
        state.password += key;
      }
    }
  }
  
  private void handleLobbyInput(char key) {
      switch (key) {
          case 'j':
          case 'J':
              postman.send("join " + state.username);
              state.state = EstadoJogo.QUEUE;
              break;
          case 'l':
          case 'L':
              postman.send("logout " + state.username);
              state.state = EstadoJogo.MENU;
              break;
          case 'd':
          case 'D':
              postman.send("delete_account " + state.username);
              break;
          default:
              break;
      }
  }
  
  private void handleGameInput(char key, boolean isPressed) {
      switch (key) {
          case 'w':
          case 'W':
              state.up = isPressed;
              break;
          case 'a':
          case 'A':
              state.left = isPressed;
              break;
          case 'd':
          case 'D':
              state.right = isPressed;
              break;
          default:
              break;
      }
  }
}
