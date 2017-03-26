int state=0;
int selected=-1;
int recentSelected=0;
PImage cork;
PFont font1;
PImage newbutton;
PImage trashbin;
PImage handbutton;
PImage drawbutton;
PImage newlist;
PImage unchecked;
PImage checked;
ArrayList<Note> notes = new ArrayList<Note>();
boolean paintMode = false;
void setup (){
  size(600,750);
  frameRate(60);
  noStroke();
  smooth();
  cork = loadImage ("cork-board.jpg");
  newbutton = loadImage ("newbutton.png");
  trashbin = loadImage ("trashbin.png");
  handbutton = loadImage ("handbutton.png");
  drawbutton = loadImage ("drawbutton.png");
  newlist = loadImage("ChecklistButton.png");
  unchecked = loadImage("Unchecked.png");
  checked = loadImage("Checked.png");
  font1 = createFont ("Quicksand-Regular.otf", 20);
}
void draw (){
  if(selected >= 0 & mouseX>Note.side/2 & mouseY>Note.side/2 & mouseX<width-(Note.side/2) & mouseY<height-(Note.side/2))
  {
    if(notes.get(selected).isMouseInside())
    {
      if(paintMode)
      {
        if(mouseButton == LEFT)
        {
          notes.get(selected).paint();
        }
        else if(mouseButton == RIGHT)
        {
          notes.get(selected).erase();
        }
      }
      else
      {
        notes.get(selected).moveToMouse();
      }
    }
  }
  background(cork);
  for(Note n : notes)
  {
    n.show();
  }
  image(newbutton,500,25);
  image(trashbin,510,660);
  image(handbutton,15,660);
  image(drawbutton,105,660);
  image(newlist,500,120);
}
void mousePressed(){
  if(mouseX>500 & mouseY>25 & mouseX<580 & mouseY<105){
    notes.add(new Note());
  }
  if(mouseX>500 & mouseY>120 & mouseX<580 & mouseY<200){
    notes.add(new Checklist());
  }
  if(mouseX>15 & mouseY>660 & mouseX<95 & mouseY<740){
    paintMode = false;
  }
  if(mouseX>105 & mouseY>660 & mouseX<185 & mouseY<740){
    paintMode = true;
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