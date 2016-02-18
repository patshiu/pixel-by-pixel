/** Point Module
* Object class that
* • draws PImage to master canvas on render()
* • stores self's 3D location on master canvas
* • stores target 3D location and lerps self's location on update()
* • maybe extended to render in other styles
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

  void render(){
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

  void update(){
    //modRender();
    checkClicked();
    modRenderGraph();
    updateLamda();
    //lerps loc to tLoc
  }

  //modRender() defines how one "Pt Module" looks
  //customize here for yer own funkyfresh steez.
  void modRender(){
    PGraphics canvas = createGraphics(20, 20);
    canvas.beginDraw();
      canvas.noFill();
      canvas.stroke(0);
      canvas.strokeWeight(1);
      canvas.ellipse(canvas.width*0.5, canvas.height*0.5, canvas.width, canvas.height);
    canvas.endDraw();
    this.mod = canvas;
  }

  void modRenderGraph(){
    PGraphics canvas = createGraphics(60, 60);
    canvas.beginDraw();
    canvas.loadPixels();

    //float n = map(mouseX, 0, width, -6, 6); //Mapped to MouseX:Width for testing
    //float n = map(sin(lamda),1,-1,6,-6); //Oscillating twirl untwirl

    if(mouselessMode){
      dMouse = lerp(dMouse, 1, 0.1);
    } else if (ghostMouseMode) {
      dMouse = lerp(dMouse, map(dist(ghostMouse.x, ghostMouse.y, loc.x,loc.y), 0, sqrt(sq(width*0.5) + sq(height*0.5)), 0, 1), 0.2);
    } else {
      dMouse = lerp(dMouse, map(dist(mouseX,mouseY,loc.x,loc.y), 0, sqrt(sq(width*0.5) + sq(height*0.5)), 0, 1), 0.2);
      //dMouse = map(dist(mouseX,mouseY,loc.x,loc.y), 0, sqrt(sq(width*0.5) + sq(height*0.5)), 0, 1);
    }
    float n = dMouse * -6;
    float w = 10.0;         // 2D space width
    float h = 10.0;         // 2D space height
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
        float c =   (val + 1.0) * 255.0/2.0;
        float dEdge = 1 - (sqrt(sq(abs(canvas.width*0.5 - i)) + sq(abs(canvas.height*0.5 - j)))/sqrt(sq(canvas.width*0.5)+sq(canvas.height*0.5))); //Distance from the edge of mod

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

  void updateLamda(){
    float increment = TWO_PI/90.0;
    if(lamda + increment > TWO_PI ){
      this.lamda = (lamda + increment) - TWO_PI;
    } else {
      this.lamda += increment;
    }
  }

  void checkClicked(){
    float dMouse = map(dist(mouseX,mouseY,loc.x,loc.y), 0, sqrt(sq(width*0.5) + sq(height*0.5)), 0, 1);
    if(mousePressed && dMouse < 0.10){
      this.isDrawn = true;
    }
  }

}
