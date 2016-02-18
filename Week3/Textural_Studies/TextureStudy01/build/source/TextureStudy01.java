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

public class TextureStudy01 extends PApplet {

ArrayList <PtMod> pts;

public void setup() {
  size(400,400);
  pts = new ArrayList<PtMod>();
  for(int row = 0; row <= width; row += 50){
    for(int col = 0; col <= width; col += 50){
      PtMod pm = new PtMod(row, col);
      pts.add(pm);
    }
  }
}

public void draw(){
  background(255);
  for(PtMod p : pts){
    p.render();
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
  // boolean 3DMode;


  PtMod(float x, float y){
    //this.3DMode = false;
    this.loc = new PVector(x,y);
    this.tLoc = new PVector(x,y);
  }

  PtMod(float x, float y, float z){
    //this.3DMode = true;
    this.loc = new PVector(x,y,z);
    this.tLoc = new PVector(x,y,z);
  }

  public void render(){
    //draws self to canvas
    imageMode(CENTER);
    update();
    // if(3DMode){
      // image(mod,loc.x, loc.y, loc.z);
    // } else {
       image(mod,loc.x, loc.y);
    // }

  }

  public void update(){
    //modRender();
    modRenderGraph();
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

    float n = map(mouseX, 0, width, -6, 6); //Mapped to MouseX:Width for testing
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
        canvas.pixels[i+j*canvas.width] = color( c, sq(dEdge)*255);     // Scale to between 0 and 255
        y += dy;                // Increment y
      }
      x += dx;                  // Increment x
    }
    canvas.updatePixels();
    canvas.endDraw();
    this.mod = canvas;
  }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TextureStudy01" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
