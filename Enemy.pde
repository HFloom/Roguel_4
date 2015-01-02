class Enemy extends Mover {
  String name;
  
  int sight = buffer;
  float md; // Melee damage
  
  Enemy(String _name, int _md, int[][] _view, int _x, int _y, color _c) {
    super(_view, _x, _y, _c);
    
    name = _name;
    md = _md;
  }
  
  void update(boolean canSee, Player player) {}
    
  void display() {}
}
