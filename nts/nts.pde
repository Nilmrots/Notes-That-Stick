int state=0;
int selected=-1;
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
  notes.add(new Note());
  notes.add(new Note());
}
void draw (){
  if (mouseX>0 & mouseY>0 & mouseX<width-Note.side & mouseY<height-Note.side){
    if(selected == 1)
    {
      nn.moveToMouse();
    }
  }
  if(selected >= 0)
  {
    if(notes.get(selected).isMouseInside())
    {
      notes.get(selected).moveToMouse();
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
  if(mouseX>nn.x&mouseX<nn.x+Note.side&mouseY>nn.y&mouseY<nn.y+Note.side)
  {
    nn.changeColor();
    selected=1;
  }
  for(int i = 0; i < notes.size(); i++)
  {
    if(notes.get(i).isMouseInside())
    {
      selected = i;
    }
  }
}
void mouseReleased()
{
  selected = -1;
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