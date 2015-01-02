int tileSize = 15;
boolean keyDown;
int tick;

int buffer = 8;
int[][] map;
int[][] view;

ArrayList<Enemy> enemies;
ArrayList<Item> floorItems;

MessageHandler mHandler;
Player player;

int bkg = color(0);

void setup() {
  size(500, 500);
  textAlign(CENTER);

  keyDown = false;
  tick = 0;

  map = level(0);

  view = new int[map.length][map[0].length];
  clearView(3);

  enemies = new ArrayList<Enemy>();
  enemies.add(new Zombie("Zombie", 1, view, 20, 16, color(0, 0, 255)));

  floorItems = new ArrayList<Item>(); //20,16
  floorItems.add(new FoodItem("Food", 1, 18, 16, color(0, 255, 0)));

  mHandler = new MessageHandler();
  player = new Player(view, round(width / tileSize / 2), round(height / tileSize / 2), color(#FF0000));
}

void draw() {
  noStroke();
  //println(player.inventory.size());

  background(bkg);

  pushMatrix();
  translate((width / 2) - player.x * tileSize, (height / 2) - player.y * tileSize);

  drawView();
  updateView(player.x, player.y, buffer);

  drawItems();
  drawEnemies();

  fill(player.c);
  drawBlock(player.x, player.y);
  popMatrix();

  mHandler.display();
}

void update() {
  tick++;
  println("Tick: " + tick);
  mHandler.update();
  updateEnemies();
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
    case ' ':
      mHandler.addMessage("In a world far far away", 4, #FF0000);
      floorItems.get(0).offSet();
      break;
    case 'g':
      int itemNum = itemAt(player.x, player.y);
      if (itemNum >= 0) {
        Item item = floorItems.get(itemNum);
        player.inventory.add(item);
        floorItems.remove(itemNum);
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

void drawItems() {
  for (Item item : floorItems) {
    if (distance(item.x, item.y, player.x, player.y) < buffer) {
      item.display();
    }
  }
}

int itemAt(int x, int y) {
  for (int i = 0; i < floorItems.size (); i++) {
    Item item = floorItems.get(i);
    if (item.x == x && item.y == y) return i;
  }
  return -1;
}

void drawEnemies() {
  for (Enemy enemy : enemies) {
    if (distance(enemy.x, enemy.y, player.x, player.y) < buffer) {
      enemy.display();
    }
  }
}

void updateEnemies() {
  for (Enemy enemy : enemies) {
    if (distance(enemy.x, enemy.y, player.x, player.y) < enemy.sight) {
      enemy.update(true, player);
    }
    else {
      enemy.update(false, player);
    }
  }
}

float distance(float x, float y, float x2, float y2) {
  return sqrt(pow(x2 - x, 2) + pow(y2 - y, 2));
}

boolean isClearAt(int x, int y) {
  return (view[x][y] == 0);
}

