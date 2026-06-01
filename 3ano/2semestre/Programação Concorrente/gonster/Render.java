import processing.core.PApplet;
import java.lang.Math.*; 
import java.util.ArrayList;

class Render {
  
  private PApplet p;
  private EstadoJogo state;
  private final float WORLD_SIZE = 1000.0f;
  private final float HUD_HEIGHT = 70.0f;
  private final float MAP_PADDING = 35.0f;
  private static final float MASS_AREA_SCALE = 40.0f;
  private float mapX;
  private float mapY;
  private float mapSize;
  private float mapScale;
  
  public Render(PApplet p, EstadoJogo state) {
    this.p = p;
    this.state = state;
  }
  
  public void render() {
    synchronized (state) {
      switch(state.state) {
        case EstadoJogo.MENU: drawMenu(); break;
        case EstadoJogo.LOGIN: drawAuth("LOGIN"); break;
        case EstadoJogo.REGISTER: drawAuth("REGISTER"); break;
        case EstadoJogo.LOBBY: drawLobby(); break;
        case EstadoJogo.QUEUE: drawQueue(); break;
        case EstadoJogo.GAME: drawGame(); break;
      }
    }
  }
  
  private void drawCard(float x, float y, float w, float h) {
    p.fill(40, 50, 70);
    p.stroke(80, 120, 200);
    p.rect(x, y, w, h, 8);
  }

  private void drawCenteredCard(float w, float h) {
    drawCard((p.width - w) / 2, (p.height - h) / 2, w, h);
  }

  private void drawMenu() {
    float cardW = Math.min(600, p.width - 80);
    float cardH = 250;
    float cardX = (p.width - cardW) / 2;
    float cardY = (p.height - cardH) / 2;

    drawCard(cardX, cardY, cardW, cardH);
    p.fill(255);
    p.textAlign(PApplet.CENTER);
    p.textSize(26);
    p.text("GAME MENU", p.width / 2, cardY + 50);
    p.textSize(18);
    p.text("1 - Login\n2 - Create Account\ns - Sair", p.width / 2, cardY + 115);
  }

  private void drawAuth(String title) {
    float cardW = Math.min(700, p.width - 80);
    float cardH = 300;
    float cardY = (p.height - cardH) / 2;

    drawCenteredCard(cardW, cardH);
    p.fill(255);
    p.textAlign(PApplet.CENTER);
    p.textSize(24);
    p.text(title, p.width / 2, cardY + 45);
    drawInputField("Username", state.username, cardY + 100, state.typingUser);
    drawInputField("Password", state.password, cardY + 160, !state.typingUser);
    p.fill(180);
    p.textSize(12);
    p.text("TAB -> switch | ENTER -> confirm | ESC -> back", p.width / 2, cardY + 260);
    p.fill(255, 120, 120);
    p.text(state.statusMsg, p.width / 2, cardY + 285);
  }

  private void drawInputField(String label, String value, float y, boolean active) {
    float w = 260;
    float x = p.width / 2 - w / 2;
    p.fill(active ? p.color(70, 100, 160) : 50);
    p.rect(x, y, w, 40, 10);
    p.fill(255);
    p.textAlign(PApplet.LEFT);
    p.text(label + ": " + value + (active ? "_" : ""), x + 10, y + 25);
  }

  private void drawLobby() {
    float cardW = Math.min(600, p.width - 80);
    float cardH = 450; 
    float cardX = (p.width - cardW) / 2;
    float cardY = (p.height - cardH) / 2;

    drawCard(cardX, cardY, cardW, cardH);
    
    p.fill(255);
    p.textAlign(PApplet.CENTER);
    p.textSize(26);
    p.text("LOBBY", p.width / 2, cardY + 50);

    p.textSize(18);
    p.fill(220);
    p.text("J -> Join Game\nESC -> Logout\nD -> Delete Account", p.width / 2, cardY + 100);

    p.stroke(80, 120, 200, 100);
    p.line(cardX + 50, cardY + 180, cardX + cardW - 50, cardY + 180);

    drawLeaderboard(p.width / 2, cardY + 220);

    p.fill(255, 120, 120);
    p.textSize(14);
    p.text(state.statusMsg, p.width / 2, cardY + 420);
  }

