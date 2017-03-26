import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class nts extends PApplet {

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
public void setup (){
  
  frameRate(60);
  noStroke();
  
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
public void draw (){
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
public void mousePressed(){
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
    else if(notes.get(i).mouseOnCheck()>=0)
    {
      notes.get(i).flipCheck(notes.get(i).mouseOnCheck());
    }
    else if(notes.get(i).isMouseInside())
    {
      selected = i;
      recentSelected=i;
    }
  }
}
public void mouseReleased()
{
  if(mouseX>510 & mouseY>660 & mouseX<590 & mouseY<740)
  {
    notes.remove(selected);
  }
  selected = -1;
}
public void keyPressed()
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
class Checklist extends Note
{
  boolean[] checks = {false, false, false, false, false};
  Checklist()
  {
    super();
  }
  public void show()                 //draws the note on the screen
  {
    noStroke();               //draw a rectangle
    fill(clrs[clrstate]);
    rect(x,y,side,side);
    
    fill(0);                  //draw the characters written on the note
    textFont(font1);
    text(new String(words,0,wpoint),x+35,y+5,side-40,side-10);
    
    for(int i = 0; i < side; i++)//draw the painted parts of the note
    {
      for(int j = 0; j < side; j++)
      {
        if(dark[i][j])        //if this pixel is painted
        {
          rect(x+i,y+j,1,1);  //make it black
        }
      }
    }
    
    rect(x+125,y+125,25,25);  //draw the color change button
    fill(255);
    text("C",x+130,y+128,25,25);
    
    for(int i = 0; i < 5; i++)
    {
      if(checks[i])
      {
        image(checked,x+5,y+5+25*i);
      }
      else
      {
        image(unchecked,x+5,y+5+25*i);
      }
    }
  }
  public int mouseOnCheck()   //returns true if the mouse is in the checkbox
  {
    if(mouseX>x & mouseX<x+30 & mouseY>y & mouseY<y+side)
    {
      return (mouseY-y-5)/25;
    }
    else
    {
      return -1;
    }
  }
  public void flipCheck(int i)
  {
    checks[i] = !checks[i];
  }
}
class Note
{
  
  final static int side = 150;//side length of the square note
  char[] words;               //contains characters written on the note
  int wpoint;                 //pointer indicating how many characters have been written so far
  int[] clrs = {color(255,255,175), color(255,200,200), color(190,225,255), color(190,255,175)};//colors that can be chosen with the color button
  int clrstate;               //which color is currently selected
  int x;                      //coordinates of the note
  int y;
  boolean[][] dark;           //which pixels are painted
  
  Note()
  {
    words = new char[100];    //max of 100 characters, initially no characters written
    wpoint = 0;
    clrstate = 0;             //start on first color
    x = 50;                   //start in the top left corner
    y = 50;
    dark = new boolean[side][side];//1 entry for each pixel in the square
  }
  
  public void addChar(char c)
  {
    if(wpoint<words.length)   //if you are not yet at max characters
    {
      words[wpoint]=c;        //add the desired character to the array
      wpoint++;               //increment the number of characters written by 1
    }
  }
  
  public void removeChar()
  {
    if(wpoint>0)              //if there is at least 1 character on the note
    {
      words[wpoint-1]=' ';    //remove the character
      wpoint--;               //decrement the number of characters written by 1
    }
  }
  
  public void moveToMouse()
  {
    x = mouseX-(side/2);      //note is centered on the mouse
    y = mouseY-(side/2);
  }
  
  public void changeColor()
  {
    clrstate++;               //move forward 1 color
    if(clrstate > 3)          //if you have gone past the last color
    {
      clrstate = 0;           //go back to the beginning
    }
  }
  
  public void show()                 //draws the note on the screen
  {
    noStroke();               //draw a rectangle
    fill(clrs[clrstate]);
    rect(x,y,side,side);
    
    fill(0);                  //draw the characters written on the note
    textFont(font1);
    text(new String(words,0,wpoint),x+5,y+5,side-10,side-10);
    
    for(int i = 0; i < side; i++)//draw the painted parts of the note
    {
      for(int j = 0; j < side; j++)
      {
        if(dark[i][j])        //if this pixel is painted
        {
          rect(x+i,y+j,1,1);  //make it black
        }
      }
    }
    
    rect(x+125,y+125,25,25);  //draw the color change button
    fill(255);
    text("C",x+130,y+128,25,25);
  }
  
  public boolean isMouseInside()     //returns true if the mouse is in the note
  {
    return (mouseX>x & mouseX<x+side & mouseY>y & mouseY<y+side);
  }
  
  public boolean isMouseOnButton()   //returns true if the mouse is in the color change button
  {
    return (mouseX>x+125 & mouseX<x+side & mouseY>y+125 & mouseY<y+side);
  }
  
  public void paint()                //paints the area around the mouse
  {
    if(mouseX-x>1 & mouseX-x<side-2 & mouseY-y>1 & mouseY-y<side-2)
    {
      for(int i = mouseX-x-2; i < mouseX-x+2; i++)
      {
        for(int j = mouseY-y-2; j < mouseY-y+2; j++)
        {
          dark[i][j] = true;
        }
      }
    }
  }
  
  public void erase()                //removes paint from the area around the mouse
  {
    if(mouseX-x>1 & mouseX-x<side-2 & mouseY-y>1 & mouseY-y<side-2)
    {
      for(int i = mouseX-x-2; i < mouseX-x+2; i++)
      {
        for(int j = mouseY-y-2; j < mouseY-y+2; j++)
        {
          dark[i][j] = false;
        }
      }
    }
  }
  
  public int mouseOnCheck()
  {
    return -1;
  }
  
  public void flipCheck(int i)
  {
  }
}
  public void settings() {  size(600,750);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "nts" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
