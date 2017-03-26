int state=0;
int selected=0;
PImage cork;
PFont font1;
ArrayList<Note> notes = new ArrayList<Note>();
Note nn = new Note();
void setup (){
  size(600,750);
  frameRate(30);
  noStroke();
  cork = loadImage ("cork-board.jpg");
  font1 = createFont ("Quicksand-Regular.otf", 20);
}
void draw (){
  if (mouseX>0 & mouseY>0 & mouseX<450 & mouseY<600){
    if(selected == 1)
    {
      nn.moveToMouse();
    }
  }
  background(cork);
  nn.show();
  for(Note n : notes)
  {
    n.show();
  }
}
void mousePressed(){
  if(mouseX>nn.x&mouseX<nn.x+nn.side&mouseY>nn.y&mouseY<nn.y+nn.side)
  {
    nn.changeColor();
    selected=1;
  }
}
void mouseReleased()
{
  selected = 0;
}
void keyPressed()
{
  if(keyCode == BACKSPACE)
  {
    nn.removeChar();
  }
  else if(keyCode != SHIFT)
  {
    nn.addChar(key);
  }
}