  private void drawQueue() {
    float cardW = Math.min(600, p.width - 80);
    float cardH = 380; 
    float cardX = (p.width - cardW) / 2;
    float cardY = (p.height - cardH) / 2;

    drawCard(cardX, cardY, cardW, cardH);
    
    p.fill(255);
    p.textAlign(PApplet.CENTER);
    p.textSize(22);
    int dots = (p.frameCount / 20) % 3 + 1;//bonito
    StringBuilder dotBuilder = new StringBuilder();
    for (int i = 0; i < dots; i++) {
      dotBuilder.append('.');
    }
    String queueMsg = state.queueTimer >= 0
      ? "A aguardar 4º Player" + dotBuilder + "\nPartida comeca em " + state.queueTimer + "s"
      : "A aguardar Players" + dotBuilder;
    p.text(queueMsg, p.width / 2, cardY + 60);

    drawLeaderboard(p.width / 2, cardY + 120);

    p.fill(180);
    p.textSize(14);
    p.text("ESC -> sair da fila", p.width / 2, cardY + 340);
  }

  private void drawGame() {
    p.background(18, 22, 30);
    updateMapViewport();
    drawMapFrame();
    
    // Recorte para garantir que nada é desenhado fora do mapa
    p.clip(mapX, mapY, mapSize, mapSize);
    drawConsumables();
    drawPlayers();
    p.noClip();
    
    drawTimer();
    drawHUD();
    drawMatchTop();
  }

  private void updateMapViewport() {
    float availableW = p.width - MAP_PADDING * 2;
    float availableH = p.height - HUD_HEIGHT - MAP_PADDING * 2;

    mapSize = Math.min(availableW, availableH);
    mapX = (p.width - mapSize) / 2;
    mapY = HUD_HEIGHT + (availableH - mapSize) / 2 + MAP_PADDING;
    mapScale = mapSize / WORLD_SIZE;
  }

  private void drawMapFrame() {
    p.noStroke();
    p.fill(12, 16, 22);
    p.rect(mapX, mapY, mapSize, mapSize);

    p.stroke(45, 55, 70);
    p.strokeWeight(1);
    for (int i = 1; i < 10; i++) {
      float pos = mapX + i * mapSize / 10;
      p.line(pos, mapY, pos, mapY + mapSize);
      pos = mapY + i * mapSize / 10;
      p.line(mapX, pos, mapX + mapSize, pos);
    }

    p.noFill();
    p.stroke(95, 130, 190);
    p.strokeWeight(2);
    p.rect(mapX, mapY, mapSize, mapSize);
    p.noStroke();
  }

  private float screenX(float worldX) {
    return mapX + worldX * mapScale;
  }

  private float screenY(float worldY) {
    return mapY + worldY * mapScale;
  }

  private void drawTimer() {
    p.fill(40, 50, 70, 200);
    p.noStroke();
    p.rect(p.width / 2 - 55, 15, 110, 40, 8);
    p.fill(state.gameTimer <= 10 ? p.color(255, 50, 50) : 255);
    p.textAlign(PApplet.CENTER, PApplet.CENTER);
    p.textSize(20);
    p.text(p.nf(state.gameTimer / 60, 2) + ":" + p.nf(state.gameTimer % 60, 2), p.width / 2, 35);
  }

