class Item extends Thing {
  String name;
  int offSetX, offSetY;

  Item(String _name, int _x, int _y, int _c) {
    super(_x, _y, _c);
    name = _name;
    offSet();
  }

  void display() {
    fill(c);
    rect(x * tileSize + offSetX, y * tileSize + offSetY, tileSize / 3, tileSize / 3);
  }

  void offSet() {
    offSetX = round(random(2 * tileSize / 3));
    offSetY = round(random(2 * tileSize / 3));
  }
}

