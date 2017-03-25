int state=0;
int selected=2;
int x = 150;
int y = 150;
Note nn = new Note();
void setup (){
  size(600,600);
  frameRate(30);
  noStroke();
}
void draw (){
  if (selected == 0)
  {
    x=mouseX;
    y=mouseY;
  }
  else if(selected == 1)
  {
    nn.moveToMouse();
  }
  background(255,255,255);
  nn.show();
  if (state==0){
    fill(255,181,197);
  }
  else if (state==1){
    fill(185,211,238);
  }
  rect(x,y,200,100);
}
void mousePressed(){
  if (mouseX>x & mouseX<x+200 & mouseY>y & mouseY<y+100){
    if (state==0){
      state=1;
    }
    else if (state==1){
      state=0;
    }
    selected=0;
  }
  else if(mouseX>nn.x&mouseX<nn.x+nn.side&mouseY>nn.y&mouseY<nn.y+nn.side)
  {
    selected=1;
  }
}
void mouseReleased()
{
  selected = 2;
}
void keyPressed()
{
  if(keyCode == BACKSPACE)
  {
    nn.removeChar();
  }
  else
  {
    nn.addChar(key);
  }
}