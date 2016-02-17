/** Point Module
* Object class that
* • draws PImage to master canvas on render()
* • stores self's 3D location on master canvas
* • stores target 3D location and lerps self's location on update()
* • maybe extended to render in other styles
*/
class PtMod {

  boolean 3DMode;
  PVector loc;
  PVector tLoc;
  PImage mod;


  PtMod(float x, float y){
    this.3DMode = false;
    this.loc = new PVector(x,y);
    this.tLoc = new PVector(x,y);
  }

  PtMod(float x, float y, float z){
    this.3DMode = true;
    this.loc = new PVector(x,y,z);
    this.tLoc = new PVector(x,y,z);
  }

  void render(){
    //draws self to canvas
    imageMode(CENTER);
    update();
    if(3DMode){
      image(mod,loc.x, loc.y, loc.z);
    } else {
      image(mod,loc.x, loc.y);
    }

  }

  void update(){
    modRender();
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

}
