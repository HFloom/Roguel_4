class MessageHandler {
  StringList text;
  IntList time;
  IntList c;

  MessageHandler() {
    text = new StringList();
    time = new IntList();
    c = new IntList();
  }

  void addMessage(String _text, int _time, color _c) {
    text.append(_text);
    time.append(_time);
    c.append(_c);
  }

  void update() {
    if (time.size() > 0) {
      time.sub(0, 1);
      if (time.get(0) <= 0) {
        text.remove(0);
        time.remove(0);
        c.remove(0);
      }
    }
  }

  void display() {
    if (text.size() > 0) {
      fill(c.get(0));
      textSize(25);
      textAlign(CENTER, BOTTOM);
      text(text.get(0), 10, 0, width - 20, height - 20);
    }
  }
}