  private void drawConsumables() {
    for (EstadoJogo.ObjetoJogo obj : state.worldObjects.values()) {
      p.fill(obj.type.equals("Consumable") ? p.color(0, 255, 0) : p.color(255, 0, 0));
      p.noStroke();
      p.circle(screenX(obj.x), screenY(obj.y), sizeFromMass(obj.mass));
    }
  }

private void drawPlayers() {
    for (int pass = 0; pass < 2; pass++) {
        for (String name : state.players.keySet()) {
            Jogador player = state.players.get(name);
            if (player == null) continue;

            boolean isLocal = name.equals(state.username);
            if (pass == 0 && isLocal) continue;  
            if (pass == 1 && !isLocal) continue; 

            float x = screenX(player.x);
            float y = screenY(player.y);
            float displaySize = sizeFromMass(player.mass);
            float radius = displaySize / 2;

            p.strokeWeight(3);
            p.stroke(isLocal ? p.color(0, 100, 255) : p.color(255, 50, 50));
            p.fill(0);
            p.circle(x, y, displaySize);

            p.pushMatrix();
            p.translate(x, y);
            p.rotate(p.radians(player.angle));
            drawArrow(mapScale);
            p.popMatrix();

            p.fill(255);
            p.textAlign(PApplet.CENTER, PApplet.BOTTOM);
            p.textSize(12);
            p.text(name, x, y - radius - 4);

            p.textSize(10);
            p.fill(200);
            p.text("Mass: " + (int) player.mass, x, y - radius - 18);
        }
    }
}

  private void drawArrow(float scale) {
    float arrowLen = 20 * scale;
    float arrowWidth = 6 * scale;
    p.stroke(255);
    p.strokeWeight(2);
    p.line(0, 0, arrowLen, 0);
    p.fill(255);
    p.triangle(arrowLen, 0, arrowLen - 8, -arrowWidth, arrowLen - 8, arrowWidth);
    p.noStroke();
  }

  private float sizeFromMass(float mass) {
    // Escala baseada em logaritmo para crescimento suave, ajustada pela escala do mapa
    return (float)(Math.log(mass + 0.608631)/Math.log(1.18) + 6) * 2 * mapScale;
  }

  private void drawLeaderboard(float x, float y) {
    p.fill(255, 215, 0); 
    p.textSize(18);
    p.textAlign(PApplet.CENTER);
    p.text("🏆 GLOBAL TOP 5 🏆", x, y);
    
    p.textSize(14);
    p.fill(200);
    if (state.topScores == null || state.topScores.equals("")) {
        p.text("Nenhum recorde ainda", x, y + 30);
    } else {
        String[] entries = state.topScores.split("\\|");
        for (int i = 0; i < entries.length; i++) {
            p.text((i+1) + ". " + entries[i].replace(":", " - Vitórias: "), x, y + 30 + (i * 22));
        }
    }
  }

  private void drawHUD() {
    Jogador me = state.players.get(state.username);
    if (me != null) {
      p.fill(255);
      p.textAlign(PApplet.LEFT, PApplet.TOP); 
      p.textSize(22);
      p.text("Points: " + me.pontos, 25, 20); 
    }
  }

  private void drawMatchTop() {
    if (state.players.isEmpty()) {
      return;
    }

    ArrayList<String> names = new ArrayList<>(state.players.keySet());
    names.sort((a, b) -> Integer.compare(state.players.get(b).pontos, state.players.get(a).pontos));

    int max = Math.min(5, names.size());
    float panelW = 220;
    float panelH = 30 + max * 18;
    float x = mapX + mapSize - panelW - 10;
    float y = mapY + 10;

    p.fill(40, 50, 70, 200);
    p.noStroke();
    p.rect(x, y, panelW, panelH, 6);

    p.fill(255);
    p.textSize(14);
    p.textAlign(PApplet.LEFT, PApplet.TOP);
    p.text("TOP PONTOS", x + 10, y + 6);

    p.fill(200);
    for (int i = 0; i < max; i++) {
      String name = names.get(i);
      Jogador player = state.players.get(name);
      if (player == null) continue;
      p.text((i + 1) + ". " + name + " - " + player.pontos, x + 10, y + 26 + i * 18);
    }
  }
}