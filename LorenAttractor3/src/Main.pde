import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;

PeasyCam cam;

ArrayList<ArrayList<PVector>> points;
ArrayList<PVector> distances;

float a = 10;
float b = 28;
float c = 2.66666666;


float scl = 10;
float hue = 0;
float generationRate = 1;

boolean rotate = false;
float rotationValue = 0;

void setup() {
  size(960, 720, P3D);

  noFill();
  colorMode(HSB);
  //textFont(createFont("Monospaced", 10));

  cam = new PeasyCam(this, 960);


  distances = new ArrayList<PVector>();

  points = new ArrayList<ArrayList<PVector>>();

  for (int i = 0; i < 2; i++) {
    points.add(new ArrayList<PVector>());
  }

  resetSimulation();
}


void draw() {
  background(255);


  if (rotate) {
    rotateY(rotationValue);
    rotationValue += 0.001;
  } else {
    rotateY(rotationValue);
  }

  for (PVector p : distances) {
    p.x--;
  }

  if (points.size() == 2) {
    PVector p1 = points.get(0).get(points.get(0).size()-1);
    PVector p2 = points.get(1).get(points.get(1).size()-1);
    float d = PVector.dist(p1, p2);
    distances.add(new PVector(width/2, height - (map(d, 0, 50, 50, 600))));
    print(d + " ");
  }


  stroke(0);
  beginShape();

  for (PVector p : distances) {
    vertex(p.x, p.y, 0);
    //ellipse(p.x, p.y);
  }
  endShape();



  translate(0, 0, -200);

  for (int r = 0; r < generationRate; r++) {
    for (ArrayList<PVector> alp : points) {
      PVector current = alp.get(alp.size()-1);
      current = lorenz(current);
      alp.add(current);

      while (alp.size() > 100) {
        alp.remove(0);
      }


      beginShape();
      //hue = 0;
      for (PVector p : alp) {
        stroke(0);
        vertex(p.x*scl, p.y*scl, p.z*scl);
        //hue += 1;
        //if (hue > 255) {
        //  hue = 0;
        //}
      }
      endShape();
    }
  }

  println(frameRate);
}

PVector lorenz(PVector l) {
  float dx = a * (l.y - l.x);
  float dy = l.x * (b - l.z) - l.y;
  float dz = l.x * l.y - c * l.z;

  PVector n = new PVector();

  n.x = l.x + dx * .005;
  n.y = l.y + dy * .005;
  n.z = l.z + dz * .005;

  return n;
}

void keyPressed() {
  if (key == ' ') {
    resetSimulation();
    //} else if(keyCode == UP) {
    //  generationRate *= 1.33333;
    //} else if(keyCode == DOWN ) {
    //  generationRate *= 0.66666;
  } else if (key == 'r') {
    rotate = !rotate;
  }

  //generationRate = constrain(generationRate, 1, 1000);
}


void resetSimulation() {

  for (ArrayList<PVector> alp : points) {
    alp.clear();
    alp.add(new PVector(0.1, 0.1, random(0.00001)));
  }

  //current = new PVector(0.1, 0.1, 0.1);
}