// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #116: Lissajous Curve Table
// https://youtu.be/--6eyLO78CY

// p5.js version:
// https://editor.p5js.org/codingtrain/sketches/BJbj5l3Y7

float[] anglelis = {0,HALF_PI,PI,PI + HALF_PI};
float anglesin = 0; 
int w = 650;
float mult1 = 5;
Curve[] curve = new Curve[4];
PGraphics pg;
float cx,cy,d,r;
float[] x1old, y1old, x1 = {0,0,0,0}, y1 = {0,0,0,0};
PVector c1, c2, c3, c4;
PFont font;

int cols;
int rows;
float[][] current;// = new float[cols][rows];
float[][] previous;// = new float[cols][rows];

float dampening = 0.999;

int resolution = 2;


void setup() {
  size(800, 800, P2D);
  
  background(0);
  pg = createGraphics(width,height);
  font = createFont("Grand National Semi-Italic", 100);
 
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
  
  cols = width;
  rows = height;
  current = new float[cols][rows];
  previous = new float[cols][rows];
  
  frameRate(25);
  //smooth();
  
}

void draw() {
  loadPixels();
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
      current[i][j] = (
        previous[i-1][j] + 
        previous[i+1][j] +
        previous[i][j-1] + 
        previous[i][j+1]) / 2 -
        current[i][j];
      current[i][j] = current[i][j] * dampening;
      int index = i + j * cols;
      if(i>c1.x && i<c2.x && j>c1.y && j<c3.y) {
        pixels[index] = color(current[i][j]);
      } else {
        pixels[index] = color(10-current[i][j]);
      }
      
    }
  }
  updatePixels();

  float[][] temp = previous;
  previous = current;
  current = temp;
    
  
    pg.beginDraw();
    
    
    //pg.stroke(255);
    
    
    pg.background(0,10);
    pg.fill(255);
    pg.noStroke();
    pg.ellipse(c1.x, c1.y, 40, 40);
    pg.ellipse(c2.x, c2.y, 40, 40);
    pg.ellipse(c3.x, c3.y, 40, 40);
    pg.ellipse(c4.x, c4.y, 40, 40);
  
    //pg.noFill();
    //pg.stroke(255);
    //pg.strokeWeight(1);
    
    //pg.line(c1.x, c1.y,c2.x, c2.y);
    //pg.line(c2.x, c2.y,c3.x, c3.y);
    //pg.line(c3.x, c3.y,c4.x, c4.y);
    //pg.line(c4.x, c4.y,c1.x, c1.y);
    //pg.line(c1.x, c1.y,c3.x, c3.y);
    //pg.line(c2.x, c2.y,c4.x, c4.y);
    
    
    float x2 = width/40*sin(anglesin);
    
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
    
    float x = cx + x1[i] + sl.x;
    float y = cy + y1[i] + sl.y;
    
    curve[i].setX(x);
    curve[i].setY(y);
    previous[int(x)][int(y)]=500;
    
    
    pg.noFill();
    pg.stroke(255);
    
    curve[i].addPoint();
    curve[i].show();
    
  
    anglelis[i] -= 0.005;
  }
  anglesin -= 0.5;
  
  pg.textFont(font);
  pg.textAlign(CENTER,CENTER);
  pg.stroke(0);
  //pg.noStroke();
  pg.fill(255);
  pg.text("Punt", cx+width*3/100, cy-height*3/100);
  pg.textAlign(LEFT,TOP);
  pg.text("Vier", c1.x+width*3/100, c1.y-height*1/100);
  pg.textAlign(RIGHT,BOTTOM);
  pg.text("Nul", c3.x-width*3/100, c3.y-height*1/100);
  
  
  pg.endDraw();
    
  image(pg, 0,0);
  //fill(255,20);
  //noStroke();
  //text("Vier\nPunt\nNul", cx, cy);
  
}