class Mover extends Thing {
  int[][] map;
  int ldx, ldy;

  Mover(int[][] view, int _x, int _y, color _c) {
    super(_x, _y, _c);
    map = view;
    ldx = 0;
    ldy = 0;
  }

  void move(int dx, int dy) {
    if (isClearAt(x + dx, y + dy)) {
      x += dx;
      y += dy;
      ldx = dx;
      ldy = dy;
    }
    println("(" + x + ", " + y + ")");
  }
}

