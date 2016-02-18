ArrayList <PtMod> pts;

//var for "mouseless" / "ghostMouse" modes
boolean mouselessMode;
boolean ghostMouseMode;
PVector ghostMouse;



//GIF EXPORT UTIL
//-----------------------
import gifAnimation.*;
GifMaker gifExport;
boolean record = false;
int frameStart;
float ghostMouseStart;

void setup() {
  size(400,400);
  mouselessMode = false;
  ghostMouse = new PVector(-width*2.0 , -height*2.0);
  pts = new ArrayList<PtMod>();
  float gUnit = 50;
  int rowNum = 0;
  //Display just 1 single pixel
    // PtMod pm = new PtMod(width/2, height/2);
    // pts.add(pm);
  for(int row = 0; row <= width; row += gUnit){
    for(int col = 0; col <= width; col += gUnit){
      if (rowNum % 2 == 0){
        PtMod pm = new PtMod(row, col + gUnit*0.5);
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

void draw(){
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

void keyPressed(){
  //println(keyCode); //debug
  if(keyCode == 49){ //if '1' key is hit, toggle mouselessMode
    mouselessMode = (mouselessMode ? false : true);
    for(PtMod p : pts){
      p.mouselessMode = mouselessMode;
    }
  }
  if(keyCode == 50){ //if '2' key is hit, toggle ghostMouseMode & export gif
    ghostMouseMode = (ghostMouseMode ? false : true);
    ghostMouse.x = -width*2.0;
    ghostMouse.y = -height*2.0;

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

void runCasperRun(){
  float speed = 20;  //pixels per frame at which ghostMouse moves
  if(ghostMouse.x <= width*2.0 || ghostMouse.y <= height*2.0){
    ghostMouse.x += speed;
    ghostMouse.y += speed;
  } else {
    ghostMouse.x = -width*2.0;
    ghostMouse.y = -height*2.0;
  }
}
