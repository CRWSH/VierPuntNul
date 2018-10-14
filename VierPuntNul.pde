// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #116: Lissajous Curve Table
// https://youtu.be/--6eyLO78CY

// p5.js version:
// https://editor.p5js.org/codingtrain/sketches/BJbj5l3Y7

float angle = 0;
int w = 750;
float mult1 = 3;
Curve curve = new Curve();


void setup() {
  size(800, 800);
  
}

void draw() {
  background(0);
  float d = w - 0.2*w;
  float r = d/2;

  noFill();
  stroke(255);
  
  float cx = (width-w)/2 + w / 2;
  float cy = (height-w)/2 + w / 2;
  float x1 = r * cos(angle*mult1  - HALF_PI);
  float y1 = r * sin(angle*mult1  - HALF_PI);
  //stroke(255, 150);
  //strokeWeight(1);
  //line(cx + x1, 0, cx + x1, height); 

  
  curve.setX(cx + x1);
  
  

  noFill();
  stroke(255);
  float x2 = r * cos(angle - HALF_PI);
  float y2 = r * sin(angle - HALF_PI);
  //stroke(255, 150);
  //strokeWeight(1);
  //line(0, cy + y2, width, cy + y2);

  
  curve.setY(cy + y2);
  
  

  
  curve.addPoint();
  curve.show();
 


  angle -= 0.01;

  //if (angle < -TWO_PI) {
  
  //  curve.reset();
    
  //  saveFrame("lissajous.png");
  //  angle = 0;
  //}
}