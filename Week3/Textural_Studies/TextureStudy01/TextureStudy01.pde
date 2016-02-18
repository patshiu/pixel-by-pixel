ArrayList <PtMod> pts;

void setup() {
  size(400,400);
  pts = new ArrayList<PtMod>();
  for(int row = 0; row <= width; row += 50){
    for(int col = 0; col <= width; col += 50){
      PtMod pm = new PtMod(row, col);
      pts.add(pm);
    }
  }
}

void draw(){
  background(255);
  for(PtMod p : pts){
    p.render();
  }
}
