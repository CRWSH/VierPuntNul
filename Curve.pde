class Curve {

  ArrayList<PVector> path;
  PVector current;
  int max = 19;

  Curve() {
    path = new ArrayList<PVector>();
    current = new PVector();
  }

  void setX(float x) {
    current.x = x;
  }

  void setY(float y) {
    current.y = y;
  }

  void addPoint() {
    path.add(current);
    while(path.size() > max) {
      path.remove(0);
    }
  }
  
  void reset() {
    path.clear(); 
  }

  void show() {
    pg.stroke(black);
    pg.strokeWeight(6);
    pg.noFill();
    pg.beginShape();
    for (PVector v : path) {
      pg.vertex(v.x, v.y);
    }
    pg.endShape();

    //strokeWeight(8);
    //point(current.x, current.y);
    current = new PVector();
  }
}