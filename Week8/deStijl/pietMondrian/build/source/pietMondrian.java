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

public class pietMondrian extends PApplet {

//MALEVICH
//Broadway boogie woogie \u2014 50x50 organic grid
float gridSize;
int canvasColor = color(0xfff2f3ee);
int white = color(0xffdcddda);
int red = color(0xff983b2f);
int blueDark = color(0xff3c448b);
int blueLight = color(0xff5268b9);
int yellow = color(0xffe1d037);
int[] palette;

float superVerts[], superHorzs[];
PVector[][] grid;

MondrianSys mondrian;

public void setup(){
  size(500, 500); //TODO
  mondrian = new MondrianSys();
}

public void draw(){
  mondrian.render();
}

public void mousePressed(){
  mondrian.assignSuperLines();
  mondrian.assignColor();
  mondrian.assignPatches();
}

public void keyPressed(){
  mondrian.debug = !mondrian.debug;
}
class MondrianSys {
  PVector[][] grid;
  int[][] colorGrid;
  boolean[][] isPatch;
  int gridSize;
  int[][] superVerts; //x position and y position of termination if any
  int[][] superHorz; //y position and x position of termination of any

  boolean debug = false;

  //COLOR DATA
  int canvasColor = color(0xfff2f3ee);
  int white = color(0xffdcddda);
  int red = color(0xff983b2f);
  int blueDark = color(0xff3c448b);
  int blueLight = color(0xff5268b9);
  int yellow = color(0xffe1d037);
  int[] palette = new int[]{canvasColor, white, red, blueDark, blueLight, yellow};

  MondrianSys(){
    gridSize = 10; //TODO
    initGrid(gridSize);
    assignSuperLines();
    assignColor();
    assignPatches();
  }

  public void assignColor(){
    colorGrid = new int[PApplet.parseInt(width/gridSize)+2][PApplet.parseInt(height/gridSize)+2];
    for(int y = 0; y < height/gridSize+1; y++){
      for(int x = 0; x < width/gridSize; x++ ){
        colorGrid[x][y] = canvasColor;
        if(superHorz[y][0] == 1){
          colorGrid[x][y] = yellow;
          if(floor(random(0,1.6f))>0){ //at random, set line to diff colors
            colorGrid[x][y] = palette[floor(random(2,6))];
          }
        }
        if(superVerts[x][0] == 1){
          colorGrid[x][y] = yellow;
          if(floor(random(0,1.6f))>0){ //at random, set line to diff colors
            colorGrid[x][y] = palette[floor(random(2,6))];
          }
        }
        if(superVerts[x][0] == 1 && superHorz[y][0] == 1){ //when grid meet
          colorGrid[x][y] = palette[floor(random(1,6))];
        }
      }
    }
  }

  public void assignPatches(){
    isPatch = new boolean[PApplet.parseInt(width/gridSize)+2][PApplet.parseInt(height/gridSize)+2];
    int maxXGrid = width/gridSize+1;
    int maxYGrid = height/gridSize+1;
    for(int y = 0; y < height/gridSize+1; y++){
      for(int x = 0; x < width/gridSize+1; x++ ){
        //if you're on a superHorz, you have a 70% chance of being a sprouter
        if(superVerts[x][0] == 1){
          //FOR SMALL LIGHT BLUE SQUARES
          int distToNextVert = 0;
          int currentLoc = x+1;
          boolean nextVertFound = false;
          while(currentLoc < maxXGrid-1 && nextVertFound == false){
            if(superVerts[currentLoc][0] == 0){
              distToNextVert++;
            } else {
              nextVertFound = true;
              println("distToNextVert: " + distToNextVert);
            }
            currentLoc ++;
            //println("current i: " + currentLoc);
          }
          //println("distToNextVert: " + distToNextVert);
          if(random(0,1) > 0.7f && colorGrid[x][y] != blueLight){
            int width = (floor(random(3,5)));
            int height = (floor(random(3,6)));
            int c = palette[4];
            if(width == distToNextVert){ //Only draw blueLight squares in little nooks
              //Check that surrounding is not patch before rendering
              boolean patSaysProceed = true;
              for(int py = -1; py < height+1; py++){
                for(int px = -1; px < width+1; px++){
                  int xloc = constrain(x+px, 0, maxXGrid);
                  int yloc = constrain(y+py, 0, maxYGrid);
                  if(isPatch[xloc][yloc] == true){
                    patSaysProceed = false;
                  }
                }
              }
              if(patSaysProceed == true){ //if not touching other squares, then proceed
                for(int py = 0; py < height; py++){
                  for(int px = 0; px < width; px++){
                    int xloc = constrain(x+px+1, 0, maxXGrid);
                    int yloc = constrain(y+py+1, 0, maxYGrid);
                    colorGrid[xloc][yloc] = c;
                    isPatch[xloc][yloc] = true;
                  }
                }
              }
            }
          }
          //FOR LARGER RED SQUARES
          int xloc1 = constrain(x+1, 0, maxXGrid);
          int yloc1 = constrain(y+1, 0, maxYGrid);
          if(random(0,1) > 0.97f && colorGrid[xloc1][yloc1] != blueLight && colorGrid[xloc1][yloc1] != red){
            int width = (floor(random(4,8)));
            width = distToNextVert+1;
            int height = (floor(random(4,10)));
            //Asssign color by chance
            int c = red;
            if(random(0,1) > 0.95f){
              c = blueLight;
            }
            if(random(0,1) > 0.95f){
              c = yellow;
            }

            //Check that surrounding is not patch before rendering
            boolean patSaysProceed = true;
            for(int py = -1; py < height+1; py++){
              for(int px = -1; px < width+1; px++){
                int xloc = constrain(x+px, 0, maxXGrid);
                int yloc = constrain(y+py, 0, maxYGrid);
                if(isPatch[xloc][yloc] == true){
                  patSaysProceed = false;
                }
              }
            }
            if(patSaysProceed == true){ //if not touching other squares, then proceed
              for(int py = 0; py < height-1; py++){
                for(int px = 0; px < width-1; px++){
                  int xloc = constrain(x+px+1, 0, maxXGrid);
                  int yloc = constrain(y+py+1, 0, maxYGrid);
                  colorGrid[xloc][yloc] = c;
                  isPatch[xloc][yloc] = true;
                }
              }
              //Fill with white center
              int wMargin = floor(random(0,2));
              int hMargin = floor(random(1,3));
              c = white;
              if(random(0,1) > 0.9f){
                c = yellow;
              }

              for(int py = hMargin; py < height-hMargin-1; py++){
                for(int px = wMargin; px < width-wMargin-1; px++){
                  int xloc = constrain(x+px+1, 0, maxXGrid);
                  int yloc = constrain(y+py+1, 0, maxYGrid);
                  colorGrid[xloc][yloc] = c;
                  isPatch[xloc][yloc] = true;
                }
              }
            }
          }
        }
        //if youre on a superVert, you have a 25% chance of being a sprouter
        //if you're a square, you have a ____% chance of being a nippl
      }
    }
  }

