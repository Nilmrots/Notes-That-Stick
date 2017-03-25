int state=0;
void setup (){
  size(600,600);
  background(255,255,255);
  noStroke();
}
void draw (){
  rect(150,150,200,100);
  if (state==0){
    fill(255,181,197);
  }
  else if (state==1){
    fill(185,211,238);
  }
}
void mouseClicked(){
  if (mouseX>150 & mouseX<350 & mouseY>150 & mouseY<350){
    if (state==0){
      state=1;
    }
    else if (state==1){
      state=0;
    }
  }
}
