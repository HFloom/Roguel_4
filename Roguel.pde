int tileSize = 15;
boolean keyDown;
int tick;

int buffer = 8;
int[][] map;
int[][] view;

Mover player;

int bkg = color(65);

void setup() {
  size(500, 500);
  textAlign(CENTER);
  noStroke();

  keyDown = false;
  tick = 0;

  map = level(0);

  view = new int[map.length][map[0].length];
  clearView(3);

  player = new Mover(map);
  player.x = round(width / tileSize / 2);
  player.y = round(height / tileSize / 2);
  player.c = color(#FF0000);
}

void draw() {
  background(bkg);

  pushMatrix();
  translate((width / 2) - player.x * tileSize, (height / 2) - player.y * tileSize);

  drawView();
  updateView(player.x, player.y, buffer);

  fill(player.c);
  drawBlock(player.x, player.y);
  popMatrix();
}

void update() {
  tick++;
  println(tick);
}

void clearView(int x) {
  for (int i = 0; i < view.length; i++) {
    for (int j = 0; j < view[i].length; j++) {
      view[i][j] = x;
    }
  }
}

void drawView() {
  for (int i = 0; i < view.length; i++) {
    for (int j = 0; j < view[i].length; j++) {
      switch (view[i][j]) {
      case 0: // floor
        fill(150);
        break;
      case 1: // wall
        fill(0);
        break;
      case 3: // fog
        fill(bkg);
        break;
      default: // error
        fill(#FFFF00);
        break;
      }
      drawBlock(i, j);
    }
  }
}

void updateView(int x, int y, int range) {
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      if (i > x - range && i < x + range) {
        if (j > y - range && j < y + range) {
          if (pow(i - x, 2) + pow(j - y, 2) < pow(range, 2)) { 
            if (map[i][j] == 0) { // floor
              fill(255);
              drawBlock(i, j);
            }
            view[i][j] = map[i][j];
          }
        }
      }
    }
  }
}

void drawBlock(int x, int y) {
  rect(x * tileSize, y * tileSize, tileSize, tileSize);
}

void keyPressed() {
  if (!keyDown) {
    switch (key) {
    case CODED:
      switch (keyCode) {
      case UP:
        player.move(0, -1);
        break;
      case DOWN:
        player.move(0, 1);
        break;
      case RIGHT:
        player.move(1, 0);
        break;
      case LEFT:
        player.move(-1, 0);
        break;
      }
      break;
    }
    update();
  }
  keyDown = true;
}

void keyReleased() {
  keyDown = false;
}

