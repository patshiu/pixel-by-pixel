//MALEVICH

float rando1, rando2;
float rectSize;
void setup(){
  size(displayHeight, displayHeight);
  rando1 = random(0,10);
  rando2 = random(5,15);
  rectSize = random(displayHeight*0.2, displayHeight*0.7);
}

void draw(){
  background(rando1);
  fill(rando2);
  rectMode(CENTER);
  rect(width/2, height/2, rectSize, rectSize);
}

void mousePressed(){
  rando1 = random(0,10);
  rando2 = random(5,15);
  rectSize = random(displayHeight*0.2, displayHeight*0.7);
}
