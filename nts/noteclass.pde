class Note
{
  final int side = 150;
  char[] words;
  int wpoint;
  color[] clrs = {color(240,240,120), color(240,120,240), color(120,240,240)};
  int clrstate;
  int x;
  int y;
  Note()
  {
    words = new char[100];
    wpoint = 0;
    clrstate = 0;
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
  void changeColor()
  {
    clrstate++;
    if(clrstate > 2)
    {
      clrstate = 0;
    }
  }
  void show()
  {
    noStroke();
    fill(clrs[clrstate]);
    rect(x,y,side,side);
    fill(0);
    text(new String(words),x,y,side,side);
  }
}
