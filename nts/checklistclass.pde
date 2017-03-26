class Checklist extends Note
{
  boolean[] checks = {false, false, false, false, false};
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
}