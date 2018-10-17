// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #116: Lissajous Curve Table
// https://youtu.be/--6eyLO78CY

// p5.js version:
// https://editor.p5js.org/codingtrain/sketches/BJbj5l3Y7

float[] anglelis = {0,HALF_PI,PI,PI + HALF_PI};
float anglesin = 0; 
int w = 750;
float mult1 = 5;
Curve[] curve = new Curve[4];
PGraphics pg;
float cx,cy,d,r;
float[] x1old, y1old, x1 = {0,0,0,0}, y1 = {0,0,0,0};
PVector c1, c2, c3, c4;



void setup() {
  size(800, 800, P2D);
  background(0);
  pg = createGraphics(width,height);
  cx = (width-w)/2 + w / 2;
  cy = (height-w)/2 + w / 2;
  d = w - 0.2*w;
  r = d/2;
  
  x1old = new float[4];
  y1old = new float[4];
  
  c1 = new PVector((width-w)/2+w/16,(height-w)/2+w/16);
  c2 = new PVector(width-((width-w)/2+w/16), (height-w)/2+w/16);
  c3 = new PVector(width-((width-w)/2+w/16), height-((height-w)/2+w/16));
  c4 = new PVector((width-w)/2+w/16, height-((height-w)/2+w/16));
  for(int i=0; i<anglelis.length; i++){
    x1old[i] = r * cos(anglelis[i]*mult1  - HALF_PI);
    y1old[i] = r * sin(anglelis[i] - HALF_PI);
    curve[i] = new Curve();
  }
  
  frameRate(25);
  
}

void draw() {   
    pg.beginDraw();
    
    pg.background(0);
    pg.fill(255);
    pg.noStroke();
    pg.ellipse(c1.x, c1.y, 40, 40);
    pg.ellipse(c2.x, c2.y, 40, 40);
    pg.ellipse(c3.x, c3.y, 40, 40);
    pg.ellipse(c4.x, c4.y, 40, 40);
  
    pg.noFill();
    pg.stroke(255);
    pg.strokeWeight(1);
    
    pg.line(c1.x, c1.y,c2.x, c2.y);
    pg.line(c2.x, c2.y,c3.x, c3.y);
    pg.line(c3.x, c3.y,c4.x, c4.y);
    pg.line(c4.x, c4.y,c1.x, c1.y);
    pg.line(c1.x, c1.y,c3.x, c3.y);
    pg.line(c2.x, c2.y,c4.x, c4.y);
    
    
    float x2 = 20*sin(anglesin);
    
    for(int i=0; i<anglelis.length; i++){
    
    x1[i] = r * cos(anglelis[i]*mult1  - HALF_PI);
    y1[i] = r * sin(anglelis[i] - HALF_PI);
    
    float dify = -(x1[i]-x1old[i]);
    float difx = (y1[i] - y1old[i]);
    float dis = sqrt(sq(dify) +sq(difx));
    PVector sl = new PVector(difx/dis, dify/dis);
    
    sl.mult(x2);
    
    x1old[i] = x1[i];
    y1old[i] = y1[i];
    
    curve[i].setX(cx + x1[i] + sl.x);
    curve[i].setY(cy + y1[i] + sl.y);
    
    
    pg.noFill();
    pg.stroke(255);
    
    curve[i].addPoint();
    curve[i].show();
    
  
    anglelis[i] -= 0.005;
  }
  anglesin -= 0.5;
  pg.endDraw();
    
  image(pg, 0,0);
}