  public void assignSuperLines(){
    //~20% chance of being a visible line
    superVerts = new int[PApplet.parseInt(width/gridSize)+2][2];
    superHorz = new int[PApplet.parseInt(height/gridSize)+2][2];
    //vert lines have a ____% chance of terminating / reliving when colliding with a horz line
    //horz lines have a ____% chance of terminating / reliving when colliding with a horz line

    for(int y = 0; y < height/gridSize+1; y++){

      if(y>0){
         if(superHorz[y-1][0] > 0){   //dedupe make sure no adjecent
           superHorz[y][0] = 0;
         } else {
           superHorz[y][0] = floor(random(0,1.25f)) ; //is it a Horz?
         }
      } else {
        superHorz[y][0] = floor(random(0,1.25f)) ; //is it a Horz?
      }
      superHorz[y][1] = -1; //does it terminate? TODO
    }

    for(int x = 0; x < width/gridSize+1; x++){
      if(x>0){
        if(superVerts[x-1][0] > 0){     //dedupe make sure no adjecent
          superVerts[x][0] = 0;
        } else {
          superVerts[x][0] = floor(random(0,1.15f)); //is it a vert?
        }
      } else {
        superVerts[x][0] = floor(random(0,1.15f)); //is it a vert?
      }

      //Terminated superVerts have a 20% chance of re-generating
      superVerts[x][1] = -1; //does it terminate? TODO
      if(floor(random(0,2.0f)) > 0){//SuperVerts have a 50% chance of terminating
        superVerts[x][1] = floor(random(PApplet.parseInt(height*0.25f/gridSize), PApplet.parseInt(height/gridSize)+2)); //assign random termination point from 25% of top of canvas to canvas bottom
      }
    }
  }

  public void render(){
    background(canvasColor);
    //DRAW GRID
    for(int y = 0; y < height/gridSize+1; y++){
      for(int x = 0; x < width/gridSize; x++ ){
        PVector loc = grid[x][y];
        PVector locRight = grid[x+1][y];
        PVector locDown = grid[x][y+1];
        PVector locDownRight = grid[x+1][y+1];

        ////DRAW GRID
        // strokeWeight(0.5);
        // stroke(0);
        // line(loc.x, loc.y, locRight.x, locRight.y);
        // line(loc.x, loc.y, locDown.x, locDown.y);

        //DRAW POLY
        stroke(0.2f);
        int c = colorGrid[x][y];
        if(debug == true){
          c =  isPatch[x][y] ? canvasColor : color(0xff000000);
        }
        fill(c);
        stroke(c);
        beginShape();
        vertex(loc.x, loc.y);
        vertex(locRight.x, locRight.y);
        vertex(locDownRight.x, locDownRight.y);
        vertex(locDown.x, locDown.y);
        endShape();
      }
    }
  }


  public void refresh(){
    initGrid(gridSize);
  }

  public void initGrid(int gridSize){
    grid = new PVector[PApplet.parseInt(width/gridSize)+2][PApplet.parseInt(height/gridSize)+2];
    for(int y = 0; y < height/gridSize + 2; y++){
      for(int x = 0; x < width/gridSize + 1; x++ ){
        grid[x][y] = new PVector(x * gridSize + map(noise(x,y),0,1,-1,1), y * gridSize + map(noise(x,y),0,1,-1,1));
      }
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pietMondrian" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
