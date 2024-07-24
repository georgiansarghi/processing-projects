import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;

PeasyCam cam;
ArrayList<PVector> points;

float a = 0.2;
float b = 0.2;
float c = 5.7;

PVector current;

float scl = 14;
float hue = 0;
float generationRate = 1000;

boolean rotate = false;
float rotationValue = 0;


boolean saving = false;;

void setup() {
  size(2048, 2048, P3D);
  noFill();
  //colorMode(HSB);
  //textFont(createFont("Monospaced", 10));
  
  cam = new PeasyCam(this, 960);
  points = new ArrayList<PVector>();
  
  resetSimulation();
}

void draw() {
  background(255);
 
  //rotateX(-90);
  if(rotate) {
    rotateY(rotationValue);
    rotationValue += 0.001;
  } else {
    rotateY(rotationValue);
  }
  
  if (points.size() < 100000) {
    for (int i = 0; i < generationRate; i++) {
      points.add(current);
      current = rossler(current);
    }
  }

  beginShape();
  hue = 0;
  for (PVector p : points) {
    //stroke(hue, 196, 196);
    stroke(0, 0, 0, 64);
    vertex(p.x*scl, p.y*scl, p.z*scl);
    //hue += 0.1;
    //if (hue > 255) {
    //  hue = 0;
    //}
  }
  endShape();
  
  
  if(saving) {
    saving = false;
    save((int)random(1000) + "rossler.png");
  }
 
  println(frameRate);
}

PVector rossler(PVector l) {
  float dx = -l.y - l.z;
  float dy = l.x + a * l.y;
  float dz = b + l.z * (l.x - c);

  PVector n = new PVector();

  n.x = l.x + dx * .005;
  n.y = l.y + dy * .005;
  n.z = l.z + dz * .005;

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
    saving = true;
  }
  
  generationRate = constrain(generationRate, 1, 1000);
}


void resetSimulation() {
  points.clear();
  current = new PVector(1, 1, 1);
}