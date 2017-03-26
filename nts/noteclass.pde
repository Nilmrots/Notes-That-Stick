class Note
{
  final int side = 150;
  char[] words;
  int wpoint;
  color clr;
  int x;
  int y;
  Note()
  {
    words = new char[100];
    wpoint = 0;
    clr = color(240,240,120);
    x = 50;
    y = 50;
  }
  void addChar(char c)
  {
    if(wpoint<words.length)
    {
      words[wpoint]=c;
      wpoint++;
    }
  }
  void removeChar()
  {
    if(wpoint>0)
    {
      words[wpoint-1]=' ';
      wpoint--;
    }
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
    fill(0);
    textFont(font1);
    text(new String(words,0,wpoint),x+5,y+5,side-5,side-5);
  }
}
