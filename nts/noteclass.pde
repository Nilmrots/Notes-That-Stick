class Note
{
  final static int side = 150;
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
    x = mouseX-(side/2);
    y = mouseY-(side/2);
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
    textFont(font1);
    text(new String(words,0,wpoint),x+5,y+5,side-10,side-10);
    rect(x+125,y+125,25,25);
    fill(255);
    text("C",x+130,y+128,25,25);
  }
  boolean isMouseInside()
  {
    return (mouseX>x & mouseX<x+side & mouseY>y & mouseY<y+side);
  }
  boolean isMouseOnButton()
  {
    return (mouseX>x+125 & mouseX<x+side & mouseY>y+125 & mouseY<y+side);
  }
}