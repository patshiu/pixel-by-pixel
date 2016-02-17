ArrayList <PtMod> pts;

void setup() {
  size(400,400);
  pts = new ArrayList<PtMod>();
  for(int row = 0; row <= width; row += 20){
    for(int col = 0; col <= width; col += 20){
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
