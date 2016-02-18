import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TextureStudy02 extends PApplet {

ArrayList <PtMod> pts;

//var for "mouseless" / "ghostMouse" modes
boolean mouselessMode;
boolean ghostMouseMode;
PVector ghostMouse;



//GIF EXPORT UTIL
//-----------------------

GifMaker gifExport;
boolean record = false;
int frameStart;
float ghostMouseStart;

public void setup() {
  size(400,400);
  mouselessMode = false;
  ghostMouse = new PVector(-width*2.0f , -height*2.0f);
  pts = new ArrayList<PtMod>();
  float gUnit = 50;
  int rowNum = 0;
  //Display just 1 single pixel
    // PtMod pm = new PtMod(width/2, height/2);
    // pts.add(pm);
  for(int row = 0; row <= width; row += gUnit){
    for(int col = 0; col <= width; col += gUnit){
      if (rowNum % 2 == 0){
        PtMod pm = new PtMod(row, col + gUnit*0.5f);
        pts.add(pm);
      } else {
        PtMod pm = new PtMod(row, col);
        pts.add(pm);
      }
    }
    rowNum++;
  }
  //	GIF EXPORT UTIL
  //	-----------------------
  	frameRate(12);
  	gifExport = new GifMaker(this, "TextureStudy02-single_pixel.gif");
  	gifExport.setRepeat(0);

}

public void draw(){
  background(0);
  if (ghostMouseMode){
    runCasperRun();
  }
  for(PtMod p : pts){
    p.render();
  }
  fill(0);
  //text(frameRate, 20,20);

  //GIF EXPORT UTIL
	//-----------------------

	if(record){
    int frameAdded = frameCount - frameStart;
		gifExport.setDelay(1);
		gifExport.addFrame();
		println("frame added: " + frameAdded);

		if(ghostMouseMode == true && ghostMouse.x == ghostMouseStart && frameAdded > 10){
			gifExport.finish();
			record = false;
			println("\n\n\nrecord done!");
			exit();
		}
	}
}

public void keyPressed(){
  //println(keyCode); //debug
  if(keyCode == 49){ //if '1' key is hit, toggle mouselessMode
    mouselessMode = (mouselessMode ? false : true);
    for(PtMod p : pts){
      p.mouselessMode = mouselessMode;
    }
  }
  if(keyCode == 50){ //if '2' key is hit, toggle ghostMouseMode & export gif
    ghostMouseMode = (ghostMouseMode ? false : true);
    ghostMouse.x = -width*2.0f;
    ghostMouse.y = -height*2.0f;

    // ghostMouse.x = 0;
    // ghostMouse.y = 0;
    mouselessMode = false;
    for(PtMod p : pts){
      p.ghostMouseMode = ghostMouseMode;
      p.mouselessMode = false;
    }

    //TRIGGER GIF EXPORT
    // record = true;
    // frameStart = frameCount;
    // ghostMouseStart = ghostMouse.x;
  }
  if(keyCode == 51){ //if '3' key is hit, reset
    for(PtMod p : pts){
      p.isDrawn = false;
    }
  }

  if(keyCode == 52){ //if '4' key is hit, start record
    //TRIGGER GIF EXPORT
    if(record){ //if currently recording, stop record
      gifExport.finish();
      record = false;
      println("\n\n\nrecord done!");
      exit();
    } else { //else start record
      record = true;
      frameStart = frameCount;
    }
  }
}

public void runCasperRun(){
  float speed = 20;  //pixels per frame at which ghostMouse moves
  if(ghostMouse.x <= width*2.0f || ghostMouse.y <= height*2.0f){
    ghostMouse.x += speed;
    ghostMouse.y += speed;
  } else {
    ghostMouse.x = -width*2.0f;
    ghostMouse.y = -height*2.0f;
  }
}
/** Point Module
* Object class that
* \u2022 draws PImage to master canvas on render()
* \u2022 stores self's 3D location on master canvas
* \u2022 stores target 3D location and lerps self's location on update()
* \u2022 maybe extended to render in other styles
*/


class PtMod {

  PVector loc;
  PVector tLoc;
  PImage mod;
  boolean in3D;


  //modRenderGraph vars
  float lamda = 0;
  boolean isDrawn = false;
  float dMouse  = 1;

  boolean mouselessMode;
  boolean ghostMouseMode;


  PtMod(float x, float y){
    this.in3D = false;
    this.loc = new PVector(x,y);
    this.tLoc = new PVector(x,y);
  }

  PtMod(float x, float y, float z){
    this.in3D = true;
    this.loc = new PVector(x,y,z);
    this.tLoc = new PVector(x,y,z);
  }

  public void render(){
    //draws self to canvas
    imageMode(CENTER);
    update();
    if(in3D){
      pushMatrix();
        translate(loc.x, loc.y, loc.z);
        image(mod,0,0);
      popMatrix();
    } else {
       image(mod,loc.x, loc.y);
    }
  }

  public void update(){
    //modRender();
    checkClicked();
    modRenderGraph();
    updateLamda();
    //lerps loc to tLoc
  }

  //modRender() defines how one "Pt Module" looks
  //customize here for yer own funkyfresh steez.
  public void modRender(){
    PGraphics canvas = createGraphics(20, 20);
    canvas.beginDraw();
      canvas.noFill();
      canvas.stroke(0);
      canvas.strokeWeight(1);
      canvas.ellipse(canvas.width*0.5f, canvas.height*0.5f, canvas.width, canvas.height);
    canvas.endDraw();
    this.mod = canvas;
  }

  public void modRenderGraph(){
    PGraphics canvas = createGraphics(60, 60);
    canvas.beginDraw();
    canvas.loadPixels();

    //float n = map(mouseX, 0, width, -6, 6); //Mapped to MouseX:Width for testing
    //float n = map(sin(lamda),1,-1,6,-6); //Oscillating twirl untwirl

    if(mouselessMode){
      dMouse = lerp(dMouse, 1, 0.1f);
    } else if (ghostMouseMode) {
      dMouse = lerp(dMouse, map(dist(ghostMouse.x, ghostMouse.y, loc.x,loc.y), 0, sqrt(sq(width*0.5f) + sq(height*0.5f)), 0, 1), 0.2f);
    } else {
      dMouse = lerp(dMouse, map(dist(mouseX,mouseY,loc.x,loc.y), 0, sqrt(sq(width*0.5f) + sq(height*0.5f)), 0, 1), 0.2f);
      //dMouse = map(dist(mouseX,mouseY,loc.x,loc.y), 0, sqrt(sq(width*0.5) + sq(height*0.5)), 0, 1);
    }
    float n = dMouse * -6;
    float w = 10.0f;         // 2D space width
    float h = 10.0f;         // 2D space height
    float dx = w / canvas.width;    // Increment x this amount per pixel
    float dy = h / canvas.height;   // Increment y this amount per pixel
    float x = -w/2;          // Start x at -1 * width / 2
    for (int i = 0; i < canvas.width; i++) {
      float y = -h/2;        // Start y at -1 * height / 2
      for (int j = 0; j < canvas.height; j++) {

        float r = sqrt((x*x) + (y*y));    // Convert cartesian to polar
        float theta = atan2(y,x);         // Convert cartesian to polar

        // Compute 2D polar coordinate function
        float val = sin(n*cos(r) + 10 * theta);           // Results in a value between -1 and 1
        //float val = cos(r);                            // Another simple function
        //float val = sin(theta);                        // Another simple function
        // Map resulting vale to grayscale
        float c =   (val + 1.0f) * 255.0f/2.0f;
        float dEdge = 1 - (sqrt(sq(abs(canvas.width*0.5f - i)) + sq(abs(canvas.height*0.5f - j)))/sqrt(sq(canvas.width*0.5f)+sq(canvas.height*0.5f))); //Distance from the edge of mod

        if(isDrawn){
          canvas.pixels[i+j*canvas.width] = color( c*(1-dMouse), c*sq(dMouse), c, sq(dEdge)*255);     //inverse colors
        } else {
          canvas.pixels[i+j*canvas.width] = color( c*dMouse, c*sq(1-dMouse), 255-c, sq(dEdge)*255);     //regular colors
        }

        y += dy;                // Increment y
      }
      x += dx;                  // Increment x
    }
    canvas.updatePixels();
    canvas.endDraw();
    this.mod = canvas;
  }

  public void updateLamda(){
    float increment = TWO_PI/90.0f;
    if(lamda + increment > TWO_PI ){
      this.lamda = (lamda + increment) - TWO_PI;
    } else {
      this.lamda += increment;
    }
  }

  public void checkClicked(){
    float dMouse = map(dist(mouseX,mouseY,loc.x,loc.y), 0, sqrt(sq(width*0.5f) + sq(height*0.5f)), 0, 1);
    if(mousePressed && dMouse < 0.10f){
      this.isDrawn = true;
    }
  }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TextureStudy02" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
