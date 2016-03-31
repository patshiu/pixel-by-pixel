//MONDRIAN
//Broadway boogie woogie — 50x50 organic grid

import processing.video.*;
Capture ourVideo;

Histogram histo;

boolean histoDebug;

float gridSize;
color canvasColor = color(#f2f3ee);
color white = color(#dcddda);
color red = color(#983b2f);
color blueDark = color(#3c448b);
color blueLight = color(#5268b9);
color yellow = color(#e1d037);
color[] palette;

float superVerts[], superHorzs[];
PVector[][] grid;

MondrianSys mondrian;

void setup(){
  size(500, 500); //TODO
  mondrian = new MondrianSys();
  frameRate(30);
  ourVideo = new Capture(this, 1280, 720);    // open the capture in the size of the window
  ourVideo.start();

  histo = new Histogram();
}

void draw(){

  if (ourVideo.available())  ourVideo.read();           // get a fresh frame as often as we can
    ourVideo.loadPixels();                               // load the pixels array of the video
    //get histogram data
  float avgBrightness, overallContrast, percantageDark, percentageBright;
  for(color c : ourVideo.pixels){
  }
  histo.chart(ourVideo.pixels);
    //more red patches if dark
    //more line if contrasty
  mondrian.render();
  if(histoDebug){
    image(histo.show(), 10,10);
  }
}

void mousePressed(){
  mondrian.assignSuperLines();
  mondrian.assignColor();
  mondrian.assignPatches(histo.percentageBright, histo.percentageDark);
}

void keyPressed(){
  //println(keyCode);
  if(keyCode == 38)
    mondrian.debug = !mondrian.debug;
  if(keyCode == 40)
    histoDebug = !histoDebug;
}
