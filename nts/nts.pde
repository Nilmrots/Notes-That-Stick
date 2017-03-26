int state=0;
int selected=-1;
PImage cork;
PFont font1;
ArrayList<Note> notes = new ArrayList<Note>();
void setup (){
  size(600,750);
  frameRate(30);
  noStroke();
  cork = loadImage ("cork-board.jpg");
  font1 = createFont ("Quicksand-Regular.otf", 20);
  notes.add(new Note());
  notes.add(new Note());
  notes.add(new Note());
}
void draw (){
  if(selected >= 0)
  {
    if(notes.get(selected).isMouseInside())
    {
      notes.get(selected).moveToMouse();
    }
  }
  background(cork);
  for(Note n : notes)
  {
    n.show();
  }
}
void mousePressed(){
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
  if(selected >= 0)
  {
    if(keyCode == BACKSPACE)
    {
      notes.get(selected).removeChar();
    }
    else if(keyCode != SHIFT)
    {
      notes.get(selected).addChar(key);
    }
  }
}