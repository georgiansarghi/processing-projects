import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;

PeasyCam cam;
ArrayList<PVector> points;

float a = 10;
float b = 28;
float c = 8./3;

PVector current;

float scl = 8;
float hue = 0;
float generationRate = 100;

boolean rotate = false;
float rotationValue = 0;

void setup() {
  size(960, 720, P3D);
  noFill();
  //fullScreen(P3D);
  //colorMode(HSB);
  //textFont(createFont("Monospaced", 10));
  
  cam = new PeasyCam(this, 960);
  points = new ArrayList<PVector>();
  
  resetSimulation();
  smooth(8);
}

void draw() {
  background(255);
  
  if(rotate) {
    rotateY(rotationValue);
    rotationValue += 0.001;
  } else {
    rotateY(rotationValue);
  }
  
  
  translate(0, 0, -200);

  
  if (points.size() < 1000000) {
    for (int i = 0; i < generationRate; i++) {
      points.add(current);
      current = lorenz(current);
    }
  }

  beginShape();
  hue = 0;
  for (PVector p : points) {
    //stroke(hue, 196, 196);
    stroke(0, 0, 0, 128);
    vertex(p.x*scl, p.y*scl, p.z*scl);
    hue += 0.001;
    if (hue > 255) {
      hue = 0;
    }
  }
 endShape();
 
  println(frameRate);
}

PVector lorenz(PVector l) {
  float dx = a * (l.y - l.x);
  float dy = l.x * (b - l.z) - l.y;
  float dz = l.x * l.y - c * l.z;

  PVector n = new PVector();

  n.x = l.x + dx * .001;
  n.y = l.y + dy * .001;
  n.z = l.z + dz * .001;

  return n;
}

void keyPressed() {
  if (key == ' ') {
    resetSimulation();
  }else if(keyCode == UP) {
    generationRate *= 1.33333;
  } else if(keyCode == DOWN ) {
    generationRate *= 0.66666;
  } else if(key == 'r') {
    rotate = !rotate;
  } else if(key == 's') {
    save("lorenzattractor.png");
  }
  
  generationRate = constrain(generationRate, 1, 1000);
}


void resetSimulation() {
  points.clear();
  current = new PVector(0.1, 0.1, 0.1);
}