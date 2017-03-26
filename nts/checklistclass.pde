class Checklist extends Note
{
  Checklist()
  {
    super();
  }
  void show()                 //draws the note on the screen
  {
    noStroke();               //draw a rectangle
    fill(clrs[clrstate]);
    rect(x,y,side,side);
    
    fill(0);                  //draw the characters written on the note
    textFont(font1);
    text(new String(words,0,wpoint),x+30,y+5,side-10,side-10);
    
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
  }
}