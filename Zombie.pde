class Zombie extends Enemy {

  Zombie(String _name, int _md, int[][] _view, int _x, int _y, color _c) {
    super(_name, _md, _view, _x, _y, _c);
  }

  void update(boolean canSee, Player player) {
    if (canSee) {
      float tx = player.x;
      float ty = player.y;

      int N = y - 1;
      int S = y + 1;
      int E = x + 1;
      int W = x - 1;

      if ((tx == W && ty == y) || (tx == E && ty == y) || (ty == S && tx == x) || (ty == N && tx == x)) {
        player.attack(md);
        println("Attack");
      } else {
        if (tx > x && isClearAt(E, y)) x = E;
        else if (tx < x && isClearAt(W, y)) x = W;
        else if (ty > y && isClearAt(x, S)) y = S;
        else if (ty < y && isClearAt(x, N)) y = N;
      }

      //       if (isClearAt(x + player.ldx, y + player.ldy)) {
      //         x += player.ldx;
      //         y += player.ldy;
      //       }
    }
  }


  void display() {
    fill(c);
    rect(x * tileSize, y * tileSize, tileSize, tileSize);
  }
}

