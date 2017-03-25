class Note
{
  final int side = 100;
  ArrayList<Character> words;
  color clr;
  int x;
  int y;
  Note()
  {
    words = new ArrayList<Character>();
    clr = color(200,200,120);
    x = 50;
    y = 50;
  }
  void addChar(char c)
  {
    words.add(c);
  }
  void removeChar()
  {
    words.remove(words.size()-1);
  }
  void moveToMouse()
  {
    x = mouseX;
    y = mouseY;
  }
  void show()
  {
    noStroke();
    fill(clr);
    rect(x,y,side,side);
  }
}