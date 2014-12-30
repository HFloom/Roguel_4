class Mover extends Thing {
 int[][] map;

  Mover(int[][] view) {
    map = view;
  }

  void move(int dx, int dy) {
    if (map[x + dx][y + dy] == 0) {
      x += dx;
      y += dy;
    }
  }
}
