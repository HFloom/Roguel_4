class Player extends Mover {
  ArrayList<Item> inventory;

  Player(int[][] _map, int _x, int _y, color _c) {
    super(_map, _x, _y, _c);

    inventory = new ArrayList<Item>();
  }

  void attack(float damage) {
  }
}

