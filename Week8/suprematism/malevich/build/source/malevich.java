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

public class malevich extends PApplet {

//MALEVICH

float rando1, rando2;
float rectSize;
public void setup(){
  size(displayHeight, displayHeight);
  rando1 = random(0,10);
  rando2 = random(5,15);
  rectSize = random(displayHeight*0.2f, displayHeight*0.7f);
}

public void draw(){
  background(rando1);
  fill(rando2);
  rectMode(CENTER);
  rect(width/2, height/2, rectSize, rectSize);
}

public void mousePressed(){
  rando1 = random(0,10);
  rando2 = random(5,15);
  rectSize = random(displayHeight*0.2f, displayHeight*0.7f);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "malevich" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
