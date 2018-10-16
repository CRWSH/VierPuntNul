// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #116: Lissajous Curve Table
// https://youtu.be/--6eyLO78CY

// p5.js version:
// https://editor.p5js.org/codingtrain/sketches/BJbj5l3Y7

float angle1 = 0;
float angle2 = 0; 
int w = 750;
float mult1 = 4;
Curve curve = new Curve();
PGraphics pg;
float cx,cy, x1old, y1old;



void setup() {
  size(800, 800, P2D);
  background(0);
  pg = createGraphics(width,height);
  cx = (width-w)/2 + w / 2;
  cy = (height-w)/2 + w / 2;
  x1old = 0;
  y1old = w;
  
}

void draw() {
  //background(0);
  float d = w - 0.2*w;
  float r = d/2;
  
  pg.beginDraw();
  
  pg.background(0);

  pg.noFill();
  pg.stroke(255);
  
  
  float x1 = r * cos(angle1*mult1  - HALF_PI);
  float y1 = r * sin(angle1 - HALF_PI);
  
  float x2 = 40*sin(angle2);
  
  float dify = -(x1-x1old);
  float difx = (y1 - y1old);
  float dis = sqrt(sq(dify) +sq(difx));
  PVector sl = new PVector(difx/dis, dify/dis);
  
  sl.mult(x2);
  
  
  x1old = x1;
  y1old = y1;
  //stroke(255, 150);
  //strokeWeight(1);
  //line(cx + x1, 0, cx + x1, height); 

  
  curve.setX(cx + x1 + sl.x);
  
  

  pg.noFill();
  pg.stroke(255);
 
  
  //stroke(255, 150);
  //strokeWeight(1);
  //line(0, cy + y2, width, cy + y2);

  
  curve.setY(cy + y1 + sl.y);
  
  

  
  curve.addPoint();
  curve.show();
  
  pg.endDraw();
  
  image(pg, 0,0);
 


  angle1 -= 0.005;
  angle2 -= 0.5;

  //if (angle < -TWO_PI) {
  
  //  curve.reset();
    
  //  saveFrame("lissajous.png");
  //  angle = 0;
  //}
}