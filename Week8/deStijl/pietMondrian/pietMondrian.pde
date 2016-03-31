//MALEVICH
//Broadway boogie woogie — 50x50 organic grid
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
}

void draw(){
  mondrian.render();
}

void mousePressed(){
  mondrian.assignSuperLines();
  mondrian.assignColor();
  mondrian.assignPatches();
}

void keyPressed(){
  mondrian.debug = !mondrian.debug;
}
