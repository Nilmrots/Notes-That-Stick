class Note
{
  
  final static int side = 150;//side length of the square note
  char[] words;               //contains characters written on the note
  int wpoint;                 //pointer indicating how many characters have been written so far
  color[] clrs = {color(255,255,175), color(255,200,200), color(190,225,255), color(190,255,175)};//colors that can be chosen with the color button
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
  
  void addChar(char c)
  {
    if(wpoint<words.length)   //if you are not yet at max characters
    {
      words[wpoint]=c;        //add the desired character to the array
      wpoint++;               //increment the number of characters written by 1
    }
  }
  
  void removeChar()
  {
    if(wpoint>0)              //if there is at least 1 character on the note
    {
      words[wpoint-1]=' ';    //remove the character
      wpoint--;               //decrement the number of characters written by 1
    }
  }
  
  void moveToMouse()
  {
    x = mouseX-(side/2);      //note is centered on the mouse
    y = mouseY-(side/2);
  }
  
  void changeColor()
  {
    clrstate++;               //move forward 1 color
    if(clrstate > 3)          //if you have gone past the last color
    {
      clrstate = 0;           //go back to the beginning
    }
  }
  
  void show()                 //draws the note on the screen
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
  
  boolean isMouseInside()     //returns true if the mouse is in the note
  {
    return (mouseX>x & mouseX<x+side & mouseY>y & mouseY<y+side);
  }
  
  boolean isMouseOnButton()   //returns true if the mouse is in the color change button
  {
    return (mouseX>x+125 & mouseX<x+side & mouseY>y+125 & mouseY<y+side);
  }
  
  void paint()                //paints the area around the mouse
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
  
  void erase()                //removes paint from the area around the mouse
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
  
  int mouseOnCheck()
  {
    return -1;
  }
  
  void flipCheck(int i)
  {
  }
}