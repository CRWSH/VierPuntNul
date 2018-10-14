class Curve {

  ArrayList<PVector> path;
  PVector current;
  int max = 100;

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
    stroke(255);
    strokeWeight(4);
    noFill();
    beginShape();
    for (PVector v : path) {
      vertex(v.x, v.y);
    }
    endShape();

    //strokeWeight(8);
    //point(current.x, current.y);
    current = new PVector();
  }
}