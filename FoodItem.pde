class FoodItem extends Item {
  float nutrience;
  
  FoodItem(String _name, float _nutrience, int _x, int _y, int _c) {
    super(_name, _x, _y, _c);
    nutrience = _nutrience;
  }
}
