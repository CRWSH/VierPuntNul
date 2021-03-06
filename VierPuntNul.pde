// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #116: Lissajous Curve Table
// https://youtu.be/--6eyLO78CY

// p5.js version:
// https://editor.p5js.org/codingtrain/sketches/BJbj5l3Y7
import com.hamoid.*;

import geomerative.*;

VideoExport videoExport;

RShape vier, punt, nul;


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

float strokeweight, sqwidth;

float dampening = 0.999;
boolean even = true;

int resolution = 3;
color white, black, blue;




void setup() {
  size(800, 800, P2D);
  white = color(255); 
  blue = color(44,  0,  184);  
  black = color(0);
  
  background(0);
  pg = createGraphics(width,height);
  font = createFont("Grand National Italic", 120);
  RG.init(this);
  vier = RG.getText("Vier", "grandnationalital.ttf", height*120/800, LEFT);
  punt = RG.getText("Punt", "grandnationalital.ttf", height*120/800, CENTER);
  nul = RG.getText("Nul", "grandnationalital.ttf", height*120/800, RIGHT);
  
 
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
  
  cols = width/resolution;
  rows = height/resolution;
  current = new float[cols][rows];
  previous = new float[cols][rows];
  
  strokeweight = 2/800.0*height;
  println(strokeweight);
  sqwidth = 40/800.0*height;
  
  
  
  frameRate(25);
  //smooth();
  //videoExport = new VideoExport(this);
  //videoExport.startMovie();
}

void draw() {
  
  if(frameCount%3 == 0) {
    //println("x");
    even = (frameCount%2 == 0);
    for (int i = 1; i < cols-1; i++) {
      for (int j = 1; j < rows-1; j++) {
        if (true) { 
          current[i][j] = (
            previous[i-1][j] + 
            previous[i+1][j] +
            previous[i][j-1] + 
            previous[i][j+1]) / 2 -
            current[i][j];
        }
        current[i][j] = current[i][j] * dampening;
        int index = i + j * cols;
        if(i*resolution>c1.x && i*resolution<c2.x && j*resolution>c1.y && j*resolution<c3.y) {
          if(current[i][j]>=0.5) {
            
            fill(lerpColor(blue,white, (current[i][j]-0.5)*2));
          } else {
            fill(lerpColor(black,blue, current[i][j]*2));
          }
          
        } else {
          if(current[i][j]>=0.5) {
            fill(lerpColor(blue,white, 0.05 -(current[i][j]-0.5)*2)) ; 
          } else {
            fill(lerpColor(black,blue, 0.05-current[i][j]*2));
          }
      }
      noStroke();
      rect(i*resolution,j*resolution, resolution,resolution);
    }
    }
  
  

  float[][] temp = previous;
  previous = current;
  current = temp;
  }
    
  
    pg.beginDraw();
  
    pg.background(0,10);
    pg.fill(255);
    pg.stroke(0);
    pg.strokeWeight(strokeweight);
    pg.rectMode(CENTER);
    
    pg.pushMatrix();
    pg.translate(c1.x, c1.y);
    pg.rotate(QUARTER_PI);
    pg.rect(0,0, sqwidth, sqwidth);
    pg.popMatrix();
    
    pg.pushMatrix();
    pg.translate(c2.x, c2.y);
    pg.rotate(QUARTER_PI);
    pg.rect(0,0, sqwidth, sqwidth);
    pg.popMatrix();
    
    pg.pushMatrix();
    pg.translate(c3.x, c3.y);
    pg.rotate(QUARTER_PI);
    pg.rect(0,0, sqwidth, sqwidth);
    pg.popMatrix();
    
    pg.pushMatrix();
    pg.translate(c4.x, c4.y);
    pg.rotate(QUARTER_PI);
    pg.rect(0,0, sqwidth, sqwidth);
    pg.popMatrix();
    
    //pg.noFill();
    //pg.stroke(255);
    //pg.strokeWeight(1);
    
    //pg.line(c1.x, c1.y,c2.x, c2.y);
    //pg.line(c2.x, c2.y,c3.x, c3.y);
    //pg.line(c3.x, c3.y,c4.x, c4.y);
    //pg.line(c4.x, c4.y,c1.x, c1.y);
    //pg.line(c1.x, c1.y,c3.x, c3.y);
    //pg.line(c2.x, c2.y,c4.x, c4.y);
    
    
    float x2 = height/40*sin(anglesin);
    
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
    
    //curve[i].setX(x);
    //curve[i].setY(y);
    
    previous[int(x/resolution)][int(y/resolution)]=1;
  
    
    
    pg.noFill();
    pg.stroke(255);
    
    //curve[i].addPoint();
    //curve[i].show();
    
  
    anglelis[i] -= 0.0025;
  }
  anglesin -= 0.25;

  pg.endDraw();
    
  image(pg, 0,0);
  
  fill(255);
  stroke(0);
  strokeWeight(strokeweight);
  
  pushMatrix();
  translate(c1.x+width*2/100, c1.y+height*13/100);
  vier.draw();
  popMatrix();
  
  pushMatrix();
  translate(cx, cy+height*4/100);
  punt.draw();
  popMatrix();
  
  pushMatrix();
  translate(c3.x-width*3/100, c3.y-height*4/100);
  nul.draw();
  popMatrix();
  
  //fill(255,20);
  //noStroke();
  //text("Vier\nPunt\nNul", cx, cy);
  //videoExport.saveFrame();
  
}

void keyPressed() {
  if (key == 'q') {
    //videoExport.endMovie();
    exit();
  }
}