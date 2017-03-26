int state=0;
int selected=-1;
int recentSelected=0;
PImage cork;
PFont font1;
PImage newbutton;
PImage trashbin;
ArrayList<Note> notes = new ArrayList<Note>();
void setup (){
  size(600,750);
  frameRate(30);
  noStroke();
  cork = loadImage ("cork-board.jpg");
  newbutton = loadImage ("newbutton.png");
  trashbin = loadImage ("trashbin.png");
  font1 = createFont ("Quicksand-Regular.otf", 20);
}
void draw (){
  if(selected >= 0 & mouseX>Note.side/2 & mouseY>Note.side/2 & mouseX<width-(Note.side/2) & mouseY<height-(Note.side/2))
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
  image(newbutton,500,25);
  image(trashbin,510,660);
}
void mousePressed(){
  if(mouseX>500 & mouseY>25 & mouseX<580 & mouseY<105){
    notes.add(new Note());
  }
  for(int i = 0; i < notes.size(); i++)
  {
    if(notes.get(i).isMouseOnButton())
    {
      notes.get(i).changeColor();
      recentSelected=i;
    }
    else if(notes.get(i).isMouseInside())
    {
      selected = i;
      recentSelected=i;
    }
  }
}
void mouseReleased()
{
  if(mouseX>510 & mouseY>660 & mouseX<590 & mouseY<740)
  {
    notes.remove(selected);
  }
  selected = -1;
}
void keyPressed()
{
  if(keyCode == BACKSPACE)
  {
    notes.get(recentSelected).removeChar();
  }
  else if(keyCode != SHIFT)
  {
    notes.get(recentSelected).addChar(key);
  }
}